%define gemdir /usr/lib/vagrant-cosmic/gems
Name:	 vagrant-cosmic
Version:	%{gemver}
Release:	3%{?dist}
Summary:	vagrant cosmic plugin

License:	MIT
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

Source0:        vagrant-cosmic-%{version}.tar.gz
BuildRequires:  rubygems 
Requires:	vagrant >= 1.2.0 libxml2-devel libxslt-devel libffi-devel ruby-devel

%description
vagrant cosmic


%prep
%setup -q

%build
env LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 bundle package
env LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 gem build vagrant-cosmic.gemspec


%install
mkdir -p %{buildroot}/%{gemdir}
cp vagrant-cosmic-%{version}.gem %{buildroot}/%{gemdir}
cp vendor/cache/*.gem %{buildroot}/%{gemdir}


%clean
rm -rf %{buildroot}


%post
cd %{gemdir}
gem install --local fog --no-rdoc --no-ri

%files
%defattr(-,root,root,-)
%{gemdir}
