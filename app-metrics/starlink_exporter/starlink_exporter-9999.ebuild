# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module go-env systemd

DESCRIPTION="prometheus exporter for starlink metrics"
HOMEPAGE="https://github.com/danopstech/starlink_exporter"
if [[ $PV == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI=https://github.com/clarkzjw/starlink_exporter.git
else
	SRC_URI="https://github.com/clarkzjw/starlink_exporter/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

EGO_SUM=(
	"github.com/beorn7/perks v1.0.1"
	"github.com/beorn7/perks v1.0.1/go.mod"
	"github.com/cespare/xxhash/v2 v2.3.0"
	"github.com/cespare/xxhash/v2 v2.3.0/go.mod"
	"github.com/clarkzjw/starlink-grpc-golang v1.0.20250818"
	"github.com/clarkzjw/starlink-grpc-golang v1.0.20250818/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/go-logr/logr v1.4.3"
	"github.com/go-logr/logr v1.4.3/go.mod"
	"github.com/go-logr/stdr v1.2.2"
	"github.com/go-logr/stdr v1.2.2/go.mod"
	"github.com/golang/protobuf v1.5.4"
	"github.com/golang/protobuf v1.5.4/go.mod"
	"github.com/google/go-cmp v0.7.0"
	"github.com/google/go-cmp v0.7.0/go.mod"
	"github.com/google/uuid v1.6.0"
	"github.com/google/uuid v1.6.0/go.mod"
	"github.com/klauspost/compress v1.18.0"
	"github.com/klauspost/compress v1.18.0/go.mod"
	"github.com/kylelemons/godebug v1.1.0"
	"github.com/kylelemons/godebug v1.1.0/go.mod"
	"github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822"
	"github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/prometheus/client_golang v1.23.0"
	"github.com/prometheus/client_golang v1.23.0/go.mod"
	"github.com/prometheus/client_model v0.6.2"
	"github.com/prometheus/client_model v0.6.2/go.mod"
	"github.com/prometheus/common v0.65.0"
	"github.com/prometheus/common v0.65.0/go.mod"
	"github.com/prometheus/procfs v0.17.0"
	"github.com/prometheus/procfs v0.17.0/go.mod"
	"github.com/sirupsen/logrus v1.9.3"
	"github.com/sirupsen/logrus v1.9.3/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"go.opentelemetry.io/auto/sdk v1.1.0"
	"go.opentelemetry.io/auto/sdk v1.1.0/go.mod"
	"go.opentelemetry.io/otel v1.36.0"
	"go.opentelemetry.io/otel v1.36.0/go.mod"
	"go.opentelemetry.io/otel/metric v1.36.0"
	"go.opentelemetry.io/otel/metric v1.36.0/go.mod"
	"go.opentelemetry.io/otel/sdk v1.36.0"
	"go.opentelemetry.io/otel/sdk v1.36.0/go.mod"
	"go.opentelemetry.io/otel/sdk/metric v1.36.0"
	"go.opentelemetry.io/otel/sdk/metric v1.36.0/go.mod"
	"go.opentelemetry.io/otel/trace v1.36.0"
	"go.opentelemetry.io/otel/trace v1.36.0/go.mod"
	"go.uber.org/goleak v1.3.0"
	"go.uber.org/goleak v1.3.0/go.mod"
	"golang.org/x/net v0.43.0"
	"golang.org/x/net v0.43.0/go.mod"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8/go.mod"
	"golang.org/x/sys v0.35.0"
	"golang.org/x/sys v0.35.0/go.mod"
	"golang.org/x/text v0.28.0"
	"golang.org/x/text v0.28.0/go.mod"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20250818200422-3122310a409c"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20250818200422-3122310a409c/go.mod"
	"google.golang.org/grpc v1.74.2"
	"google.golang.org/grpc v1.74.2/go.mod"
	"google.golang.org/protobuf v1.36.7"
	"google.golang.org/protobuf v1.36.7/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals
SRC_URI+="${EGO_SUM_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

PATCHES=( "${FILESDIR}/${P}-localhost.patch" )

src_install() {
	dobin ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
