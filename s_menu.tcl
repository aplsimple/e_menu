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
