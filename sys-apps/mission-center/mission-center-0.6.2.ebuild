
EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
CRATES="
	ahash@0.8.11
	aho-corasick@1.1.3
	autocfg@1.4.0
	bitflags@2.6.0
	block@0.1.6
	cairo-rs@0.20.1
	cairo-sys-rs@0.20.0
	cc@1.1.28
	cfg-expr@0.17.0
	cfg-if@1.0.0
	const-random-macro@0.1.16
	const-random@0.1.18
	crunchy@0.2.2
	dbus@0.9.7
	dlv-list@0.5.2
	equivalent@1.0.1
	errno-sys@0.2.0
	fallible-iterator@0.3.0
	fallible-streaming-iterator@0.1.9
	field-offset@0.3.6
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	gdk-pixbuf-sys@0.20.4
	gdk-pixbuf@0.20.4
	gdk4-sys@0.9.2
	gdk4@0.9.2
	getrandom@0.2.15
	gettext-rs@0.7.1
	gettext-sys@0.21.4
	gio-sys@0.20.4
	gio@0.20.4
	glib-macros@0.20.4
	glib-sys@0.20.4
	glib@0.20.4
	gobject-sys@0.20.4
	graphene-rs@0.20.4
	graphene-sys@0.20.4
	gsk4-sys@0.9.2
	gsk4@0.9.2
	gtk4-macros@0.9.1
	gtk4-sys@0.9.2
	gtk4@0.9.2
	hashbrown@0.14.5
	hashbrown@0.15.0
	hashlink@0.9.1
	heck@0.5.0
	indexmap@2.6.0
	itoa@1.0.11
	lazy_static@1.5.0
	libadwaita-sys@0.7.0
	libadwaita@0.7.0
	libc@0.2.159
	libdbus-sys@0.2.5
	libsqlite3-sys@0.30.1
	libudev-sys@0.1.4
	locale_config@0.3.0
	malloc_buf@0.0.6
	memchr@2.7.4
	memoffset@0.9.1
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	once_cell@1.20.2
	ordered-multimap@0.7.3
	pango-sys@0.20.4
	pango@0.20.4
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	pkg-config@0.3.31
	proc-macro-crate@3.2.0
	proc-macro2@1.0.86
	quote@1.0.37
	regex-automata@0.4.8
	regex-syntax@0.8.5
	regex@1.11.0
	rusqlite@0.32.1
	rust-ini@0.21.1
	rustc_version@0.4.1
	ryu@1.0.18
	semver@1.0.23
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.128
	serde_spanned@0.6.8
	shlex@1.3.0
	slab@0.4.9
	smallvec@1.13.2
	static_assertions@1.1.0
	syn@2.0.79
	system-deps@7.0.3
	target-lexicon@0.12.16
	temp-dir@0.1.14
	textdistance@1.1.0
	tiny-keccak@2.0.2
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.22
	trim-in-place@0.1.7
	unicode-ident@1.0.13
	vcpkg@0.2.15
	version-compare@0.2.0
	version_check@0.9.5
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.52.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.6.20
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
"

inherit cargo meson python-single-r1 xdg-utils gnome2-utils

SRC_URI="
	https://gitlab.com/mission-center-devs/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+=" Apache-2.0 Apache-2.0-with-LLVM-exceptions CC0-1.0 MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"

DEPENDS="
	virtual/libudev
	dev-python/pygobject
	gui-libs/gtk
	gui-libs/libadwaita
	x11-libs/libdrm
"

src_configure(){
	meson_src_configure
	cargo_src_configure
}

src_compile() {
	cargo_src_compile
	meson_src_compile
}

src_install() {
	meson_src_install
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
