# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module go-env systemd

DESCRIPTION="Grafana Alloy"
HOMEPAGE="https://github.com/grafana/alloy"
SRC_URI="https://github.com/grafana/alloy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/oniGino/overlay/${P}-deps.tar.xz"

RESTRICT="mirror"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	ego build -o build/alloy
}

src_install() {
	newbin build/alloy ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
