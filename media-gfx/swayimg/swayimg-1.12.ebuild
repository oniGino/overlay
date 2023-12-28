# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg-utils

DESCRIPTION="Image Viewer for Wayland"
HOMEPAGE="https://github.com/artemsen/swayimg"


if [[ ${PV} == 9999 ]]; then
 	EGIT_REPO_URI="https://github.com/artemsen/${PN}.git"
 	inherit git-r3
else
 	SRC_URI="https://github.com/artemsen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
 	KEYWORDS="amd64 arm64 x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="bash-completion exif gif heif jpeg jpegxl png svg tiff webp +man zsh-completion"
DEPEND="
	dev-libs/json-c
	dev-libs/wayland
	>=media-libs/freetype-2
	media-libs/fontconfig
	x11-libs/libxkbcommon
	x11-libs/cairo
	bash-completion? ( app-shells/bash-completion )
	exif? ( media-libs/libexif )
	gif? ( media-libs/giflib )
	heif? ( media-libs/libheif )
	jpeg? ( media-libs/libjpeg-turbo )
	jpegxl? ( media-libs/libjxl )
	png? ( media-libs/libpng )
	svg? ( >=gnome-base/librsvg-2.46 )
	tiff? ( >=media-libs/tiff-4 )
	webp? ( media-libs/libwebp )
	zsh-completion? ( app-shells/zsh )
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		$(meson_feature bash-completion bash)
		$(meson_feature exif)
		$(meson_feature gif)
		$(meson_feature heif)
		$(meson_feature jpegxl jxl)
		$(meson_feature jpeg)
		$(meson_feature png)
		$(meson_feature svg)
		$(meson_feature tiff)
		$(meson_feature webp)
		$(meson_feature zsh-completion zsh)
		$(meson_use man)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

