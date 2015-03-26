Name:           idforge
Version:        0.2
Release:        1%{?dist}
Summary:        Manage identity manuals in community

Group:          Development/Tools
Vendor:         The CentOS Artwork SIG <centos-devel@centos.org>
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

Obsoletes:      tcar
Obsoletes:      tcar-scripts
Obsoletes:      tcar-models
Obsoletes:      tcar-models-branding
Obsoletes:      tcar-models-distribution
Obsoletes:      tcar-models-documentation
Obsoletes:      tcar-models-marketing
Obsoletes:      tcar-models-webenv

%description
The idFORGE Framework exists to improve the visual recognition of your
organization. It provides standard procedures to rebuild the visual
identity manual of a particular organization and the files necessary
for its implementation, using customized visual styles.  In this
context, the organization publishes the source files describing its
visual identity and allows others (e.g., you) to provide visual styles
to customize it.

The idFORGE Framework results useful for organizations and projects
that need to "refresh" their visual style within frequent periods of
time (e.g., every two years approximately) without altering their
visual identity structure.  For example, whenever the CentOS Project
(the organization) releases a new major release of CentOS GNU/Linux
distribution (visual manifestation) it must have a new image (visual
style) to differentiate it from other major releases of the same
visual manifestation. This major change of image demands the CentOS
Project to propagate the new visual style to dependent visual
manifestation (e.g., web sites, documentation, promotion stuff, etc.)
so they can be all recognized as a single visual unit. This visual
consistency renders a huge impact in the way the organization presents
itself both internally and externally; so it is the mission and vision
that motivates idFORGE Framework development.

Install the %{name} package if you want to create a community focused
in the effort needed to conceived the visual identity manual of your
organization and the files necessary for implementing it.

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
%doc README INSTALL COPYING NEWS CHANGES
%{_mandir}/man1/%{name}.1.gz
%{_mandir}/man1/%{name}-*.1.gz
%{_mandir}/man5/%{name}-*.5.gz
%{_bindir}/%{name}
%{_datadir}/%{name}
%{_libexecdir}/%{name}


%changelog
* Thu Mar 26 2015 Alain Reguera Delgado <alain.reguera@gmail.com> - 0.2-1
- Update to idFORGE Framework v0.2
