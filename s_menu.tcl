#! /usr/bin/env tclsh

# Sources and runs e_menu as 'mega-widget'.
# A single window of menu will be visible at any level.

source [file join [file dirname [info script]] e_menu.tcl]

foreach ::em::TMP1 {th td SH} {
  if {[set ::em::TMP2 [lsearch -glob $::argv $::em::TMP1=*]]>-1} {
    set ::em::$::em::TMP1 [string range [lindex $::argv $::em::TMP2] 3 end]
  }
}
if {$::em::th ne {}} {
  lassign [::apave::InitTheme $::em::th $::em::srcdir] ::em::TMP1 ::em::TMP2
  ::apave::initWM -theme $::em::TMP1 -labelborder $::em::TMP2 -isbaltip $::em::isbaltip
}
unset ::em::TMP1
unset ::em::TMP2

::em::main -modal 1 -remain 0 {*}$::argv ;# -modal/-remain can be reset in ::argv
exit

# to test the 'mega-widget':

#? proc ::e_menu {modal remain} {
#? ::em::main -modal $modal -remain $remain "md=~/.tke/plugins/e_menu/menus" m=menu.mnu "f=%d/%f" "d=%d" "PD=~/PG/e_menu_PD.txt" "s1=%d" "TF=%d/%f" "s=%s" "z2=%f" "z5=~" l=%l b=chromium h=~/DOC/www.tcl.tk/man/tcl8.6 "tt=xterm -fs 12 -geometry 90x30+400+100" om=0 fs=10 g=285x500+400+100 sh=1
#? }
#? wm geometry . 1x1+0+0
#? toplevel .tl
#? wm geometry .tl +700+400
#? button .tl.btn1 -text "e_menu" -command {::e_menu 0 1}
#? button .tl.btn2 -text "          exit          " -command exit
#? pack .tl.btn1 .tl.btn2 -fill x
#? after 100 {focus -force .tl.btn1}
