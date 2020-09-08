// Copyright 2019 Drone.IO Inc. All rights reserved.
// Use of this source code is governed by the Drone Non-Commercial License
// that can be found in the LICENSE file.

package yaml

import "testing"

func TestRegistryUnmarshal(t *testing.T) {
	diff, err := diff("testdata/registry.yml")
	if err != nil {
		t.Error(err)
	}
	if diff != "" {
		t.Error("Failed to parse registry")
		t.Log(diff)
	}
}

func TestRegistryValidate(t *testing.T) {
	registry := new(Registry)

	registry.Data = map[string]string{"index.drone.io": ""}
	if err := registry.Validate(); err != nil {
		t.Error(err)
		return
	}

	registry.Data = map[string]string{}
	if err := registry.Validate(); err == nil {
		t.Errorf("Expect invalid registry error")
	}

	registry.Data = nil
	if err := registry.Validate(); err == nil {
		t.Errorf("Expect invalid registry error")
	}
}
