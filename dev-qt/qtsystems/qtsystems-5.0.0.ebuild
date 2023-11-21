# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils

SRC_URI="https://github.com/qt/qtsystems/archive/refs/tags/v5.0.0-beta1.tar.gz"
DESCRIPTION="Cross-platform application development framework"
SLOT=5
KEYWORDS="~amd64"
IUSE=""
VER=${PV}-beta1
S=${WORKDIR}/${PN}-${VER}

DEPEND="
	dev-libs/double-conversion:=
	dev-libs/glib:2
	dev-libs/libpcre2[pcre16,unicode]
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5
	default
}

