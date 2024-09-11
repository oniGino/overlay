
EAPI=8

inherit cmake flag-o-matic

HOMEPAGE="https://github.com/dpayne/wallock"
DESCRIPTION="wallpaper and lock screen that enables macos like lock screens and wallapers on wayland"

CPM_DOWNLOAD_VERSION=0.38.5

SRC_URI="
	https://github.com/dpayne/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/cpm-cmake/CPM.cmake/releases/download/v${CPM_DOWNLOAD_VERSION}/CPM.cmake -> CPM_${CPM_DOWNLOAD_VERSION}.cmake
"


LICENSE="MIT"
SLOT=0

KEYWORDS="amd64"

DEPEND="
	dev-libs/cxxopts
	dev-libs/wayland
	dev-libs/wayland-protocols
	media-libs/mesa
	media-video/mpv
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/libdrm
	x11-libs/libxkbcommon
	virtual/libudev
	"

src_prepare() {
	default
	cmake_src_prepare
	mkdir -p CPM/cpm
	cp ${DISTDIR}/CPM_${CPM_DOWNLOAD_VERSION}.cmake CPM/cpm
}

src_configure() {
	append-flags "-Wno-unused-private-field"
	local mycmakeargs=(
		-DCMAKE_CXX_FLAGS="-Wno-unused-private-field"
		-DCMAKE_FLAGS="-Wno-unused-private-field"
		-DCPM_SOURCE_CACHE="${S}/CPM"
		-DCFLAGS="/DDEFINED_IN_CLI"
		-DCXXFLAGS="/DDEFINED_IN_CLI"
	)
	cmake_src_configure
}

