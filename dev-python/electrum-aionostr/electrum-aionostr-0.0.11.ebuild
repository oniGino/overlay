# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 verify-sig

DESCRIPTION="User friendly Bitcoin client"
HOMEPAGE="
	https://electrum.org/
	https://github.com/spesmilo/electrum/
"

SRC_URI="https://github.com/spesmilo/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/electrum-ecc
    >=dev-python/aiohttp-3.11.0
    >=dev-python/aiohttp-socks-0.9.2
    >=dev-python/aiorpcx-0.22.0
"

