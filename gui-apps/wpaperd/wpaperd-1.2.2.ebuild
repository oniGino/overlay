# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8


CRATES="
	addr2line@0.21.0
	adler2@2.0.0
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	aligned-vec@0.5.0
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.7
	anstyle@1.0.10
	anyhow@1.0.97
	arbitrary@1.4.1
	arg_enum_proc_macro@0.3.4
	arrayvec@0.7.6
	autocfg@1.4.0
	av-data@0.4.4
	av1-grain@0.2.3
	avif-serialize@0.8.3
	backtrace@0.3.71
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.9.0
	bitreader@0.3.11
	bitstream-io@2.6.0
	built@0.7.7
	bumpalo@3.17.0
	byte-slice-cast@1.2.3
	bytemuck@1.22.0
	byteorder-lite@0.1.0
	byteorder@1.5.0
	bytes@1.10.1
	calloop-wayland-source@0.3.0
	calloop@0.13.0
	cc@1.2.17
	cfg-expr@0.15.8
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	chrono@0.4.40
	clap@4.5.35
	clap_builder@4.5.35
	clap_complete@4.5.47
	clap_derive@4.5.32
	clap_lex@0.7.4
	clap_mangen@0.2.26
	color-eyre@0.6.3
	color_quant@1.1.0
	colorchoice@1.0.3
	concurrent-queue@2.5.0
	core-foundation-sys@0.8.7
	crc32fast@1.4.2
	crossbeam-channel@0.5.15
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crunchy@0.2.3
	ctrlc@3.4.5
	cursor-icon@1.1.0
	dav1d-sys@0.8.2
	dav1d@0.10.3
	dirs-sys@0.5.0
	dirs@6.0.0
	dlib@0.5.2
	downcast-rs@1.2.1
	either@1.15.0
	equivalent@1.0.2
	errno@0.3.10
	exr@1.73.0
	eyre@0.6.12
	fallible_collections@0.4.9
	fastrand@2.3.0
	fdeflate@0.3.7
	file-id@0.1.0
	filetime@0.2.25
	flate2@1.1.0
	flexi_logger@0.30.0
	format-bytes-macros@0.4.0
	format-bytes@0.3.0
	fsevent-sys@4.1.0
	getrandom@0.2.15
	getrandom@0.3.2
	gif@0.13.1
	gimli@0.28.1
	gl_generator@0.14.0
	half@2.5.0
	hashbrown@0.13.2
	hashbrown@0.15.2
	heck@0.5.0
	hermit-abi@0.4.0
	hotwatch@0.5.0
	humantime-serde@1.1.1
	humantime@2.2.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.63
	image-webp@0.2.1
	image@0.25.6
	imgref@1.11.0
	indenter@0.3.3
	indexmap@2.8.0
	inotify-sys@0.1.5
	inotify@0.9.6
	interpolate_name@0.2.4
	is_terminal_polyfill@1.70.1
	itertools@0.12.1
	itoa@1.0.15
	jobserver@0.1.33
	jpeg-decoder@0.3.1
	js-sys@0.3.77
	khronos-egl@6.0.0
	khronos_api@3.1.0
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lebe@0.5.2
	libc@0.2.171
	libfuzzer-sys@0.4.9
	libloading@0.8.6
	libredox@0.1.3
	linux-raw-sys@0.4.15
	linux-raw-sys@0.9.3
	lock_api@0.4.12
	log@0.4.27
	loop9@0.1.5
	maybe-rayon@0.1.1
	memchr@2.7.4
	memmap2@0.9.5
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.4
	miniz_oxide@0.8.5
	mio@0.8.11
	mp4parse@0.17.0
	new_debug_unreachable@1.0.6
	new_mime_guess@4.0.4
	nix@0.29.0
	nom@7.1.3
	noop_proc_macro@0.3.0
	notify-debouncer-full@0.1.0
	notify@6.1.1
	nu-ansi-term@0.50.1
	num-bigint@0.4.6
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	object@0.32.2
	once_cell@1.21.3
	option-ext@0.2.0
	owo-colors@3.5.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	paste@1.0.15
	pin-project-lite@0.2.16
	pkg-config@0.3.32
	png@0.17.16
	polling@3.7.4
	ppv-lite86@0.2.21
	proc-macro2@1.0.94
	profiling-procmacros@1.0.16
	profiling@1.0.16
	qoi@0.4.1
	quick-error@2.0.1
	quick-xml@0.37.4
	quote@1.0.40
	r-efi@5.2.0
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rav1e@0.7.1
	ravif@0.11.11
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.5.10
	redox_users@0.5.0
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rgb@0.8.50
	roff@0.2.2
	rustc-demangle@0.1.24
	rustix@0.38.44
	rustix@1.0.5
	rustversion@1.0.20
	ryu@1.0.20
	same-file@1.0.6
	scoped-tls@1.0.1
	scopeguard@1.2.0
	serde@1.0.219
	serde_derive@1.0.219
	serde_json@1.0.140
	serde_spanned@0.6.8
	shlex@1.3.0
	simd-adler32@0.3.7
	simd_helpers@0.1.0
	slab@0.4.9
	smallvec@1.14.0
	smithay-client-toolkit@0.19.2
	static_assertions@1.1.0
	strsim@0.11.1
	syn@1.0.109
	syn@2.0.100
	system-deps@6.2.2
	target-lexicon@0.12.16
	terminal_size@0.4.2
	thiserror-impl@1.0.69
	thiserror-impl@2.0.12
	thiserror@1.0.69
	thiserror@2.0.12
	tiff@0.9.1
	tikv-jemalloc-sys@0.6.0+5.3.0-1-ge13ca993e8ccb9ba9847cc330696e02839f328f7
	tikv-jemallocator@0.6.0
	toml@0.8.20
	toml_datetime@0.6.8
	toml_edit@0.22.24
	tracing-core@0.1.33
	tracing@0.1.41
	unicase@2.8.1
	unicode-ident@1.0.18
	utf8parse@0.2.2
	v_frame@0.3.8
	version-compare@0.2.0
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasi@0.14.2+wasi-0.2.4
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	wayland-backend@0.3.8
	wayland-client@0.31.8
	wayland-csd-frame@0.3.0
	wayland-cursor@0.31.8
	wayland-egl@0.32.5
	wayland-protocols-wlr@0.3.6
	wayland-protocols@0.32.6
	wayland-scanner@0.31.6
	wayland-sys@0.31.6
	weezl@0.1.8
	winapi-util@0.1.9
	windows-core@0.61.0
	windows-implement@0.60.0
	windows-interface@0.59.1
	windows-link@0.1.1
	windows-result@0.3.2
	windows-strings@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.7.4
	wit-bindgen-rt@0.39.0
	xcursor@0.3.8
	xdg@2.5.2
	xkeysym@0.2.1
	xml-rs@0.8.25
	zerocopy-derive@0.7.35
	zerocopy-derive@0.8.24
	zerocopy@0.7.35
	zerocopy@0.8.24
	zune-core@0.4.12
	zune-inflate@0.2.54
	zune-jpeg@0.4.14
