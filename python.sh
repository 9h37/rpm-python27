PYTHON_VERSION=2.7.3
MD5_PYTHON=c57477edd6d18bd9eeca2f21add73919
BUILD_DIR=/root/
yum -y install rpmdevtools tk-devel tcl-devel expat-devel db4-devel \
                  gdbm-devel sqlite-devel bzip2-devel openssl-devel \
                  ncurses-devel readline-devel make
rpmdev-setuptree
wget http://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.bz2 \
     -O $BUILD_DIR/rpmbuild/SOURCES/Python-$PYTHON_VERSION.tar.bz2
python_src=$BUILD_DIR/rpmbuild/SOURCES/Python-$PYTHON_VERSION.tar.bz2
check=$(md5sum $python_src | grep --only-matching -m 1 '^[0-9a-f]*')
if [ $MD5_PYTHON = $check ];then
	QA_RPATHS=$[ 0x0001|0x0010 ] rpmbuild -bb $BUILD_DIR/rpmbuild/SPECS/python27-$PYTHON_VERSION.spec
	echo "Finish"
else
	echo "Checksum failed"
	exit 1
fi
