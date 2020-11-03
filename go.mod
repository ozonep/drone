module github.com/ozonep/drone

replace github.com/docker/docker => github.com/docker/engine v17.12.0-ce-rc1.0.20200309214505-aa6a9891b09c+incompatible

replace (
	github.com/googleapis/gnostic => github.com/googleapis/gnostic v0.4.0
	github.com/h2non/gock => gopkg.in/h2non/gock.v1 v1.0.14
	k8s.io/api => k8s.io/api v0.16.15
	k8s.io/apimachinery => k8s.io/apimachinery v0.16.15
	k8s.io/client-go => k8s.io/client-go v0.16.15
)

require (
	github.com/99designs/httpsignatures-go v0.0.0-20170731043157-88528bf4ca7e
	github.com/Azure/azure-pipeline-go v0.2.3 // indirect
	github.com/Azure/azure-storage-blob-go v0.10.0
	github.com/Azure/go-ansiterm v0.0.0-20170929234023-d6e3b3328b78 // indirect
	github.com/Azure/go-autorest/autorest/adal v0.9.5 // indirect
	github.com/Microsoft/go-winio v0.4.15-0.20200908182639-5b44b70ab3ab // indirect
	github.com/asaskevich/govalidator v0.0.0-20200907205600-7a23bdc65eef
	github.com/aws/aws-sdk-go v1.35.7
	github.com/bmatcuk/doublestar v1.3.3
	github.com/buildkite/yaml v2.1.0+incompatible
	github.com/containerd/containerd v1.4.1 // indirect
	github.com/coreos/go-semver v0.3.0
	github.com/dchest/authcookie v0.0.0-20190824115100-f900d2294c8e
	github.com/dchest/uniuri v0.0.0-20200228104902-7aecb25e1fe5
	github.com/dgrijalva/jwt-go v3.2.0+incompatible
	github.com/docker/distribution v2.7.1+incompatible
	github.com/docker/docker v17.12.0-ce-rc1.0.20200330121334-7f8b4b621b5d+incompatible
	github.com/docker/go-connections v0.4.0 // indirect
	github.com/docker/go-units v0.4.0
	github.com/dustin/go-humanize v1.0.0
	github.com/ghodss/yaml v1.0.0
	github.com/go-chi/chi v4.1.2+incompatible
	github.com/go-chi/cors v1.1.1
	github.com/go-sql-driver/mysql v1.5.0
	github.com/gogo/protobuf v1.3.1 // indirect
	github.com/golang/mock v1.4.4
	github.com/google/go-cmp v0.5.2
	github.com/google/go-jsonnet v0.16.0
	github.com/google/gofuzz v1.2.0 // indirect
	github.com/google/wire v0.4.0
	github.com/googleapis/gnostic v0.4.0 // indirect
	github.com/gorilla/mux v1.8.0 // indirect
	github.com/gorilla/websocket v1.4.2 // indirect
	github.com/gosimple/slug v1.9.0
	github.com/h2non/gock v1.0.15
	github.com/hashicorp/cronexpr v1.1.1 // indirect
	github.com/hashicorp/go-multierror v1.1.0
	github.com/hashicorp/go-retryablehttp v0.6.7
	github.com/hashicorp/golang-lru v0.5.4
	github.com/hashicorp/nomad/api v0.0.0-20201102214658-c6f410f5512d
	github.com/imdario/mergo v0.3.11 // indirect
	github.com/jmoiron/sqlx v1.2.0
	github.com/joho/godotenv v1.3.0
	github.com/kelseyhightower/envconfig v1.4.0
	github.com/kr/pretty v0.2.1 // indirect
	github.com/kr/text v0.2.0 // indirect
	github.com/lib/pq v1.8.0
	github.com/mattn/go-isatty v0.0.12
	github.com/mattn/go-sqlite3 v1.14.4
	github.com/morikuni/aec v1.0.0 // indirect
	github.com/natessilva/dag v0.0.0-20180124060714-7194b8dcc5c4
	github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e // indirect
	github.com/opencontainers/go-digest v1.0.0 // indirect
	github.com/opencontainers/image-spec v1.0.1 // indirect
	github.com/oxtoacart/bpool v0.0.0-20190530202638-03653db5a59c
	github.com/prometheus/client_golang v1.7.1
	github.com/prometheus/common v0.13.0 // indirect
	github.com/robfig/cron v1.2.0
	github.com/segmentio/ksuid v1.0.3
	github.com/sergi/go-diff v1.1.0
	github.com/sirupsen/logrus v1.7.0
	github.com/stretchr/testify v1.6.1
	github.com/unrolled/secure v1.0.8
	github.com/vinzenz/yaml v0.0.0-20170920082545-91409cdd725d
	golang.org/x/crypto v0.0.0-20201016220609-9e8e0b390897
	golang.org/x/net v0.0.0-20201031054903-ff519b6c9102 // indirect
	golang.org/x/oauth2 v0.0.0-20200902213428-5d25da1a8d43 // indirect
	golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9
	golang.org/x/time v0.0.0-20200630173020-3af7569d3a1e // indirect
	google.golang.org/genproto v0.0.0-20201102152239-715cce707fb0 // indirect
	google.golang.org/grpc v1.33.1 // indirect
	gopkg.in/alecthomas/kingpin.v2 v2.2.6
	gopkg.in/check.v1 v1.0.0-20200902074654-038fdea0a05b // indirect
	gopkg.in/yaml.v2 v2.3.0
	gotest.tools v2.2.0+incompatible // indirect
	k8s.io/api v0.16.15
	k8s.io/apimachinery v0.16.15
	k8s.io/client-go v10.0.0+incompatible
	sigs.k8s.io/yaml v1.2.0 // indirect
)

go 1.15
