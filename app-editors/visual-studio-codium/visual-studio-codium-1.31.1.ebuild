# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils pax-utils

DESCRIPTION="A Telemetry Free Fork of Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://github.com/VSCodium/vscodium"
SRC_URI="
     x86? (  https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-ia32-${PV}.tar.gz  -> ${P}_i386.tar.gz )
     amd64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-x64-${PV}.tar.gz -> ${P}_amd64.tar.gz )
     "
RESTRICT="mirror strip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
     >=media-libs/libpng-1.6.35
     >=x11-libs/gtk+-3.24.1:3
     x11-libs/cairo
"
pkg_setup(){
    S="${WORKDIR}"
}

RDEPEND="${DEPEND}"

src_install(){
     pax-mark m code
     insinto "/opt/${PN}"
     doins -r *
     dosym "/opt/${PN}/vscodium" "/usr/bin/visual-studio-codium"
     make_wrapper "${PN}" "/opt/${PN}/code"
     make_desktop_entry "${PN}" "Visual Studio Codium" "${PN}" "Development;IDE"
     doicon ${FILESDIR}/${PN}.png
     fperms +x "/opt/${PN}/vscodium"
     fperms +x "/opt/${PN}/libnode.so"
     fperms +x "/opt/${PN}/libffmpeg.so"
     insinto "/usr/share/licenses/${PN}"
     newins "resources/app/LICENSE.txt" "LICENSE"
}

pkg_postinst(){
     elog "You may install some additional utils, so check them in:"
     elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
