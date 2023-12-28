# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A UI for wireplumber"
HOMEPAGE="https://github.com/dyegoaurelio/simple-wireplumber-gui"
SRC_URI="https://github.com/dyegoaurelio/${PN}/archive/refs/tags/${PV}.tar.gz"

PYTHON_COMPAT=(python3_11 python3_12)
inherit ninja-utils meson python-r1

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	gui-libs/gtk
	dev-python/pygobject[${PYTHON_USEDEP}]
	media-video/wireplumber
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	meson_install
	default
	mv "${ED}"/usr/share/appdata "${ED}"/usr/share/metainfo || die
}
