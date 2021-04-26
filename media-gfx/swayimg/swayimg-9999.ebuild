# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Image Viewer for Wayland"
HOMEPAGE="https://github.com/artemsen/swayimg"


if [[ ${PV} == 9999 ]]; then
 	EGIT_REPO_URI="https://github.com/artemsen/${PN}.git"
 	inherit git-r3
else
 	SRC_URI="https://github.com/artemsen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
 	KEYWORDS="amd64 arm64 x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="avif bash-completion gif jpeg svg webp +man"
DEPEND="
	dev-libs/json-c
	dev-libs/wayland
	x11-libs/libxkbcommon
	x11-libs/cairo
	avif? ( media-libs/libavif )
	bash-completion? ( app-shells/bash-completion )
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/libjpeg-turbo )
	svg? ( >=gnome-base/librsvg-2.14 )
	webp? ( media-libs/libwebp )
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		$(meson_feature avif)
		$(meson_feature bash-completion bash)
		$(meson_feature gif)
		$(meson_feature jpeg)
		$(meson_feature svg)
		$(meson_feature webp)
		$(meson_use man)
	)
	meson_src_configure
}


