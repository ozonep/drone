# defines the target version of Go. Please do not
# update this variable unless it has been previously
# approved on the mailing list.
local image_golang = 'golang:1.15.1';
local image_manifest = 'plugins/manifest:1.2';
local image_docker = 'plugins/docker:18';

// defines a pipeline step that builds and publishes
// a docker image to a docker remote registry.
local publish(image, os, arch) = {
  name: 'publish',
  image: image_docker,
  settings: {
    repo: 'drone/drone',
    auto_tag: true,
    auto_tag_suffix: os + '-' + arch,
    username: {
      from_secret: 'docker_username',
    },
    password: {
      from_secret: 'docker_password',
    },
    dockerfile: 'docker/Dockerfile.server.' + os + '.' + arch,
  },
};


// defines a pipeline step that creates and publishes
// a docker manifest to a docker remote registry.
local manifest() = {
  name: 'publish',
  image: image_manifest,
  settings: {
    auto_tag: true,
    ignore_missing: true,
    spec: 'docker/manifest.server.tmpl',
    username: {
      from_secret: 'docker_username',
    },
    password: {
      from_secret: 'docker_password',
    },
  },
};

// defines a pipeline that builds, tests and publishes
// docker images for the Drone agent, server and controller.
local pipeline(name, os, arch) = {
  kind: 'pipeline',
  type: 'docker',
  name: name,
  platform: {
    arch: arch,
    os: os,
  },
  steps: [
    {
      name: 'test',
      image: image_golang,
      environment: {
        GOARCH: arch,
        GOOS: os,
      },
      commands: [
        'go test ./...',
      ],
    },
    {
      name: 'build',
      image: image_golang,
      environment: {
        GOARCH: arch,
        GOOS: os,
      },
      commands: [
        'sh scripts/build.sh',
      ],
    },
    publish('drone', os, arch),
  ],
  trigger: {
    event: [
      'push',
      'tag',
    ],
  },
};

[
  pipeline('linux-amd64', 'linux', 'amd64'),
  pipeline('linux-arm64', 'linux', 'arm64'),
  pipeline('linux-arm', 'linux', 'arm'),
  {
    kind: 'pipeline',
    name: 'manifest',
    steps: [
      manifest(),
    ],
    trigger: {
      event: [
        'push',
        'tag',
      ],
    },
    depends_on: [
      'linux-amd64',
      'linux-arm64',
      'linux-arm',
    ],
  },
]