"

inherit cargo desktop shell-completion

DESCRIPTION="Minimal wallpaper daemon for Wayland"
HOMEPAGE="https://github.com/danyspin97/wpaperd"
SRC_URI="
	https://github.com/danyspin97/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

LICENSE="GPL-3 MIT 0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0 GPL-3+ ISC MIT MIT-0 MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
IUSE="avif +man bash-completion fish-completion"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	virtual/pkgconfig
	x11-libs/libxkbcommon
	dev-libs/wayland
	media-libs/mesa
	dev-lang/rust
	avif? ( media-libs/dav1d )
"
RDEPEND="${DEPEND}"
BDEPEND="
	man? ( app-text/scdoc )
"
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
	dobin target/release/wpaperctl
	dobin target/release/wpaperd

	dodoc CHANGELOG.md LICENSE.md README.md

	if use man; then
		doman man/wpaperd-output.5
		doman target/release/man/wpaperctl.1
		doman target/release/man/wpaperd.1
	fi
	if use bash-completion; then
		newbashcomp target/release/completions/wpaperctl.bash wpaperctl
		newbashcomp target/release/completions/wpaperd.bash wpaperd
	fi
	if use fish-completion; then
		newfishcomp target/release/completions/wpaperctl.fish wpaperctl
		newfishcomp target/release/completions/wpaperd.fish wpaperd
	fi
	if use zsh-completion; then
		newzshcomp target/release/completions/_wpaperctl wpaperctl
		newzshcomp target/release/completions/_wpaperd wpaperd
	fi

	default
}
