EAPI=8

GIT_COMMIT=54c140399bbc3e6a3dce6c9f842727c4128367be
SRC_URI="https://github.com/DHowett/framework-ec/archive/${GIT_COMMIT}.tar.gz -> $P.tar.gz"
DESCRIPTION="EC manipulation tool for the Framework Laptop"
HOMEPAGE=https://github.com/DHowett/framework-ec
LICENSE=BSD-3
SLOT=0
KEYWORDS=amd64
S=$WORKDIR/framework-ec-$GIT_COMMIT

src_compile()
{
  cd $S && make utils
}

src_install()
{
  cd $S/build/bds/util && dosbin ectool
}
