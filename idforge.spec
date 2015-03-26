Name:           idforge
Version:        0.2
Release:        1%{?dist}
Summary:        Manage identity manuals in community

Group:          Development/Tools
Vendor:         The CentOS Artwork SIG
License:        GPLv2+
URL:            http://wiki.centos.org/ArtWork/Framework
Source0:        http://wiki.centos.org/ArtWork/Framework/%{name}-%{version}.tar.gz

BuildArch:      noarch

BuildRequires:  bash
BuildRequires:  coreutils, findutils, gawk, gzip, grep, tar, diffutils, sed, util-linux-ng, file, make
BuildRequires:  gettext, asciidoc, docbook-style-xsl, fop, gnome-doc-utils

Requires:       bash
Requires:       coreutils, findutils, gawk, gzip, grep, tar, diffutils, sed, util-linux-ng, file
Requires:       gettext, asciidoc, docbook-style-xsl, fop, gnome-doc-utils
Requires:       inkscape, ImageMagick, netpbm-progs, syslinux-perl
Requires:       gnupg2
Requires:       mailx

%description
The idFORGE Framework provides standard procedures to rebuild the
visual identity manual of a particular organization and the files
necessary for its implementation, using your own visual style.
Normally, one organization publishes the source files about its visual
identity in an RPM package for you to install it in your workstations,
prepare a workplace where you provide the visual style you want to
apply, and rebuild everything.

The idFORGE Framework results useful for organizations that want to
"refresh" the visual style of its visual identity structure frequently
(e.g., every two years approximately).

Install %{name} package if you want to rebuild visual identity manuals
and the files necessary for their implementation in community.

%build
make build NAME=%{name} VERSION=%{version}

%prep
%setup -q

%install
rm -rf ${RPM_BUILD_ROOT}
make install NAME=%{name} VERSION=%{version} DESTDIR=${RPM_BUILD_ROOT}

%find_lang %{name} --with-man
%find_lang %{name}-config --with-man
%find_lang %{name}-hello --with-man
%find_lang %{name}-locale --with-man
%find_lang %{name}-prepare --with-man
%find_lang %{name}-qatest --with-man
%find_lang %{name}-render --with-man
%find_lang %{name}-tuneup --with-man
%find_lang %{name}-usage --with-man
%find_lang %{name}-version --with-man
%find_lang %{name}-modules --with-man

%check
#make test NAME=%{name} DESTDIR=${RPM_BUILD_ROOT}

%clean
rm -rf ${RPM_BUILD_ROOT}

%files -f %{name}.lang
%files -f %{name}-render.lang
%files -f %{name}-tuneup.lang
%files -f %{name}-prepare.lang
%files -f %{name}-locale.lang
%files -f %{name}-version.lang
%files -f %{name}-usage.lang
%files -f %{name}-config.lang
%files -f %{name}-qatest.lang
%files -f %{name}-hello.lang
%files -f %{name}-modules.lang

%defattr(-,root,root,-)
%doc README INSTALL LICENSE
%{_mandir}/man1/%{name}.1.gz
%{_mandir}/man1/%{name}-*.1.gz
%{_mandir}/man5/%{name}-*.5.gz
%{_bindir}/%{name}
%{_datadir}/%{name}
%{_libexecdir}/%{name}


%changelog
* Wed Mar 25 2015 Alain Reguera Delgado <alain.reguera@gmail.com> - 0.2-1
- Update to idFORGE Framework v0.2
