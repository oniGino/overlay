# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="LXQT Sudo GUI"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxde/${PN}.git"
else
	SRC_URI="http://downloads.lxqt.org/lxqt/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"

CDEPEND="
	media-sound/pulseaudio
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-util/lxqt-build-tools"
DEPEND="${CDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"
RDEPEND="${CDEPEND}"

src_install(){
	cmake-utils_src_install
}
