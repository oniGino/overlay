# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Elisa KDE5 Music Player"
HOMEPAGE="http://kde.org"

inherit cmake-utils

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://anongit.kde.org/${PN}.git"
else
	SRC_URI="https://cgit.kde.org/elisa.git"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="baloo websockets metadata test dbus declarative handbook"

DEPEND="
		dev-qt/qtnetwork
		dev-qt/qtxml
		dev-qt/qtsql
		dev-qt/qtmultimedia
		dev-qt/qtsvg
		dev-qt/qtgui
		dev-qt/qtwidgets
		dev-qt/qtcore:5
		test? ( dev-qt/qttest )
		dbus? ( dev-qt/qtdbus )
		declarative? ( dev-qt/qtdeclarative )	
		sys-devel/gettext
		>=kde-frameworks/ki18n-5.32.0
		>=kde-frameworks/extra-cmake-modules-5.32.0
		>=kde-frameworks/kconfig-5.32.0
		>=kde-frameworks/kcmutils-5.32.0
		metadata? ( >=kde-frameworks/kfilemetadata-5.32.0 )
		baloo? ( kde-frameworks/baloo )
		>=kde-frameworks/kxmlgui-5.32.0
		handbook? ( >=kde-frameworks/kdoctools-5.32.0 )
		kde-frameworks/kcoreaddons
		kde-frameworks/kcrash
		websockets? ( dev-qt/qtwebsockets )"
RDEPEND="
		dev-qt/qtquickcontrols2 
		${DEPEND}"
