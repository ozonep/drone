// Copyright 2019 Drone.IO Inc. All rights reserved.
// Use of this source code is governed by the Drone Non-Commercial License
// that can be found in the LICENSE file.

package transform

import (
	"testing"

	"github.com/drone/drone-runtime/engine"
	"github.com/google/go-cmp/cmp"
)

func TestWithEnviron(t *testing.T) {
	step := &engine.Step{
		Metadata: engine.Metadata{
			UID:  "1",
			Name: "build",
		},
		Envs: map[string]string{},
	}
	spec := &engine.Spec{
		Steps: []*engine.Step{step},
	}
	envs := map[string]string{
		"GOOS":   "linux",
		"GOARCH": "amd64",
	}
	WithEnviron(envs)(spec)
	if diff := cmp.Diff(envs, step.Envs); diff != "" {
		t.Errorf("Unexpected transform")
		t.Log(diff)
	}
}
