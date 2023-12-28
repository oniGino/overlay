# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A backend implementation for xdg-desktop-portal"
HOMEPAGE="https://github.com/Decodetalkers/xdg-desktop-portal-shana"

CRATES="
	zbus-3.0.0
	url-2.4.0
	serde-1.0.0
	serde_repr-0.1.0
	tokio-1.32.0
	tracing-0.1.37
	tracing-subscriber-0.3.17
	toml-0.8.2
	notify-6.1.1
	once_cell-1.18.0
	futures-0.3.28"
inherit cargo meson

if [[ ${PV} == "9999" ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Decodetalkers/xdg-desktop-portal-shana.git"
else
	SRC_URI="
		https://github.com/Decodetalkers/xdg-desktop-portal-shana/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		$(cargo_crate_uris ${CRATES})
	"
fi

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

BUILD_DIR="${WORKDIR}/${P}/build"
src_unpack() {
	if [[ ${PV} == 9999* ]]
	then
		git-r3_src_unpack
		cargo_live_src_unpack
    else
        cargo_src_unpack
    fi
}
