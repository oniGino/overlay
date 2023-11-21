# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
PVCUT=$(ver_cut 1-2)
QTMIN=6.5.0
inherit ecm frameworks.kde.org

DESCRIPTION="Framework for icon theming and configuration"
LICENSE="LGPL-2+"
KEYWORDS="~amd64"
IUSE="qml"
SLOT="6"


RDEPEND="
	>=dev-qt/qtbase-${QTMIN}[gui,dbus,svg,widgets]
	qml? ( >=dev-qt/qtdeclarative-${QTMIN}:6 )
	=kde-frameworks/karchive-${PVCUT}*:6
	=kde-frameworks/ki18n-${PVCUT}*:6
	=kde-frameworks/kconfigwidgets-${PVCUT}*:6
	=kde-frameworks/kwidgetsaddons-${PVCUT}*:6
	=kde-frameworks/kcolorscheme-${PVCUT}*:6
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qtdeclarative-${QTMIN}:6 )
"
