# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/remmina/remmina-1.2.0_rc3.ebuild,v 1.1 2015/04/16 11:06:11 maksbotan Exp $

EAPI="4"

#inherit

if [[ ${PV} != 9999 ]]; then
	SRC_URI="https://www.uni-due.de/~be0001/subnetcalc/download/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-2
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/dreibh/subnetcalc.git"
	KEYWORDS=""
fi

DESCRIPTION="Command Line Subnet Calculator"
HOMEPAGE="https://github.com/dreibh/subnetcalc.git"

LICENSE="GPL-2"
SLOT="0"
IUSE="geoip nls"

RDEPEND=" geoip? ( dev-libs/geoip ) "
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"

DOCS=( README )

src_configure() {
	econf \
		--enable-colorgcc \
		$(use_with geoip)
}
