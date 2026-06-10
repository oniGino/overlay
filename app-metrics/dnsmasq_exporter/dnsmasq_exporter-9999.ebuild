# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module go-env git-r3

DESCRIPTION="prometheus exporter for dnsmasq"
HOMEPAGE="https://github.com/google/dnsmasq_exporter"

EGIT_REPO_URI="https://github.com/google/dnsmasq_exporter.git"

EGO_SUM=(
	"github.com/beorn7/perks v1.0.1"
	"github.com/beorn7/perks v1.0.1/go.mod"
	"github.com/cespare/xxhash/v2 v2.3.0"
	"github.com/cespare/xxhash/v2 v2.3.0/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/google/go-cmp v0.7.0"
	"github.com/google/go-cmp v0.7.0/go.mod"
	"github.com/klauspost/compress v1.18.0"
	"github.com/klauspost/compress v1.18.0/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/kylelemons/godebug v1.1.0"
	"github.com/kylelemons/godebug v1.1.0/go.mod"
	"github.com/miekg/dns v1.1.72"
	"github.com/miekg/dns v1.1.72/go.mod"
	"github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822"
	"github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/prometheus/client_golang v1.23.2"
	"github.com/prometheus/client_golang v1.23.2/go.mod"
	"github.com/prometheus/client_model v0.6.2"
	"github.com/prometheus/client_model v0.6.2/go.mod"
	"github.com/prometheus/common v0.67.5"
	"github.com/prometheus/common v0.67.5/go.mod"
	"github.com/prometheus/procfs v0.19.2"
	"github.com/prometheus/procfs v0.19.2/go.mod"
	"github.com/rogpeppe/go-internal v1.10.0"
	"github.com/rogpeppe/go-internal v1.10.0/go.mod"
	"github.com/stretchr/testify v1.11.1"
	"github.com/stretchr/testify v1.11.1/go.mod"
	"go.uber.org/goleak v1.3.0"
	"go.uber.org/goleak v1.3.0/go.mod"
	"go.yaml.in/yaml/v2 v2.4.3"
	"go.yaml.in/yaml/v2 v2.4.3/go.mod"
	"golang.org/x/mod v0.32.0"
	"golang.org/x/mod v0.32.0/go.mod"
	"golang.org/x/net v0.49.0"
	"golang.org/x/net v0.49.0/go.mod"
	"golang.org/x/sync v0.19.0"
	"golang.org/x/sync v0.19.0/go.mod"
	"golang.org/x/sys v0.40.0"
	"golang.org/x/sys v0.40.0/go.mod"
	"golang.org/x/tools v0.41.0"
	"golang.org/x/tools v0.41.0/go.mod"
	"google.golang.org/protobuf v1.36.11"
	"google.golang.org/protobuf v1.36.11/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals
SRC_URI="${EGO_SUM_SRC_URI}"

LICENSE="BSD MIT Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	acct-group/dnsmasq_exporter
	acct-user/dnsmasq_exporter
"

src_unpack() {
	default
	git-r3_src_unpack
	go-module_src_unpack
}

src_compile() {
	ego build
}

src_install() {
	dobin dnsmasq_exporter
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	keepdir /var/log/dnsmasq_exporter
	fowners ${PN}:${PN} /var/log/dnsmasq_exporter
}

pkg_postinst() {
	if [[ -e "${EROOT}"/var/log/ddnsmasq_exporter ]]; then
		elog "The log directory is now ${EROOT}/var/log/dnsmasq_exporter"
		elog "in order 	to fix a typo."
	fi
}
