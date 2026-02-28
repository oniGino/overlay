# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EMESON_BUILDTYPE="release"

inherit meson

DESCRIPTION="Console-based Audio Visualizer for Alsa"
HOMEPAGE="
	https://github.com/karlstav/cava/
	https://github.com/LukashonakV/cava
"

RESTRICT="mirror"
MY_PV="${PV}-beta"

SRC_URI="https://github.com/LukashonakV/cava/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="MIT Unlicense"
SLOT="lukashonakV"
KEYWORDS="amd64 x86"
IUSE="alsa jack +ncurses pipewire portaudio pulseaudio sdl sndio"

RDEPEND="
	>=dev-libs/iniparser-4.1-r2:=
	sci-libs/fftw:3.0=
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
	ncurses? ( sys-libs/ncurses:= )
	pipewire? ( media-video/pipewire:= )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-libs/libpulse )
	sdl? (
		media-libs/libglvnd
		media-libs/libsdl2[opengl,video]
	)
	sndio? ( media-sound/sndio:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		-Dbuild_target=all
		-Dcava_font=true
		$(meson_feature alsa input_alsa)
		$(meson_feature jack input_jack)
		$(meson_feature pipewire input_pipewire)
		$(meson_feature portaudio input_portaudio)
		$(meson_feature pulseaudio input_pulse)
		$(meson_feature sndio input_sndio)

		$(meson_feature ncurses output_ncurses)
		$(meson_feature sdl output_sdl)
		# note: not behind USE=opengl and sdl2[opengl?] given have not gotten
		# normal output-sdl to work without USE=opengl on sdl either way
		$(meson_feature sdl output_sdl_glsl)
	)
	meson_src_configure
}

pkg_postinst() {
	if [[ ! ${REPLACING_VERSIONS} ]]; then
		elog "A default ~/.config/cava/config will be created after initial"
		elog "use of ${PN}, see it and ${EROOT}/usr/share/doc/${PF}/README*"
		elog "for configuring audio input and more."
	fi
}
