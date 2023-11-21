# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="true"
PVCUT=$(ver_cut 1-3)
KFMIN=5.77.0
QTMIN=5.15.0
MAUIMIN=3.0.0
inherit ecm gear.kde.org optfeature

DESCRIPTION="MauiKit filemanager"
SRC_URI="https://invent.kde.org/maui/index-fm/-/archive/v${PV}/index-fm-v${PV}.tar.bz2 -> ${P}.tar.bz2"
HOMEPAGE="https://invent.kde.org/maui/index-fm"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="amd64 arm64 ~loong ~ppc64 ~riscv x86"
IUSE=""

DEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=kde-frameworks/karchive-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5=
	>=dev-qt/mauikit-${MAUIMIN}
"
RDEPEND="${DEPEND}
"

src_configure() {
	ecm_src_configure
}

