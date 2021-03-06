// Copyright 2019 Drone IO, Inc.
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

import "github.com/ozonep/drone/pkg/runtime/engine"

// WithNetworks is a transform function that attaches a
// list of user-defined Docker networks to each step.
func WithNetworks(networks []string) func(*engine.Spec) {
	return func(spec *engine.Spec) {
		for _, step := range spec.Steps {
			step.Docker.Networks = append(
				step.Docker.Networks, networks...)
		}
	}
}
