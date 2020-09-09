// Copyright 2018 Drone.IO Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package secret

import (
	"bytes"
	"context"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"

	"github.com/ozonep/drone/pkg/drone"
	"github.com/ozonep/drone/pkg/drone/plugin/internal/aesgcm"

	"github.com/99designs/httpsignatures-go"
)

func TestHandler(t *testing.T) {
	key := "xVKAGlWQiY3sOp8JVc0nbuNId3PNCgWh"

	buf := new(bytes.Buffer)
	json.NewEncoder(buf).Encode(&Request{
		Name: "docker_password",
	})

	res := httptest.NewRecorder()
	req := httptest.NewRequest("GET", "/", buf)
	req.Header.Add("Date", time.Now().UTC().Format(http.TimeFormat))

	err := httpsignatures.DefaultSha256Signer.AuthRequest("hmac-key", key, req)
	if err != nil {
		t.Error(err)
		return
	}

	want := &drone.Secret{
		Name: "docker_password",
		Data: "correct-horse-battery-staple",
	}
	plugin := &mockPlugin{
		res: want,
		err: nil,
	}

	handler := Handler(key, plugin, nil)
	handler.ServeHTTP(res, req)

	if got, want := res.Code, 200; got != want {
		t.Errorf("Want status code %d, got %d", want, got)
	}

	resp := &drone.Secret{}
	json.Unmarshal(res.Body.Bytes(), resp)
	if got, want := resp.Name, want.Name; got != want {
		t.Errorf("Want secret name %s, got %s", want, got)
	}
}

func TestHandler_Encrypted(t *testing.T) {
	key := "xVKAGlWQiY3sOp8JVc0nbuNId3PNCgWh"

	buf := new(bytes.Buffer)
	json.NewEncoder(buf).Encode(&Request{
		Name: "docker_password",
	})

	res := httptest.NewRecorder()
	req := httptest.NewRequest("GET", "/", buf)
	req.Header.Add("Date", time.Now().UTC().Format(http.TimeFormat))
	req.Header.Add("Accept-Encoding", "aesgcm")

	err := httpsignatures.DefaultSha256Signer.AuthRequest("hmac-key", key, req)
	if err != nil {
		t.Error(err)
		return
	}

	want := &drone.Secret{
		Name: "docker_password",
		Data: "correct-horse-battery-staple",
	}
	plugin := &mockPlugin{
		res: want,
		err: nil,
	}

	handler := Handler(key, plugin, nil)
	handler.ServeHTTP(res, req)

	if got, want := res.Code, 200; got != want {
		t.Errorf("Want status code %d, got %d", want, got)
	}
	if got, want := res.Header().Get("Content-Encoding"), "aesgcm"; got != want {
		t.Errorf("Want Content-Encoding %s, got %s", want, got)
	}
	if got, want := res.Header().Get("Content-Type"), "application/octet-stream"; got != want {
		t.Errorf("Want Content-Type %s, got %s", want, got)
	}

	keyb, err := aesgcm.Key(key)
	if err != nil {
		t.Error(err)
		return
	}
	body, err := aesgcm.Decrypt(res.Body.Bytes(), keyb)
	if err != nil {
		t.Error(err)
		return
	}

	resp := &drone.Secret{}
	json.Unmarshal(body, resp)
	if got, want := resp.Name, want.Name; got != want {
		t.Errorf("Want secret name %s, got %s", want, got)
	}
}

func TestHandler_MissingSignature(t *testing.T) {
	res := httptest.NewRecorder()
	req := httptest.NewRequest("GET", "/", nil)

	handler := Handler("xVKAGlWQiY3sOp8JVc0nbuNId3PNCgWh", nil, nil)
	handler.ServeHTTP(res, req)

	got, want := res.Body.String(), "Invalid or Missing Signature\n"
	if got != want {
		t.Errorf("Want response body %q, got %q", want, got)
	}
}

func TestHandler_InvalidSignature(t *testing.T) {
	sig := `keyId="hmac-key",algorithm="hmac-sha256",signature="QrS16+RlRsFjXn5IVW8tWz+3ZRAypjpNgzehEuvJksk=",headers="(request-target) accept accept-encoding content-type date digest"`
	res := httptest.NewRecorder()
	req := httptest.NewRequest("GET", "/", nil)
	req.Header.Set("Signature", sig)

	handler := Handler("xVKAGlWQiY3sOp8JVc0nbuNId3PNCgWh", nil, nil)
	handler.ServeHTTP(res, req)

	got, want := res.Body.String(), "Invalid Signature\n"
	if got != want {
		t.Errorf("Want response body %q, got %q", want, got)
	}
}

type mockPlugin struct {
	res *drone.Secret
	err error
}

func (m *mockPlugin) Find(ctx context.Context, req *Request) (*drone.Secret, error) {
	return m.res, m.err
}
