#!/bin/gawk

$3 >= 500 && $3 <= 700 {
    printf "%s <%s@%s>\n", $5, $1, DOMAINNAME
    u = u + 1
}

END {
    printf _"%s\nTotal Users: %d\n", "------------------------------------------------------------------", u
}

