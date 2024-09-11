# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,12} )
inherit distutils-r1 xdg

DESCRIPTION="A graphical frontend for iwd, Intel's iNet Wireless Daemon"
HOMEPAGE="https://gitlab.com/hfernh/iwdgui"
SRC_URI="https://gitlab.com/hfernh/${PN}/-/archive/${PV}/${P}.tar.bz2"


LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"
DEPEND="
	x11-libs/gtk+:3
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	net-wireless/iwd
"
RDEPEND="
	${DEPEND}
"
BDEPEND=""
