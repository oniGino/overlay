# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils

DESCRIPTION="LXImage Image Viewer - GPicView replacement"
HOMEPAGE="http://www.lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxde/${PN}.git"
else
	SRC_URI="http://lxqt.org/downloads/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}
fi

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtx11extras:5
	dev-libs/glib
	dev-qt/qtgui:5
	lxqt-base/lxqt-build-tools
	x11-libs/libfm-qt
	media-libs/libexif
	lxde-base/menu-cache
	x11-libs/libX11"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
