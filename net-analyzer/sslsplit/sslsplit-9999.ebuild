# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="transparent and scalable SSL/TLS interception"
HOMEPAGE="https://github.com/droe/sslsplit"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/droe/${PN}.git"
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}
fi

LICENSE="BSD MIT"
SLOT="0"
IUSE=""
REQUIRED_USE=""

DEPEND="
	dev-libs/openssl
	dev-libs/libevent"

RDEPEND="${DEPEND}"

src_compile() {
	make || die
}
