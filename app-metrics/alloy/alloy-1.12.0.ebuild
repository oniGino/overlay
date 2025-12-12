# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module go-env

DESCRIPTION="Grafana Alloy"
HOMEPAGE="https://github.com/grafana/alloy"
SRC_URI="https://github.com/grafana/alloy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/oniGino/gentoo-deps/${P}-vendor.tar.gz"

RESTRICT="mirror"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_prepare() {
	default

	export GOMAXPROCS=$(makeopts_jobs "${MAKEOPTS}" "$(get_nproc)")

	git config --global init.defaultBranch main || die
	git config --global user.email "you@example.com" || die
    git config --global user.name "Your Name" || die
	git init || die
    git add . || die
    git commit -m 'init' || die

	go-env_set_compile_environment
}

src_compile() {
	ego build alloy
}

src_install() {
	newbin build/alloy ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
