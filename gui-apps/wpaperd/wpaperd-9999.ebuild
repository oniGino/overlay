# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line-0.19.0
	adler-1.0.2
	ahash-0.7.6
	aho-corasick-0.7.20
	android_system_properties-0.1.5
	ansi_term-0.12.1
	atomic-0.5.1
	atty-0.2.14
	autocfg-1.1.0
	backtrace-0.3.67
	bindgen-0.59.2
	bitflags-1.3.2
	bitreader-0.3.6
	bumpalo-3.12.0
	bytemuck-1.13.0
	byteorder-1.4.3
	calloop-0.10.5
	cc-1.0.79
	cexpr-0.6.0
	cfg-expr-0.11.0
	cfg-if-0.1.10
	cfg-if-1.0.0
	chrono-0.4.23
	clang-sys-1.4.0
	clap-2.34.0
	clap-4.1.6
	clap_complete-4.1.2
	clap_derive-4.1.0
	clap_lex-0.3.1
	clap_mangen-0.2.8
	codespan-reporting-0.11.1
	color-eyre-0.6.2
	color_quant-1.1.0
	core-foundation-sys-0.8.3
	crc32fast-1.3.2
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.13
	crossbeam-utils-0.8.14
	cxx-1.0.91
	cxx-build-1.0.91
	cxxbridge-flags-1.0.91
	cxxbridge-macro-1.0.91
	dav1d-0.6.1
	dav1d-sys-0.3.5
	dcv-color-primitives-0.4.1
	dirs-4.0.0
	dirs-sys-0.3.7
	dlib-0.5.0
	downcast-rs-1.2.0
	either-1.8.1
	env_logger-0.8.4
	env_logger-0.9.3
	errno-0.2.8
	errno-dragonfly-0.1.2
	eyre-0.6.8
	fallible_collections-0.4.6
	figment-0.10.8
	filetime-0.2.20
	flate2-1.0.25
	flexi_logger-0.25.1
	fsevent-0.4.0
	fsevent-sys-2.0.1
	fuchsia-zircon-0.3.3
	fuchsia-zircon-sys-0.3.3
	getrandom-0.2.8
	gimli-0.27.2
	glob-0.3.1
	hashbrown-0.12.3
	heck-0.4.1
	hermit-abi-0.1.19
	hermit-abi-0.2.6
	hermit-abi-0.3.1
	hotwatch-0.4.6
	humantime-2.1.0
	humantime-serde-1.1.1
	iana-time-zone-0.1.53
	iana-time-zone-haiku-0.1.1
	image-0.24.5
	indenter-0.3.3
	indexmap-1.9.2
	inotify-0.7.1
	inotify-sys-0.1.5
	io-lifetimes-1.0.5
	iovec-0.1.4
	is-terminal-0.4.3
	jpeg-decoder-0.3.0
	js-sys-0.3.61
	kernel32-sys-0.2.2
	lazy_static-1.4.0
	lazycell-1.3.0
	libc-0.2.139
	libloading-0.7.4
	link-cplusplus-1.0.8
	linux-raw-sys-0.1.4
	log-0.4.17
	memchr-2.5.0
	memmap2-0.5.8
	memoffset-0.6.5
	memoffset-0.7.1
	mime-0.3.16
	minimal-lexical-0.2.1
	miniz_oxide-0.6.2
	mio-0.6.23
	mio-extras-2.0.6
	miow-0.2.2
	mp4parse-0.12.0
	net2-0.2.38
	new_mime_guess-4.0.1
	nix-0.25.1
	nix-0.26.2
	nom-7.1.3
	nom8-0.2.0
	notify-4.0.17
	nu-ansi-term-0.46.0
	num-integer-0.1.45
	num-rational-0.4.1
	num-traits-0.2.15
	num_cpus-1.15.0
	object-0.30.3
	once_cell-1.17.1
	os_str_bytes-6.4.1
	overload-0.1.1
	owo-colors-3.5.0
	paste-1.0.11
	peeking_take_while-0.1.2
	pin-utils-0.1.0
	pkg-config-0.3.26
	png-0.17.7
	ppv-lite86-0.2.17
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.51
	quick-xml-0.23.1
	quote-1.0.23
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	rayon-1.6.1
	rayon-core-1.10.2
	redox_syscall-0.2.16
	redox_users-0.4.3
	regex-1.7.1
	regex-syntax-0.6.28
	roff-0.2.1
	rustc-demangle-0.1.21
	rustc-hash-1.1.0
	rustix-0.36.8
	same-file-1.0.6
	scoped-tls-1.0.1
	scopeguard-1.1.0
	scratch-1.0.3
	serde-1.0.152
	serde_derive-1.0.152
	serde_spanned-0.6.1
	shlex-1.1.0
	slab-0.4.7
	slotmap-1.0.6
	smallvec-1.10.0
	static_assertions-1.1.0
	strsim-0.8.0
	strsim-0.10.0
	syn-1.0.107
	system-deps-6.0.3
	termcolor-1.2.0
	terminal_size-0.2.5
	textwrap-0.11.0
	thiserror-1.0.38
	thiserror-impl-1.0.38
	toml-0.5.11
	toml-0.7.2
	toml_datetime-0.6.1
	toml_edit-0.19.3
	uncased-0.9.7
	unicase-2.6.0
	unicode-ident-1.0.6
	unicode-width-0.1.10
	vec_map-0.8.2
	version-compare-0.1.1
	version_check-0.9.4
	walkdir-2.3.2
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.84
	wasm-bindgen-backend-0.2.84
	wasm-bindgen-macro-0.2.84
	wasm-bindgen-macro-support-0.2.84
	wasm-bindgen-shared-0.2.84
	wayland-backend-0.1.1
	wayland-client-0.30.1
	wayland-cursor-0.30.0
	wayland-protocols-0.30.0
	wayland-protocols-wlr-0.1.0
	wayland-scanner-0.30.0
	wayland-sys-0.30.1
	which-4.4.0
	winapi-0.2.8
	winapi-0.3.9
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.45.0
	windows-targets-0.42.1
	windows_aarch64_gnullvm-0.42.1
	windows_aarch64_msvc-0.42.1
	windows_i686_gnu-0.42.1
	windows_i686_msvc-0.42.1
	windows_x86_64_gnu-0.42.1
	windows_x86_64_gnullvm-0.42.1
	windows_x86_64_msvc-0.42.1
	ws2_32-sys-0.2.1
	xcursor-0.3.4
	xdg-2.4.1
