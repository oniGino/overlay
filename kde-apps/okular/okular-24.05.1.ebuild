# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="optional"
ECM_TEST="forceoptional"
PVCUT=$(ver_cut 1-3)
KFMIN=6.0.0
QTMIN=6.6.2
inherit ecm gear.kde.org

DESCRIPTION="Universal document viewer based on KDE Frameworks"
HOMEPAGE="https://okular.kde.org https://apps.kde.org/okular/"

LICENSE="GPL-2" # TODO: CHECK
SLOT="6"
KEYWORDS="~amd64"
IUSE="activities crypt djvu epub exiv markdown mobi +pdf phonon +postscript qml share speech +tiff X"

# slot op: Uses Qt6::CorePrivate
DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6=[dbus,gui,widgets,xml,X?]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/karchive-${KFMIN}:6
	>=kde-frameworks/kbookmarks-${KFMIN}:6
	>=kde-frameworks/kcolorscheme-${KFMIN}:6
	>=kde-frameworks/kcompletion-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kitemviews-${KFMIN}:6
	>=kde-frameworks/kparts-${KFMIN}:6
	>=kde-frameworks/kpty-${KFMIN}:6
	>=kde-frameworks/ktextwidgets-${KFMIN}:6
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6=[X?]
	>=kde-frameworks/kxmlgui-${KFMIN}:6
	>=kde-frameworks/threadweaver-${KFMIN}:6
	kde-plasma/plasma-activities:6
	media-libs/freetype
	sys-libs/zlib
	crypt? ( >=kde-frameworks/kwallet-${KFMIN}:6 )
	djvu? ( app-text/djvu )
	epub? ( app-text/ebook-tools )
	exiv? ( >=kde-apps/libkexiv2-${PVCUT}:6 )
	markdown? ( >=app-text/discount-2.2.7-r1:= )
	mobi? ( >=kde-apps/kdegraphics-mobipocket-${PVCUT}:6 )
	pdf? ( >=app-text/poppler-23.12.0[nss,qt6] )
	phonon? ( >=media-libs/phonon-4.12.0[qt6] )
	postscript? ( app-text/libspectre )
	share? ( >=kde-frameworks/purpose-${KFMIN}:6 )
	speech? ( >=dev-qt/qtspeech-${QTMIN}:6 )
	tiff? ( media-libs/tiff:= )
"
RDEPEND="${DEPEND}
	>=kde-frameworks/kimageformats-${KFMIN}:6
	qml? ( >=kde-frameworks/kirigami-${KFMIN}:6 )
"

PATCHES=(
	"${FILESDIR}/${P}-x11-optional.patch"
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_DISABLE_FIND_PACKAGE_LibZip=ON
		-DFORCE_NOT_REQUIRED_DEPENDENCIES="KF6DocTools;KExiv2Qt6;LibZip;KF6Wallet;DjVuLibre;EPub;Discount;QMobipocket6;Poppler;LibSpectre;KF6Purpose;Qt6TextToSpeech;TIFF;"
		-DOKULAR_UI=$(usex qml "both" "desktop")
		-DHAVE_X11=$(usex X)
		$(cmake_use_find_package crypt KF6Wallet)
		$(cmake_use_find_package djvu DjVuLibre)
		$(cmake_use_find_package epub EPub)
		$(cmake_use_fine_package exiv KExiv2Qt6)
		$(cmake_use_find_package markdown Discount)
		$(cmake_use_find_package mobi QMobipocket6)
		$(cmake_use_find_package pdf Poppler)
		$(cmake_use_find_package phonon Phonon4Qt6)
		$(cmake_use_find_package postscript LibSpectre)
		$(cmake_use_find_package share KF6Purpose)
		$(cmake_use_find_package speech Qt6TextToSpeech)
		$(cmake_use_find_package tiff TIFF)
	)
	ecm_src_configure
}

src_test() {
	# mainshelltest hangs, bug #603116
	# parttest hangs, bug #641728, annotationtoolbartest fails, KDE-Bug #429640
	# signunsignedfieldtest fails, whatever. bug #852749
	local myctestargs=(
		-E "(mainshelltest|parttest|annotationtoolbartest|signunsignedfieldtest)"
	)

	ecm_src_test
}