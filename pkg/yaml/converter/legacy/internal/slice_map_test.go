// Copyright 2019 Drone.IO Inc. All rights reserved.
// Use of this source code is governed by the Drone Non-Commercial License
// that can be found in the LICENSE file.

package yaml

import (
	"reflect"
	"testing"

	"github.com/buildkite/yaml"
)

func TestMapSlice(t *testing.T) {
	var tests = []struct {
		yaml string
		want map[string]string
	}{
		{
			yaml: "[ foo=bar, baz=qux ]",
			want: map[string]string{"foo": "bar", "baz": "qux"},
		},
		{
			yaml: "{ foo: bar, baz: qux }",
			want: map[string]string{"foo": "bar", "baz": "qux"},
		},
	}

	for _, test := range tests {
		var got SliceMap

		if err := yaml.Unmarshal([]byte(test.yaml), &got); err != nil {
			t.Error(err)
		}

		if !reflect.DeepEqual(got.Map, test.want) {
			t.Errorf("Got map %v want %v", got, test.want)
		}
	}

	var got SliceMap
	if err := yaml.Unmarshal([]byte("1"), &got); err == nil {
		t.Errorf("Want error unmarshaling invalid map value.")
	}
}
