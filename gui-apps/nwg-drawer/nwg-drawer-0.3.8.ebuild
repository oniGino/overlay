# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="This code provides the MenuStart plugin to nwg-panel."
HOMEPAGE="https://github.com/nwg-piotr/nwg-drawer"
inherit go-module

EGO_SUM=(
	"github.com/stretchr/testify v1.3.0"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/allan-simon/go-singleinstance v0.0.0-20210120080615-d0997106ab37"
	"github.com/allan-simon/go-singleinstance v0.0.0-20210120080615-d0997106ab37/go.mod"
	"github.com/dlasky/gotk3-layershell v0.0.0-20210827021656-e6ecab2731f7"
	"github.com/dlasky/gotk3-layershell v0.0.0-20210827021656-e6ecab2731f7/go.mod"
	"github.com/fsnotify/fsnotify v1.5.1"
	"github.com/fsnotify/fsnotify v1.5.1/go.mod"
	"github.com/gotk3/gotk3 v0.6.1"
	"github.com/gotk3/gotk3 v0.6.1/go.mod"
	"github.com/joshuarubin/go-sway v1.2.0"
	"github.com/joshuarubin/go-sway v1.2.0/go.mod"
	"github.com/joshuarubin/lifecycle v1.0.0"
	"github.com/joshuarubin/lifecycle v1.0.0/go.mod"
	"github.com/sirupsen/logrus v1.9.0"
	"github.com/sirupsen/logrus v1.9.0/go.mod"
	"go.uber.org/atomic v1.3.2"
	"go.uber.org/atomic v1.3.2/go.mod"
	"go.uber.org/multierr v1.1.0"
	"go.uber.org/multierr v1.1.0/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8/go.mod"
	"golang.org/x/sync v0.0.0-20190412183630-56d357773e84"
	"golang.org/x/sync v0.0.0-20190412183630-56d357773e84/go.mod"
)
if [[ ${PV} == 9999 ]]; then
    inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/${PN}"
	EGIT_BRANCH="main"
else
	SRC_URI="https://github.com/nwg-piotr/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
fi

go-module_set_globals
SRC_URI+="${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-libs/gtk+
	dev-lang/go
	gui-libs/gtk-layer-shell
	"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	ego build
}

src_install() {
	dobin ${PN}
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r desktop-directories
	doins drawer.css
	dodoc LICENSE README.md
}
