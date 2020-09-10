// Copyright 2019 Drone.IO Inc. All rights reserved.
// Use of this source code is governed by the Drone Non-Commercial License
// that can be found in the LICENSE file.

package kube

import (
	"k8s.io/apimachinery/pkg/api/resource"
)

var defaultVolumeSize = resource.MustParse("5Gi")
