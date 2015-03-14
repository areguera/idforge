== Environment

LANG::
    Specifies the locale information you want to run the *idforge(1)*
    command with. Normally, the *idforge(1)* command runs with the
    current shell locale information. For example, if your current
    locale information is en_US.UTF and you want to retrieve
    translatable strings from shell scripts for Spanish language
    without changing your current locale information, then you need
    to set the LANG=es variable definition in the *idforge(1)*
    command-line.
IDFORGE_LIBRARY::
    Specifies the directory where the *idforge(1)* command will look
    for common functions and modules.  When this variable isn't
    defined in *idforge(1)* command-line, it takes the
    +/usr/libexec/idforge+ value by default.
IDFORGE_MODELS::
    Specifies the location where organization's specific visual
    identity source files are stored in. When this environment
    variable isn't provided it takes the +/usr/share/idforge/Models+
    value as default.
