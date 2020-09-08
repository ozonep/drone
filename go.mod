module github.com/ozonep/drone

replace github.com/docker/docker => github.com/docker/engine v17.12.0-ce-rc1.0.20200309214505-aa6a9891b09c+incompatible

require (
	docker.io/go-docker v1.0.0 // indirect
	github.com/99designs/httpsignatures-go v0.0.0-20170731043157-88528bf4ca7e
	github.com/Azure/azure-storage-blob-go v0.10.0
	github.com/Azure/go-autorest/autorest/adal v0.9.2 // indirect
	github.com/Microsoft/go-winio v0.4.15-0.20200113171025-3fe6c5262873 // indirect
	github.com/asaskevich/govalidator v0.0.0-20180315120708-ccb8e960c48f
	github.com/aws/aws-sdk-go v1.25.41
	github.com/codegangsta/negroni v1.0.0 // indirect
	github.com/coreos/go-semver v0.3.0
	github.com/dchest/authcookie v0.0.0-20120917135355-fbdef6e99866
	github.com/dchest/uniuri v0.0.0-20160212164326-8902c56451e9
	github.com/dgrijalva/jwt-go v3.2.0+incompatible
	github.com/docker/docker v17.12.0-ce-rc1.0.20200330121334-7f8b4b621b5d+incompatible // indirect
	github.com/docker/go-connections v0.4.0 // indirect
	github.com/docker/go-units v0.4.0 // indirect
	github.com/drone/drone-go v1.3.2
	github.com/drone/drone-runtime v0.0.0-20190210191445-ad403a0ca24e
	github.com/drone/drone-yaml v1.0.6
	github.com/drone/envsubst v1.0.3-0.20200709231038-aa43e1c1a629
	github.com/drone/go-license v1.0.2
	github.com/drone/go-login v1.0.4-0.20190311170324-2a4df4f242a2
	github.com/drone/signal v1.0.0
	github.com/dustin/go-humanize v1.0.0
	github.com/go-chi/chi v3.3.3+incompatible
	github.com/go-chi/cors v1.0.0
	github.com/go-sql-driver/mysql v1.4.0
	github.com/golang/mock v1.3.1
	github.com/google/go-cmp v0.4.0
	github.com/google/go-jsonnet v0.12.1
	github.com/google/wire v0.2.1
	github.com/gorilla/websocket v1.4.2 // indirect
	github.com/gosimple/slug v1.3.0
	github.com/h2non/gock v1.0.15
	github.com/hashicorp/go-multierror v1.1.0
	github.com/hashicorp/go-retryablehttp v0.5.4
	github.com/hashicorp/golang-lru v0.5.4
	github.com/hashicorp/nomad/api v0.0.0-20200529203653-c4416b26d3eb
	github.com/imdario/mergo v0.3.8 // indirect
	github.com/jmoiron/sqlx v0.0.0-20180614180643-0dae4fefe7c0
	github.com/joho/godotenv v1.3.0
	github.com/kelseyhightower/envconfig v1.3.0
	github.com/kr/text v0.2.0 // indirect
	github.com/lib/pq v1.1.0
	github.com/mattn/go-sqlite3 v1.14.2
	github.com/mitchellh/go-testing-interface v1.14.1 // indirect
	github.com/natessilva/dag v0.0.0-20180124060714-7194b8dcc5c4 // indirect
	github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e // indirect
	github.com/opencontainers/image-spec v1.0.1 // indirect
	github.com/oxtoacart/bpool v0.0.0-20150712133111-4e1c5567d7c2
	github.com/prometheus/client_golang v1.4.0
	github.com/rainycape/unidecode v0.0.0-20150907023854-cb7f23ec59be // indirect
	github.com/robfig/cron v0.0.0-20180505203441-b41be1df6967
	github.com/segmentio/ksuid v1.0.2
	github.com/sirupsen/logrus v1.6.0
	github.com/unrolled/secure v0.0.0-20181022170031-4b6b7cf51606
	golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9
	golang.org/x/oauth2 v0.0.0-20200107190931-bf48bf16ab8d // indirect
	golang.org/x/sync v0.0.0-20200317015054-43a5402ce75a
	google.golang.org/appengine v1.6.6 // indirect
	gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f // indirect
	gopkg.in/yaml.v2 v2.3.0
	gotest.tools v2.2.0+incompatible // indirect
	k8s.io/api v0.19.0
	k8s.io/apimachinery v0.19.0
	k8s.io/client-go v0.19.0
	k8s.io/utils v0.0.0-20200821003339-5e75c0163111 // indirect
)

replace github.com/h2non/gock => gopkg.in/h2non/gock.v1 v1.0.14

go 1.15
