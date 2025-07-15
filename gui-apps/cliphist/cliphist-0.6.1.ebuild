# Copyright 2023 Avishek Sen
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit go-module

DESCRIPTION="Wayland clipboard manager"
HOMEPAGE="https://github.com/sentriz/cliphist"

LICENSE="GPL-3"
SLOT="0"
IUSE="+pie"

KEYWORDS="~amd64"
RESTRICT="mirror"

SRC_URI="https://github.com/sentriz/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

EGO_SUM=(
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/rogpeppe/go-internal v1.12.0"
	"github.com/rogpeppe/go-internal v1.12.0/go.mod"
	"github.com/stretchr/testify v1.8.1"
	"go.etcd.io/bbolt v1.3.9"
	"go.etcd.io/bbolt v1.3.9/go.mod"
	"go.senan.xyz/flagconf v0.1.9"
	"go.senan.xyz/flagconf v0.1.9/go.mod"
	"golang.org/x/image v0.21.0"
	"golang.org/x/image v0.21.0/go.mod"
	"golang.org/x/sync v0.8.0"
	"golang.org/x/sys v0.26.0"
	"golang.org/x/sys v0.26.0/go.mod"
	"golang.org/x/tools v0.24.0"
	"golang.org/x/tools v0.24.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
)

go-module_set_globals
SRC_URI+="${EGO_SUM_SRC_URI}"

RDEPEND="gui-apps/wl-clipboard
		x11-misc/xdg-utils"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS="readme.md LICENSE"
src_compile () {
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_CPPFLAGS="${CXXFLAGS}"
	export CGO_CXXFLAGS="${CXXFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"

	if use pie ; then
		ego build \
		--buildmode=pie \
		-trimpath \
		-mod=readonly \
		-modcacherw \
		-ldflags "-s -w -linkmode external -X main.version=${PV}" \
		-o "${PN}" .
	else
		ego build \
		-trimpath \
		-mod=readonly \
		-modcacherw \
		-ldflags "-s -w -linkmode external -X main.version=${PV}" \
		-o "${PN}" .
	fi
}

src_install() {
	einstalldocs
	dobin "${PN}"
}