"

declare -A GIT_CRATES=(
	[smithay-client-toolkit]="https://github.com/Smithay/client-toolkit;a3d1af852a607587114ccc6631c87046ecc898d3;client-toolkit-%commit%"
)

inherit cargo desktop git-r3

DESCRIPTION="Minimal wallpaper daemon for Wayland"
HOMEPAGE="https://github.com/danyspin97/wpaperd"
GIT_URI="https://github.com/danyspin97/wpaperd.git"
SRC_URI="$(cargo_crate_uris)"

LICENSE="GPL-3 MIT 0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0 GPL-3+ ISC MIT MIT-0 MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
IUSE="avif +man"
SLOT="0"
KEYWORDS=""

DEPEND="
	virtual/pkgconfig
	x11-libs/libxkbcommon
	dev-lang/rust
	avif? ( media-libs/avif )
	man? ( app-text/scdoc )
"
RDEPEND="${DEPEND}"
BDEPEND=""

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_configure() {
	local myfeatures=(
		$(usev avif)
	)
	cargo_src_configure
	if use man; then
		scdoc < man/wpaperd-output.5.scd > man/wpaperd-output.5
	fi
}
src_install() {
	cargo_src_install --path "./daemon"
	cargo_src_install --path "./cli"
	mandoc man/wpaperd-output.5
	default
}
