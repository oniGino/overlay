# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils
DESCRIPTION="LXQt Freedesktop.org Interface"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxde/${PN}.git"
else
	SRC_URI="http://downloads.lxqt.org/lxqt/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0/2"
IUSE="doc static-libs"
RDEPEND="dev-libs/glib:2"
DEPEND="${RDEPEND}
		x11-libs/libfm-extra
		!lxde-base/menu-cache
		doc? ( dev-util/gtk-doc )
		sys-devel/gettext
		virtual/pkgconfig"
DOCS=( AUTHORS NEWS README ) 
# ChangeLog is empty

PATCHES=( "${FILESDIR}/gtk-doc.patch" )
