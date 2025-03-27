
EAPI=8

DESCRIPTION="Victron NodeJS server that takes from MQTT into Influx, and config UI and still more"
HOMEPAGE="https://github.com/victronenergy/venus-influx-loader"
SRC_URI="
	https://github.com/victronenergy/venus-influx-loader/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/oniGino/overlay-deps/${P}-deps.tar.xz"

KEYWORDS="~arm64 ~amd64"
LICENSE="MIT"
SLOT="0"
DEPEND="
	net-libs/nodejs:0/20[npm]
 	dev-lang/typescript
"

DOCS="CHANGELOG.md LICENSE README.md"
src_prepare() {
	default
	mv ${WORKDIR}/node_modules ${WORKDIR}/package-lock.json ${S}
}
src_compile() {
	true
}

src_install() {
  	local npm_module_dir="/usr/$(get_libdir)/node_modules/${PN}"

	einstalldocs

	BUILD_VERSION=${PV} ${S}/generateBuildInfo.sh
	mkdir -p ${ED}/${npm_module_dir} || die
	mv ${S}/dist/* ${ED}/${npm_module_dir} || die
	rmdir ${S}/dist || die
	mv ${S}/* ${ED}/${npm_module_dir} || die

	keepdir /var/lib/${PN}

	dosym ${npm_module_dir}/src/bin/${PN}.ts /usr/bin/${PN}
	dosym ${npm_module_dir}/src/bin/venus-upnp-browser.ts /usr/bin/venus-upnp-browser

	newinitd ${FILESDIR}/${PN}.init ${PN}
}

