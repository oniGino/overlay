# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="This code provides the MenuStart plugin to nwg-panel."
HOMEPAGE="https://github.com/nwg-piotr/nwg-menu"
SRC_URI="https://github.com/nwg-piotr/${PN}/archive/refs/tags/v${PV}.tar.gz"

inherit go-module

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
