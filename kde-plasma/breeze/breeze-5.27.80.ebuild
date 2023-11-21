# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.240.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.5.0
inherit ecm plasma.kde.org

DESCRIPTION="Breeze visual style for the Plasma desktop"
HOMEPAGE="https://invent.kde.org/plasma/breeze"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc64 ~riscv x86"
IUSE="kwin +quick wallpapers"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}[widgets,dbus]
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcolorscheme-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kguiaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/kcmutils-${KFMIN}:6
	quick? (
		>=dev-qt/qtdeclarative-${QTMIN}:6
		>=kde-frameworks/kirigami-${KFMIN}:6
	)
	>=kde-frameworks/frameworkintegration-${KFMIN}:6
"
DEPEND="${RDEPEND}"
BDEPEND=""
PDEPEND="
	>=kde-frameworks/breeze-icons-${KFMIN}:6
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_QT5=OFF
		-DWITH_DECORATIONS=$(usex kwin decoration)
		-DWITH_WALLPAPERS=$(usex wallpapers)
	)
	cmake_src_configure
}
