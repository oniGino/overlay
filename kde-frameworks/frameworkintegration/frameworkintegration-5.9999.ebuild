# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="false"
PVCUT=$(ver_cut 1-2)
QTMIN=6.5.0
inherit ecm frameworks.kde.org

DESCRIPTION="Framework for integrating Qt applications with KDE Plasma workspaces"

LICENSE="LGPL-2+"
KEYWORDS="~amd64"
IUSE="+kpackage"
SLOT="6"

# requires running Plasma environment
RESTRICT="test"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}[gui,widgets]
	=kde-frameworks/kconfig-${PVCUT}*:6
	=kde-frameworks/kcolorscheme-${PVCUT}*:6
	=kde-frameworks/kiconthemes-${PVCUT}*:6
	=kde-frameworks/knotifications-${PVCUT}*:6
"
DEPEND="${RDEPEND}
	kpackage? (
		=kde-frameworks/knewstuff-${PVCUT}*:6
		=kde-frameworks/kwidgetsaddons-${PVCUT}*:6
		=kde-frameworks/kpackage-${PVCUT}*:6
		=kde-frameworks/kl18n-${PVCUT}*:6

		>=dev-libs/appstream-1.0.0[qt6]
	)
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_KPACKAGE_INSTALL_HANDLERS=$(usex kpackage)
		-DCMAKE_DISABLE_FIND_PACKAGE_packagekitqt6=ON
	)

	ecm_src_configure
}
