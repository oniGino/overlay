# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_HANDBOOK="forceoff"
ECM_TEST="false"
ECM_I18N="false"

PVCUT=$(ver_cut 1-3)
KFMIN=6.16.0
QTMIN=6.9.1

KDE_ORG_NAME="kdepim-addons"

CRATES="
	adblock@0.9.2
	addr@0.15.6
	aho-corasick@1.1.3
	autocfg@1.4.0
	base64@0.13.1
	bitflags@1.3.2
	byteorder@1.5.0
	cc@1.2.1
	codespan-reporting@0.11.1
	cxx-build@1.0.130
	cxx@1.0.130
	cxxbridge-flags@1.0.130
	cxxbridge-macro@1.0.130
	displaydoc@0.2.5
	either@1.13.0
	form_urlencoded@1.2.1
	icu_collections@1.5.0
	icu_locid@1.5.0
	icu_locid_transform@1.5.0
	icu_locid_transform_data@1.5.0
	icu_normalizer@1.5.0
	icu_normalizer_data@1.5.0
	icu_properties@1.5.1
	icu_properties_data@1.5.0
	icu_provider@1.5.0
	icu_provider_macros@1.5.0
	idna@0.2.3
	idna@1.0.3
	idna_adapter@1.2.0
	itertools@0.10.5
	itoa@1.0.11
	lifeguard@0.6.1
	link-cplusplus@1.0.9
	litemap@0.7.3
	matches@0.1.10
	memchr@2.7.4
	num-traits@0.2.19
	once_cell@1.20.2
	paste@1.0.15
	percent-encoding@2.3.1
	proc-macro2@1.0.89
	psl-types@2.0.11
	psl@2.1.56
	quote@1.0.37
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rmp-serde@0.15.5
	rmp@0.8.14
	rustversion@1.0.18
	ryu@1.0.18
	scratch@1.0.7
	seahash@3.0.7
	serde@1.0.215
	serde_derive@1.0.215
	serde_json@1.0.133
	shlex@1.3.0
	smallvec@1.13.2
	stable_deref_trait@1.2.0
	syn@2.0.87
	synstructure@0.13.1
	termcolor@1.4.1
	thiserror-impl@1.0.69
	thiserror@1.0.69
	tinystr@0.7.6
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	unicode-bidi@0.3.17
	unicode-ident@1.0.13
	unicode-normalization@0.1.24
	unicode-width@0.1.14
	url@2.5.3
	utf16_iter@1.0.5
	utf8_iter@1.0.4
	winapi-util@0.1.9
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	write16@1.0.0
	writeable@0.5.5
	yoke-derive@0.7.4
	yoke@0.7.4
	zerofrom-derive@0.1.4
	zerofrom@0.1.4
	zerovec-derive@0.10.3
	zerovec@0.10.4
"

inherit ecm gear.kde.org cargo

SRC_URI+=" ${CARGO_CRATE_URIS}"

DESCRIPTION="URL Filter for Plugins for KDE Personal Information Management Suite"
HOMEPAGE="https://apps.kde.org/kontact/"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="6"
KEYWORDS="~amd64 ~arm64"
IUSE=""

RDEPEND="
	dev-build/corrosion
	>=kde-apps/kdepim-addons-${PVCUT}:6=
"
DEPEND="${RDEPEND}"

src_prepare() {
    ecm_src_prepare
    ecm_punt_po_install
	ecm_punt_kdoctools_install

	cmake_comment_add_subdirectory korganizer
	cmake_comment_add_subdirectory kmail
	cmake_comment_add_subdirectory kaddressbook
	cmake_comment_add_subdirectory sieveeditor
	cmake_comment_add_subdirectory kmailtransport
	cmake_comment_add_subdirectory kldap
    cmake_comment_add_subdirectory akonadi-import-wizard
    cmake_comment_add_subdirectory pimautogeneratetext
	cmake_comment_add_subdirectory korganizer
	#cmake_comment_add_subdirectory plugins

	cmake_comment_add_subdirectory plugins/customtoolsplugins
	cmake_comment_add_subdirectory plugins/messageviewer
	cmake_comment_add_subdirectory plugins/messageviewerplugins
	cmake_comment_add_subdirectory plugins/messageviewerheaderplugins
	cmake_comment_add_subdirectory plugins/messageviewerconfigureplugins
	cmake_comment_add_subdirectory plugins/plasma
	cmake_comment_add_subdirectory plugins/templateparser
	#cmake_comment_add_subdirectory plugins/webengineurlinterceptor
}

src_configure() {
	ecm_src_configure
}

src_compile() {
	ecm_src_compile
}

src_install() {
	ecm_src_install
}

