# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module go-env systemd

# make sure these are updated based on the Makefile in every bump.
SHA=3ba0acb
GITVERSION=tags/v0.4.0-0-3ba0acb

DESCRIPTION="prometheus exporter for nftables metrics"
HOMEPAGE="https://github.com/metal-stack/nftables-exporter"
SRC_URI="https://github.com/metal-stack/nftables-exporter/archive/v${PV}.tar.gz -> ${P}.tar.gz"

EGO_SUM=(
    "github.com/beorn7/perks v1.0.1"
	"github.com/beorn7/perks v1.0.1/go.mod"
	"github.com/cespare/xxhash/v2 v2.3.0"
	"github.com/cespare/xxhash/v2 v2.3.0/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/klauspost/compress v1.17.11"
	"github.com/klauspost/compress v1.17.11/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/kylelemons/godebug v1.1.0"
	"github.com/kylelemons/godebug v1.1.0/go.mod"
	"github.com/metal-stack/v v1.0.3"
	"github.com/metal-stack/v v1.0.3/go.mod"
	"github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822"
	"github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/prometheus/client_golang v1.20.5"
	"github.com/prometheus/client_golang v1.20.5/go.mod"
	"github.com/prometheus/client_model v0.6.1"
	"github.com/prometheus/client_model v0.6.1/go.mod"
	"github.com/prometheus/common v0.60.1"
	"github.com/prometheus/common v0.60.1/go.mod"
	"github.com/prometheus/procfs v0.15.1"
	"github.com/prometheus/procfs v0.15.1/go.mod"
	"github.com/rogpeppe/go-internal v1.10.0"
	"github.com/rogpeppe/go-internal v1.10.0/go.mod"
	"github.com/stretchr/testify v1.9.0"
	"github.com/stretchr/testify v1.9.0/go.mod"
	"github.com/tidwall/gjson v1.18.0"
	"github.com/tidwall/gjson v1.18.0/go.mod"
	"github.com/tidwall/match v1.1.1"
	"github.com/tidwall/match v1.1.1/go.mod"
	"github.com/tidwall/pretty v1.2.0/go.mod"
	"github.com/tidwall/pretty v1.2.1"
	"github.com/tidwall/pretty v1.2.1/go.mod"
	"golang.org/x/sys v0.27.0"
	"golang.org/x/sys v0.27.0/go.mod"
	"google.golang.org/protobuf v1.35.1"
	"google.golang.org/protobuf v1.35.1/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals
SRC_URI+="${EGO_SUM_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="net-firewall/nftables"

src_prepare() {
	default
	sed -i -e '/strip bin\//d' -e '/sha256sum/d' Makefile
}

src_compile() {
	emake \
		SHA=${SHA} \
		GITVERSION=${GITVERSION} \
		VERSION=v${PV} \
		GOARCH=$(go-env_goarch) \
		build
}

src_install() {
	newbin bin/${P}-* ${PN}
	insinto etc
	doins nftables_exporter.yaml
	systemd_dounit systemd/nftables-exporter.service
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	keepdir /var/log/${PN}
}
