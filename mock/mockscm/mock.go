// Copyright 2019 Drone.IO Inc. All rights reserved.
// Use of this source code is governed by the Drone Non-Commercial License
// that can be found in the LICENSE file.

// +build !oss

package mockscm

//go:generate mockgen -package=mockscm -destination=mock_gen.go "github.com/ozonep/drone/pkg/scm" ContentService,GitService,OrganizationService,PullRequestService,RepositoryService,UserService
