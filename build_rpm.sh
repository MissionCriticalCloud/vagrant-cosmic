#!/bin/bash
VERSION=1.5.0
mkdir -p /tmp/vagrant-cosmic-build_rpm.$$/vagrant-cosmic-$VERSION
cp -r . /tmp/vagrant-cosmic-build_rpm.$$/vagrant-cosmic-$VERSION/
tar -C /tmp/vagrant-cosmic-build_rpm.$$/ -czf ~/rpmbuild/SOURCES/vagrant-cosmic-$VERSION.tar.gz vagrant-cosmic-$VERSION
rpmbuild --define "gemver $VERSION" -bb vagrant-cosmic.spec
rm -rf /tmp/vagrant-cosmic-build_rpm.$$
