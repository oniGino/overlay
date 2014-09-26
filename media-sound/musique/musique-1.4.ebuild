# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils qt4-r2

DESCRIPTION="Qt4 music player"
HOMEPAGE="http://flavio.tordini.org/musique"
# Same tarball for every release. We repackage it
SRC_URI="https://github.com/flaviotordini/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4[gtkstyle]
	dev-qt/qtsql:4[sqlite]
	|| ( media-libs/phonon[qt4] dev-qt/qtphonon:4 )
	media-libs/taglib
	dev-qt/qtsingleapplication[qt4]
"
DEPEND="${RDEPEND}"

DOCS="CHANGES TODO"

src_prepare () {
	# bug 422665. Upstream only cares about ubuntu
	# so this bug will be fixed once ubuntu moves
	# to gcc-4.7. No, I will not send this patch upstream
	# *again*
	epatch "${FILESDIR}"/${PN}-1.1-gcc47.patch
	#Don't use built-In qtsingleapplication
	epatch "${FILESDIR}"/qtsingle.patch
	qt4-r2_src_prepare
}

src_configure() {
	eqmake4 ${PN}.pro PREFIX="/usr"
}

src_install() {
	qt4-r2_src_install
	doicon data/${PN}.svg
}
