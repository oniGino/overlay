# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EMESON_BUILDTYPE="release"

inherit meson

FORK_NAME="LukashonakV"

DESCRIPTION="Console-based Audio Visualizer for Alsa"
SRC_URI="https://github.com/${FORK_NAME}/cava/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="
	https://github.com/karlstav/cava/
	https://github.com/${FORK_NAME}/cava
"

RESTRICT="mirror"


LICENSE="MIT Unlicense"
SLOT="${FORK_NAME}"
KEYWORDS="amd64 x86"
IUSE="alsa jack +ncurses pipewire portaudio pulseaudio sdl sndio"

RDEPEND="
	>=dev-libs/iniparser-4.2:=
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

	# allow use of libglvnd[-X]
	use sdl && emesonargs+=( GL_LIBS="$($(tc-getPKG_CONFIG) --libs opengl || die)" )

	meson_src_configure
}

pkg_postinst() {
	if [[ ! ${REPLACING_VERSIONS} ]]; then
		elog "A default ~/.config/cava/config will be created after initial"
		elog "use of ${PN}, see it and ${EROOT}/usr/share/doc/${PF}/README*"
		elog "for configuring audio input and more."
	fi
}
