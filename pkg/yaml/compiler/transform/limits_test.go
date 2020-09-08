// Copyright the Drone Authors.
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

package transform

import (
	"testing"

	"github.com/drone/drone-runtime/engine"
)

func TestWithLimits(t *testing.T) {
	step := &engine.Step{
		Metadata: engine.Metadata{
			UID:  "1",
			Name: "build",
		},
		Docker: &engine.DockerStep{},
	}
	spec := &engine.Spec{
		Steps: []*engine.Step{step},
	}
	WithLimits(1, 2)(spec)
	if got, want := step.Resources.Limits.Memory, int64(1); got != want {
		t.Errorf("Want memory limit %v, got %v", want, got)
	}
	if got, want := step.Resources.Limits.CPU, int64(2); got != want {
		t.Errorf("Want cpu limit %v, got %v", want, got)
	}
}

func TestWithNoLimits(t *testing.T) {
	step := &engine.Step{
		Metadata: engine.Metadata{
			UID:  "1",
			Name: "build",
		},
		Docker: &engine.DockerStep{},
	}
	spec := &engine.Spec{
		Steps: []*engine.Step{step},
	}
	WithLimits(0, 0)(spec)
	if step.Resources != nil {
		t.Errorf("Expect no limits applied")
	}
}
