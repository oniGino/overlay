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
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/golang/protobuf v1.5.0/go.mod"
	"github.com/golang/protobuf v1.5.3"
	"github.com/golang/protobuf v1.5.3/go.mod"
	"github.com/google/go-cmp v0.5.5/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/klauspost/compress v1.17.9"
	"github.com/klauspost/compress v1.17.9/go.mod"
	"github.com/kylelemons/godebug v1.1.0"
	"github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822"
	"github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/prometheus/client_golang v1.20.5"
	"github.com/prometheus/client_golang v1.20.5/go.mod"
	"github.com/prometheus/client_model v0.6.1"
	"github.com/prometheus/client_model v0.6.1/go.mod"
	"github.com/prometheus/common v0.55.0"
	"github.com/prometheus/common v0.55.0/go.mod"
	"github.com/prometheus/procfs v0.15.1"
	"github.com/prometheus/procfs v0.15.1/go.mod"
	"github.com/sirupsen/logrus v1.9.3"
	"github.com/sirupsen/logrus v1.9.3/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/stretchr/testify v1.9.0"
	"golang.org/x/net v0.26.0"
	"golang.org/x/net v0.26.0/go.mod"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8/go.mod"
	"golang.org/x/sys v0.22.0"
	"golang.org/x/sys v0.22.0/go.mod"
	"golang.org/x/text v0.16.0"
	"golang.org/x/text v0.16.0/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20230525234030-28d5490b6b19"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20230525234030-28d5490b6b19/go.mod"
	"google.golang.org/grpc v1.57.0"
	"google.golang.org/grpc v1.57.0/go.mod"
	"google.golang.org/protobuf v1.26.0-rc.1/go.mod"
	"google.golang.org/protobuf v1.26.0/go.mod"
	"google.golang.org/protobuf v1.35.1"
	"google.golang.org/protobuf v1.35.1/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
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
	dodoc docs/README.md
}
