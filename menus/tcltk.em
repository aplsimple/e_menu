[OPTIONS]

pos=23.0
in=1.0
w=25

[MENU]

ITEM = Tkcon
RE: tkcon

ITEM = Tclsh
SE: tclsh

ITEM = Wish
RE: wish

ITEM = Console
RE: xterm -fa ru_RU.utf8 -fs 15 -geometry 80x32+300+100 -bg #25292B -fg white

ITEM = rlwrap Tclsh
RE: lxterminal -e "rlwrap -p'1;36;40' /usr/bin/tclsh"

[DATA]
