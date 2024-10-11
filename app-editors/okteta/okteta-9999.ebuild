# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
ECM_HANDBOOK="forceoptional"
ECM_TEST="true"
KFMIN=6.0.0
QTMIN=6.5.0
inherit ecm kde.org

DESCRIPTION="Hex editor by KDE"
HOMEPAGE="https://apps.kde.org/okteta/"

if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_SRC_URI="https://github.com/KDE/okteta.git"
	EGIT_BRANCH="work/kossebau/kf6"
	KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
fi

LICENSE="GPL-2 handbook? ( FDL-1.2 )"
SLOT="6"
IUSE=""

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[widgets,xml]
	>=dev-qt/qt5compat-${QTMIN}:6
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=kde-frameworks/kbookmarks-${KFMIN}:6
	>=kde-frameworks/kcolorscheme-${KFMIN}:6
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kdoctools-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kitemviews-${KFMIN}:6
	>=kde-frameworks/knewstuff-${KFMIN}:6
	>=kde-frameworks/kparts-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kxmlgui-${KFMIN}:6
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-0.26.13-doctools-optional.patch" ) # downstream

src_configure() {
	local mycmakeargs=(
		-DOMIT_EXAMPLES=ON
	)

	ecm_src_configure
}

src_test() {
	local myctestargs=( -j1 )

	ecm_src_test
}

