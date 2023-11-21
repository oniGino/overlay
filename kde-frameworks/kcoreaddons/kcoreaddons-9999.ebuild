# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.5.0
inherit ecm frameworks.kde.org xdg-utils

DESCRIPTION="Framework for solving common problems such as caching, randomisation, and more"

LICENSE="LGPL-2+"
KEYWORDS="~amd64"
IUSE="+dbus +inotify +pch +qml"
SLOT="6"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}[dbus?]
	virtual/libudev
	qml? ( >=dev-qt/qtdeclarative-${QTMIN} )
	inotify? ( sys-fs/inotify-tools )

"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DBUILD_PCH=$(use pch)
		-DKCOREADDONS_USE_QML=$(use qml)
		-DENABLE_INOTIFY=$(use inotify)
	)

	ecm_src_configure
}

pkg_postinst() {
	ecm_pkg_postinst
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	ecm_pkg_postrm
	xdg_mimeinfo_database_update
}
