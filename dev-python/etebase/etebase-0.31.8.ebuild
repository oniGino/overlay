# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aho-corasick@1.1.2
	aligned@0.4.1
	as-slice@0.2.1
	atty@0.2.14
	autocfg@1.1.0
	backtrace@0.3.69
	base64@0.21.5
	bitflags@1.3.2
	bitflags@2.4.1
	bumpalo@3.14.0
	byteorder@1.5.0
	bytes@1.5.0
	cc@1.0.83
	cfg-if@1.0.0
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	cpython@0.7.2
	cvt@0.1.2
	ed25519@1.5.3
	either@1.13.0
	encoding_rs@0.8.33
	env_logger@0.7.1
	equivalent@1.0.1
	errno@0.3.8
	etebase@0.6.0
	fastrand@2.0.1
	fixedbitset@0.4.2
	flapigen@0.6.1
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	fs_at@0.1.10
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-io@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	gimli@0.28.1
	h2@0.3.22
	hashbrown@0.14.3
	heck@0.4.1
	hermit-abi@0.1.19
	hermit-abi@0.3.3
	home@0.5.9
	http-body@0.4.6
	http@0.2.11
	httparse@1.8.0
	httpdate@1.0.3
	humantime@1.3.0
	hyper-tls@0.5.0
	hyper@0.14.28
	idna@0.5.0
	indexmap@2.1.0
	ipnet@2.9.0
	itoa@1.0.10
	js-sys@0.3.66
	lazy_static@1.4.0
	libc@0.2.151
	libsodium-sys@0.2.7
	linux-raw-sys@0.4.12
	log@0.4.20
	memchr@2.6.4
	mime@0.3.17
	miniz_oxide@0.7.1
	mio@0.8.10
	native-tls@0.2.11
	nix@0.26.4
	normpath@1.1.1
	num-traits@0.2.17
	num_cpus@1.16.0
	object@0.32.2
	once_cell@1.19.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.2.1+3.2.0
	openssl-sys@0.9.98
	openssl@0.10.62
	paste@1.0.14
	percent-encoding@2.3.1
	petgraph@0.6.5
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pkg-config@0.3.28
	proc-macro2@1.0.71
	python3-sys@0.7.2
	quick-error@1.2.3
	quote@1.0.33
	redox_syscall@0.4.1
	regex-automata@0.4.3
	regex-syntax@0.8.2
	regex@1.10.2
	remove_dir_all@0.8.2
	reqwest@0.11.23
	rmp-serde@1.1.2
	rmp@0.8.12
	rustc-demangle@0.1.23
	rustc-hash@1.1.0
	rustix@0.38.28
	rustversion@1.0.17
	ryu@1.0.16
	same-file@1.0.6
	schannel@0.1.22
	security-framework-sys@2.9.1
	security-framework@2.9.2
	serde@1.0.193
	serde_bytes@0.11.12
	serde_derive@1.0.193
	serde_json@1.0.108
	serde_repr@0.1.17
	serde_urlencoded@0.7.1
	signature@1.6.4
	slab@0.4.9
	smallvec@1.11.2
	smol_str@0.2.2
	socket2@0.5.5
	sodiumoxide@0.2.7
	stable_deref_trait@1.2.0
	strum@0.24.1
	strum_macros@0.24.3
	syn@1.0.109
	syn@2.0.43
	system-configuration-sys@0.5.0
	system-configuration@0.5.1
	tempfile@3.8.1
	termcolor@1.4.0
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-native-tls@0.3.1
	tokio-util@0.7.10
	tokio@1.35.1
	tower-service@0.3.2
	tracing-core@0.1.32
	tracing@0.1.40
	try-lock@0.2.5
	unicode-bidi@0.3.14
	unicode-ident@1.0.12
	unicode-normalization@0.1.22
	url@2.5.0
	vcpkg@0.2.15
	walkdir@2.4.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.89
	wasm-bindgen-futures@0.4.39
	wasm-bindgen-macro-support@0.2.89
	wasm-bindgen-macro@0.2.89
	wasm-bindgen-shared@0.2.89
	wasm-bindgen@0.2.89
	web-sys@0.3.66
	which@4.4.2
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
	winreg@0.50.0
"

inherit cargo distutils-r1 optfeature

MY_P=${PN}-py-${PV}
DESCRIPTION="EteBase Library"
HOMEPAGE="https://github.com/etesync/etebase-py"
SRC_URI="
	https://github.com/etesync/etebase-py/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

S=${WORKDIR}/${MY_P}

KEYWORDS="~alpha amd64 arm arm64 hppa ~loong ~mips ppc ppc64 ~riscv ~s390 sparc x86"

LICENSE="BSD
	Apache-2.0
	MIT
	PYTHON"
SLOT="0"
IUSE=""

RDEPEND="
	dev-libs/openssl:=
	dev-python/msgpack[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-lang/rust[rustfmt]
	dev-python/setuptools-rust[${PYTHON_USEDEP}]
"

src_unpack() {
	cargo_src_unpack
}

