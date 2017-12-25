Name:      ovm-template-config-jpougadv
Version:   1.0
Release:   1%{?dist}
Summary:   Oracle VM template jpougadv configuration script.
License:   GPL
URL:       https://gowatana.blogspot.jp/2017/12/ovm-template-config
Source0:   %{name}-%{version}.tar.gz
BuildRoot: %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)
BuildArch: noarch
Requires:  ovm-template-config

%description
Oracle VM template JPOUG Advent Calendar message configuration script.

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%post
if [ $1 = 1 ]; then
    /usr/sbin/ovm-chkconfig --add jpougadv
fi

%preun
if [ $1 = 0 ]; then
    /usr/sbin/ovm-chkconfig --del jpougadv
fi

%files
%defattr(-,root,root,-)
%{_sysconfdir}/template.d/scripts/jpougadv

%changelog
* Mon Dec 25 2017 gowatana - 1.0-1
- Initial build.
