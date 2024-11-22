
EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit meson python-single-r1 gnome2-utils xdg-utils

SRC_URI="https://github.com/rafaelmardojai/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DOCS="README.md SOUNDS_LICENSING.md"

DEPEND="
	dev-python/pygobject:3
	gui-libs/gtk
	gui-libs/libadwaita
	media-libs/gstreamer
"

src_install() {
	meson_src_install

	python_fix_shebang "${ED}"/usr/bin
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
    xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

