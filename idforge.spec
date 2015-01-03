Name:           idforge
Version:        0.1.7
Release:        1%{?dist}
Summary:        Manage corporate identity manuals in community

Group:          Development/Tools
Vendor:         CentOS Artwork SIG
License:        GPLv2+
URL:            http://wiki.centos.org/ArtWork/Framework
Source0:        http://wiki.centos.org/ArtWork/Framework/%{name}-%{version}.tar.gz

BuildArch:      noarch

BuildRequires:  gettext
BuildRequires:  qatest
BuildRequires:  tcar >= 0.11

%description
idforge is a framework to manage corporate identity manuals in
community. It gears the work of graphic designers, translators,
programmers and packagers using a modular design and standard
procedures that can be reused by different organizations.

idforge provides a publishing medium for organizations who want to
distribute normative information needed to reproduce their corporate
identity manual. Including the organization's brand, colors, visual
manifestations, and configuration files describing how these
components must be combined to achieve predictable results. For
graphic designers, it provides a tool to reproduce corporate identity
manuals consistently using customized artistic motif and the normative
specifications the organizations have provided.

idforge results useful for communities who need to distribute the
construction, maintenance and implementation of their own corporate
identity manuals. And this way, in community, reducing the work load
needed to renew it.

%build
make build NAME=%{name} VERSION=%{version}

%prep
%setup -q

%install
rm -rf ${RPM_BUILD_ROOT}
make install NAME=%{name} VERSION=%{version} DESTDIR=${RPM_BUILD_ROOT}

%find_lang %{name}

%check
make test DESTDIR=${RPM_BUILD_ROOT}

%clean
rm -rf ${RPM_BUILD_ROOT}

%files -f %{name}.lang
%defattr(-,root,root,-)
%doc README INSTALL NEWS LICENSE
%{_mandir}/man1/%{name}.1.gz
%{_mandir}/man5/%{name}-modules.5.gz
%{_bindir}/%{name}
%{_libexecdir}/%{name}


%changelog
* Fri Oct 24 2014 Alain Reguera Delgado <alain.reguera@gmail.com> - 0.1.7-1
- Rebuild to introduce upstream changes. See the NEWS file.

* Fri Oct 24 2014 Alain Reguera Delgado <alain.reguera@gmail.com> - 0.1.6-1
- Rebuild to introduce upstream changes. See the NEWS file.

* Thu Oct 23 2014 Alain Reguera Delgado <alain.reguera@gmail.com> - 0.1.5-1
- Rebuild to introduce upstream changes. See the NEWS file.

* Thu Oct 23 2014 Alain Reguera Delgado <alain.reguera@gmail.com> - 0.1.4-1
- Rebuild to introduce upstream changes. See the NEWS file.

* Thu Oct 23 2014 Alain Reguera Delgado <alain.reguera@gmail.com> - 0.1.3-1
- Rebuild to introduce upstream changes. See the NEWS file.

* Wed Oct 22 2014 Alain Reguera Delgado <alain.reguera@gmail.com> - 0.1.2-1
- Rebuild to introduce upstream changes. See the NEWS file.

* Wed Oct 22 2014 Alain Reguera Delgado <alain.reguera@gmail.com> - 0.1.1-1
- Rebuild to introduce upstream changes. See the NEWS file.

* Wed Oct 22 2014 Alain Reguera Delgado <alain.reguera@gmail.com> - 0.1-1
- Initial build.
