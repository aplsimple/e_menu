#! /usr/bin/env tclsh

#####################################################################

# Additional functions for e_menu.tcl.
# These are put here to source them at need only.

proc ::em::mergePosList {none args} {

  # Merges lists of numbers that are not-coinciding and sorted.
  #   none - a number to be not allowed in the lists (e.g. less than minimal)
  #   args - list of the lists to be merged
  # Returns a list of pairs: index of list + item of list.
  # E.g.
  #   mergePosList -1 {1 5 8} {2 3 9 12} {0 6 10}
  #   => {2 0} {0 1} {1 2} {1 3} {0 5} {2 6} {0 8} {1 9} {2 10} {1 12}

  set itot [set ilist 0]
  set lind [set lout [list]]
  foreach lst $args {
    incr ilist
    incr itot [set llen [llength $lst]]
    lappend lind [list 0 $llen]
  }
  for {set i 0} {$i<$itot} {incr i} {
    set min $none
    set ind -1
    for {set k 0} {$k<$ilist} {incr k} {
      lassign [lindex $lind $k] li llen
      if {$li < $llen} {
        set e [lindex [lindex $args $k] $li]
        if {$min == $none || $min > $e} {
          set ind $k
          set min $e
          set savli [incr li]
          set savlen $llen
        }
      }
    }
    if {$ind == -1} {return -code error {Error: probably in the input data}}
    lset lind $ind [list $savli $savlen]
    lappend lout [list $ind $min]
  }
  return $lout
}

#####################################################################

proc ::em::countCh {str ch {plistName ""}} {

  # Counts a character in a string.
  #   str - a string
  #   ch - a character
  #   plistName - variable name for a list of positions of *ch*
  #
  # Returns a number of non-escaped occurences of character *ch* in
  # string *str*.
  #
  # See also:
  # [wiki.tcl-lang.org](https://wiki.tcl-lang.org/page/Reformatting+Tcl+code+indentation)

  if {$plistName ne ""} {
    upvar 1 $plistName plist
    set plist [list]
  }
  set icnt [set begidx 0]
  while {[set idx [string first $ch $str]] >= 0} {
    set backslashes 0
    set nidx $idx
    while {[string equal [string index $str [incr nidx -1]] \\]} {
      incr backslashes
    }
    if {$backslashes % 2 == 0} {
      incr icnt
      if {$plistName ne ""} {lappend plist [expr {$begidx+$idx}]}
    }
    incr begidx [incr idx]
    set str [string range $str $idx end]
  }
  return $icnt
}

proc ::em::countCh2 {str ch {plistName ""}} {

  # Counts a character in a string.
  #   str - a string
  #   ch - a character
  #   plistName - variable name for a list of positions of *ch*
  # Returns a number of ANY occurences of character *ch* in string *str*.
  # See also: my::CountChar

  if {$plistName ne ""} {
    upvar 1 $plistName plist
    set plist [list]
  }
  set icnt [set begidx 0]
  while {[set idx [string first $ch $str]] >= 0} {
    set nidx $idx
    incr icnt
    if {$plistName ne ""} {lappend plist [expr {$begidx+$idx}]}
    incr begidx [incr idx]
    set str [string range $str $idx end]
  }
  return $icnt
}

###########################################################################

proc ::em::matchedBrackets {inplist curpos schar dchar dir} {

  # Finds a match of characters (dchar for schar).
  #   inplist - list of strings where to find a match
  #   curpos - position of schar in nl.nc form where nl=1.., nc=0..
  #   schar - source character
  #   dchar - destination character
  #   dir - search direction: 1 to the end, -1 to the beginning of list

  lassign [split $curpos .] nl nc
  if {$dir==1} {set rng1 "$nc end"} else {set rng1 "0 $nc"; set nc 0}
  set retpos ""
  set scount [set dcount 0]
  incr nl -1
  set inplen [llength $inplist]
  while {$nl>=0 && $nl<$inplen} {
    set line [lindex $inplist $nl]
    set line [string range $line {*}$rng1]
    set sc [countCh2 $line $schar slist]
    set dc [countCh2 $line $dchar dlist]
    set plen [llength [set plist [mergePosList -1 $slist $dlist]]]
    for {set i [expr {$dir>0?0:($plen-1)}]} {$i>=0 && $i<$plen} {incr i $dir} {
      lassign [lindex $plist $i] src pos
      if {$src} {incr dcount} {incr scount}
      if {$scount <= $dcount} {
        set retpos [incr nl].[incr pos $nc]
        break
      }
    }
    if {$retpos ne ""} break
    set nc 0
    set rng1 "0 end"
    incr nl $dir
  }
  return $retpos
}
#=== make popup menu
proc ::em::iconA {{icon none}} {
  return "-image [::apave::iconImage $icon] -compound left"
}
proc ::em::createpopup {} {
  menu .em.emPopupMenu
  .em.emPopupMenu add command {*}[iconA folder] -accelerator Ctrl+P \
    -label "Project..." -command {::em::change_PD}
  .em.emPopupMenu add separator
  .em.emPopupMenu add command {*}[iconA change] -accelerator Ctrl+E \
    -label "Edit the menu" -command {after 50 ::em::edit_menu}
  if {($::em::solo || [is_s_menu]) && ![is_child]} {
    .em.emPopupMenu add command {*}[iconA retry] -accelerator Ctrl+R \
      -label "Restart e_menu" -command ::em::restart_e_menu
  } else {
    .em.emPopupMenu add command {*}[iconA retry] -accelerator Ctrl+R \
      -label "Reread the menu" -command ::em::reread_init
  }
  .em.emPopupMenu add command {*}[iconA delete] -accelerator Ctrl+D \
    -label "Destroy other menus" -command ::em::destroy_emenus
  .em.emPopupMenu add separator
  .em.emPopupMenu add command {*}[iconA plus] -accelerator Ctrl+> \
    -label "Increase the menu's width" -command {::em::win_width 1}
  .em.emPopupMenu add command {*}[iconA minus] -accelerator Ctrl+< \
    -label "Decrease the menu's width" -command  {::em::win_width -1}
  .em.emPopupMenu add separator
  .em.emPopupMenu add command {*}[iconA info] -accelerator F1 \
    -label "About" -command ::em::about
  .em.emPopupMenu add separator
  .em.emPopupMenu add command {*}[iconA exit] -accelerator Esc \
    -label "Exit" -command ::em::on_exit
  .em.emPopupMenu configure -tearoff 0
}
#=== call the e_menu's popup menu
proc ::em::popup {X Y} {
    set ::em::skipfocused 1
    if {[winfo exist .em.emPopupMenu]} {destroy .em.emPopupMenu}
    ::em::createpopup
    ::apave::paveObj themePopup .em.emPopupMenu
    tk_popup .em.emPopupMenu $X $Y
}
#=== highlights R/S/M in menu's text
proc ::em::menuTextModified {w boldfont} {

  # Handles modifications of menu's text: highlights R/S/M
  #   w - text's path
  #   boldfont - font of boldness
  # The `w` might be omitted because it's a `my TexM` of APaveDialog.
  # It's here only to provide a template for similar handlers.

  set curpos [$w index insert]
  set text [$w get 1.0 end]
  $w tag config tagRSM -font $boldfont
  # firstly, to highlight R/S/M
  foreach line [split $text \n] {
    incr il
    $w tag remove tagRSM $il.0 $il.end
    set nomarkers 1
    foreach marker [::em::allMarkers] {
      if {[string first $marker [string trimleft $line]]!=0} continue
      set p1 [string first $marker $line]
      set p2 [string first $marker $line $p1+1]
      if {$p2>$p1} {
        set nomarkers 0
        $w tag add tagRSM $il.[expr {$p1+[string length $marker]}] \
          [$w index "$il.$p2 +0 chars"]
        break
      }
    }
    if {$nomarkers} {
      foreach section {MENU OPTIONS HIDDEN} {
        if {[string trimleft $line] eq "\[$section\]"} {
          set nomarkers 0
          $w tag add tagRSM $il.0 $il.end
          break
        }
      }
    }
  }
}
#=== bindings to highlight matches
proc ::em::set_highlight_matches {w} {
  $w tag configure hilited -foreground #280000 -background #f88eca
  $w tag configure hilited2 -foreground #280000 -background #ff6587
  bind $w <Double-ButtonPress-1> [list ::em::highlight_matches $w]
  bind $w <KeyRelease> [list + ::em::unhighlight_matches $w]
  bind $w <Alt-Left> "::em::seek_highlight $w 0 ; break"
  bind $w <Alt-Right> "::em::seek_highlight $w 1 ; break"
  foreach {kq kw} {q w Q W} {
    bind $w <Alt-$kq> [list ::em::seek_highlight $w 2]
    bind $w <Alt-$kw> [list ::em::seek_highlight $w 3]
  }
}
#=== gets a selected word after double-clicking
proc ::em::get_highlighted {txt} {
  set err [catch {$txt tag ranges sel} sel]
  lassign $sel pos pos2
  if {!$err && [llength $sel]==2} {
    set sel [$txt get $pos $pos2]  ;# single selection
  } else {
    if {$err || [string trim $sel]==""} {
      set pos  [$txt index "insert wordstart"]
      set pos2 [$txt index "insert wordend"]
      set sel [string trim [$txt get $pos $pos2]]
      if {![string is wordchar -strict $sel]} {
        # when cursor just at the right of word: take the word at the left
        # e.g. if "_" stands for cursor then "word_" means selecting "word"
        set pos  [$txt index "insert -1 char wordstart"]
        set pos2 [$txt index "insert -1 char wordend"]
        set sel [$txt get $pos $pos2]
      }
    }
  }
  if {[string length $sel] == 0} {set pos ""}
  return [list $sel $pos $pos2]
}
#=== highlights matches of selected word
proc ::em::highlight_matches {txt} {
  lassign [::em::get_highlighted $txt] sel pos
  if {$pos eq ""} return
  set lenList {}
  set posList [$txt search -all -count lenList -- "$sel" 1.0 end]
  foreach pos2 $posList len $lenList {
    if {$len eq ""} {set len [string length $sel]}
    set pos3 [$txt index "$pos2 + $len chars"]
    if {$pos2 == $pos} {
      lappend matches2 $pos2 $pos3
    } else {
      lappend matches1 $pos2 $pos3
    }
  }
  catch {
    $txt tag remove hilited 1.0 end
    $txt tag remove hilited2 1.0 end
    $txt tag add hilited {*}$matches1
    $txt tag add hilited2 {*}$matches2
  }
  set ::em::hili yes
}
#=== unhighlights matches of selected word
proc ::em::unhighlight_matches {txt} {
  if {$::em::hili} {
    $txt tag remove hilited 1.0 end
    $txt tag remove hilited2 1.0 end
    set ::em::hili no
  }
}
#=== Seek the selected word forward/backward/to first/to last
proc ::em::seek_highlight {txt mode} {
  ::em::unhighlight_matches $txt
  lassign [::em::get_highlighted $txt] sel pos pos2
  if {!$pos} return
  switch $mode {
    0 { # backward
      set nc [expr {[string length $sel] - 1}]
      set pos [$txt index "$pos - $nc chars"]
      set pos [$txt search -backwards -- $sel $pos 1.0]
    }
    1 { # forward
      set pos [$txt search -- $sel $pos2 end]
    }
    2 { # to first
      set pos [$txt search -- $sel 1.0 end]
    }
    3 { # to last
      set pos [$txt search -backwards -- $sel end 1.0]
    }
  }
  if {[string length "$pos"]} {
    ::tk::TextSetCursor $txt $pos
    $txt tag add sel $pos [$txt index "$pos + [string length $sel] chars"]
  }
}
#=== bindings to highlight brackets
proc ::em::menuTextBrackets {w fg boldfont} {

  # Makes bindings to highlight brackets of menu's text: {}()[]
  #   w - text's path
  #   fg - foreground color to select {}()[]
  #   boldfont - font of boldness
  # The `w` might be omitted because it's a `my TexM` of APaveDialog.
  # It's here only to provide a template for similar handlers.
  foreach ev {Enter KeyRelease ButtonRelease} {
    bind $w <$ev> [list + ::em::highlightBrackets $w $fg $boldfont]
  }
}
proc ::em::highlightBrackets {w fg boldfont} {
  # secondly, highlight brackets if any
  $w tag delete tagBRACKET
  $w tag delete tagBRACKETERR
  $w tag config tagBRACKET -foreground $fg -font $boldfont
  $w tag config tagBRACKETERR -foreground white -background red
  set curpos [$w index insert]
  set curpos2 [$w index "insert -1 chars"]
  set ch [$w get $curpos]
  set lbr "\{(\["
  set rbr "\})\]"
  set il [string first $ch $lbr]
  set ir [string first $ch $rbr]
  set txt [split [$w get 1.0 end] \n]
  if {$il>-1} {
    set brcpos [matchedBrackets $txt $curpos \
      [string index $lbr $il] [string index $rbr $il] 1]
  } elseif {$ir>-1} {
    set brcpos [matchedBrackets $txt $curpos \
      [string index $rbr $ir] [string index $lbr $ir] -1]
  } elseif {[set il [string first [$w get $curpos2] $lbr]]>-1} {
    set curpos $curpos2
    set brcpos [matchedBrackets $txt $curpos \
      [string index $lbr $il] [string index $rbr $il] 1]
  } elseif {[set ir [string first [$w get $curpos2] $rbr]]>-1} {
    set curpos $curpos2
    set brcpos [matchedBrackets $txt $curpos \
      [string index $rbr $ir] [string index $lbr $ir] -1]
  } else {
    return
  }
  if {$brcpos ne ""} {
    $w tag add tagBRACKET $brcpos
    $w tag add tagBRACKET $curpos
  } else {
    $w tag add tagBRACKETERR $curpos
  }
}
#=== edit file(s)
proc ::em::edit {fname {prepost ""}} {
  set fname [string trim $fname]
  lassign [::apave::paveObj csGet] bg - fg  - - - - - - fgc
  if {$::em::editor eq ""} {
    set fs [::apave::paveObj basicFontSize]
    set bfont "[font configure TkFixedFont] -weight bold -size $fs"
    set dialog [::apave::APaveInput new]
    set ico [::apave::paveObj iconA none]
    set res [$dialog editfile $fname $::em::clrtitf $::em::clrinab $::em::clrtitf \
      $prepost {*}[::em::theming_pave] -w {80 100} -h {10 24} -ro 0 -centerme .em \
      -myown [list my TextCommandForChange %w "::em::menuTextModified %w {$bfont}"\
       true "::em::menuTextBrackets %w $fgc {$bfont}"] \
      -myown [list ::em::set_highlight_matches %w] \
      -popup "\$pop add separator
         \$pop add command -accelerator Alt+Q $ico \\
         -label \"Highlight First\" -command \"::em::seek_highlight %w 2\"
         \$pop add command -accelerator Alt+W $ico \\
         -label \"Highlight Last\" -command \"::em::seek_highlight %w 3\"
         \$pop add command -accelerator Alt+Left $ico \\
         -label \"Highlight Previous\" -command \"::em::seek_highlight %w 0\"
         \$pop add command -accelerator Alt+Right $ico \\
         -label \"Highlight Next\" -command \"::em::seek_highlight %w 1\"
         \$pop add command -accelerator 2Click $ico \\
         -label \"Highlight All\" -command \"::em::highlight_matches %w\""]
    $dialog destroy
    return $res
  } else {
    if {[catch {exec $::em::editor {*}$fname &} e]} {
      em_message "ERROR: couldn't call $::em::editor'\n
to edit $fname.\n\nCurrent directory is [pwd]\n\nMaybe $::em::editor\n is worth including in PATH?"
      return false
    }
  }
  return true
}
#=== pre and post for edit (e.g. get/set position of cursor)
proc ::em::prepost_edit {refdata {txt ""}} {
  upvar 1 $refdata data
  set opt [set i 0]
  set attr "pos="
  set datalist [split [string trimright $data] \n]
  foreach line $datalist {
    if {$line eq {[OPTIONS]}} {
      set opt 1
    } elseif {$opt && [string match "${attr}*" $line]} {
      break
    } elseif {$line eq {[MENU]} || $line eq {[HIDDEN]}} {
      set opt 0
    }
    incr i
  }
  if {!$opt && $txt eq ""} {return ""}  ;# if no OPTIONS section, nothing to do
  if {$txt eq ""} {
    # it's PRE
    lassign [regexp -inline "^${attr}(.*)" $line] line pos
    if {$line ne ""} {set line "-pos $pos"}
    return $line  ;# 'position of cursor' attribute
  } else {
    # it's POST
    set attr "${attr}[$txt index insert]"
    if {$opt} {
      lset datalist $i $attr
    } else {
      lappend datalist \n {[OPTIONS]} $attr   ;# long live OPTIONS
    }
    set data [join $datalist \n]
  }
}
#=== edit current menu
proc ::em::edit_menu {} {
  if {[::em::edit $::em::menufilename ::em::prepost_edit]} {
    # colors can be changed, so "reread_menu" with setting colors
    foreach w [winfo children .em] {  ;# remove Tcl/Tk menu items
      destroy $w
    }
    ::em::initdefaultcolors
    initcomm
    ::em::initcolorscheme
    initmenu
    mouse_button $::em::lasti
  } else {
    repaintForWindows
  }
}
#=== help
proc ::em::about {} {
  set textTags [list [list "red" " -font {-weight bold -size 12} \
    -foreground $::em::clractf -background $::em::clractb"] \
    [list "link" "::eh::browse %t@@https://%l"] \
    [list "linkM" "::apave::openDoc %l@@e-mail: %l"] \
    ]
  set width [expr {max(33,[string length $::em::argv0])}]
  set doc "https://aplsimple.github.io/en/tcl/e_menu"
  set dialog [::apave::APaveInput new]
  set res [$dialog misc info "About e_menu" "
  <red> $::em::em_version </red>
  [file dirname $::em::argv0] \n
  by Alex Plotnikov
  <linkM>aplsimple@gmail.com</linkM>
  <link>aplsimple.github.io</link>
  <link>chiselapp.com/user/aplsimple</link> \n" "{Help:: $doc } 1 Close 0" \
    0 -t 1 -w $width -scroll 0 -tags textTags -head \
    "\n Menu system for editors and file managers. \n" \
    -centerme .em {*}[theming_pave]]
  $dialog destroy
  if {[lindex $res 0]} {::eh::browse $doc}
  repaintForWindows
}
#=== check if it's s_menu
proc ::em::is_s_menu {} {
  return [expr {[file rootname [file tail $::em::argv0]] eq "s_menu"}]
}
#=== restart the app
proc ::em::restart_e_menu {} {
  if {[is_s_menu] && [file extension $::em::argv0] ne ".tcl"} {
    exec $::em::argv0 {*}$::em::argv &
  } else {
    execom "tclsh \"$::em::argv0\" $::em::argv &"
  }
  on_exit
}
#=== reread and autorun
proc ::em::reread_init {} {
  reread_menu $::em::lasti
  set ::em::filecontent {}
  initauto
}
#=== destroy all e_menu apps
proc ::em::destroy_emenus {} {
  if {[em_question "Clearance - $::em::appname" \
  "\n  Destroy all e_menu applications?  \n"]} {
    for {set i 0} {$i < 3} {incr i} {
      for {set nap 1} {$nap <= 64} {incr nap} {
        set app $::em::thisapp$nap
        if {$nap != $::em::appN} {::eh::destroyed $app}
      }
    }
    if {$::em::ischild || $::em::geometry eq ""} {
      destroy .  ;# do not kill self if am a parent app with geometry passed
    }
  }
  repaintForWindows
}
#=== get color scheme's attributes for 'Project...' dialog
proc ::em::change_PD_Spx {} {
  lassign [::apave::paveObj csGet $::em::ncolor] - fg - bg
  set labmsg [dialog LabMsg]
  set font [font configure TkFixedFont]
  set font [dict set font -size $::em::fs]
  set txt [::apave::paveObj csGetName $::em::ncolor]
  set txt [string range [append txt [string repeat " " 20]] 0 20]
  $labmsg configure -foreground $fg -background $bg -font $font \
    -padding {16 5 16 5} -text $txt
}
#=== change a project's directory and other parameters
proc ::em::change_PD {} {
  if {![file isfile $::em::PD]} {
    set em_message "  WARNING:
  \"$::em::PD\" isn't a file.

 \"PD=file of project directories\"
 should be an argument of e_menu to use %PD in menus.  \n"
    set fco1 ""
  } else {
    set em_message "
 Select a project directory from the list of file:\n $::em::PD  \n"
    set fco1 [list \
      fco1 [list {Project:} {} \
      [list -h 10 -state readonly -inpval [get_PD]]] \
      "@@-RE {^(\\s*)(\[^#\]+)\$} {$::em::PD}@@" \
      but1 [list {} {-padx 5} "-com {::em::edit {$::em::PD}; ::em::dialog \
        res .em -1} -takefocus 0 -tooltip {Click to edit\n$::em::PD} \
        -toprev 1 -image [::apave::iconImage file]"] {}]
  }
  if {[::iswindows]} {
    set dkst "disabled"
    set ::em::dk ""
  } else {
    set dkst "normal"
  }
  append em_message \
    "\n 'Color scheme' is -1 .. $::apave::_CS_(MAXCS) selected with Up/Down key.  \n"
  set sa [::apave::shadowAllowed 0]
  set ncolorsav $::em::ncolor
  set geo [wm geometry .em]
  set ornams [list {-1 None} { 0 Top line only} { 1 Header} { 2 Prompts} { 3 All}]
  switch $::em::ornament {
    -1 - 0 - 1 - 2 - 3 {set ornam [lindex $ornams [expr {$::em::ornament+1}]]}
    default {set ornam [lindex $ornams 0]}
  }
  ::apave::APaveInput create ::em::dialog .em
  set r -1
  while {$r == -1} {
    after idle ::em::change_PD_Spx
    set tip1 "Applied anyhow\nexcept for Default CS"
    set res [::em::dialog input "" "Project..." [list \
      {*}$fco1 \
      seh_1 {{} {-pady 10}} {} \
      Spx [list "    Color scheme:" {} \
        [list -tvar ::em::ncolor -from -2 -to $::apave::_CS_(MAXCS) -w 5 \
        -justify center -state $::em::noCS -msgLab {LabMsg {  Color Scheme 1}} \
        -command ::em::change_PD_Spx -tooltip $tip1]] {} \
      chb1 {{} {-padx 5} {-toprev 1 -state $::em::noCS -t "Use it"}} {0} \
      spx2 [list "       Font size:" {} \
        [list -tvar ::em::fs -from 6 -to 32 -w 5 -justify center -msgLab {Lab_ {}} \
        -command ::em::change_PD_Spx -tooltip $tip1]] {} \
      chb12 {{} {-padx 5} {-toprev 1 -t "Use it"}} {0} \
      seh_22 {{} {-pady 10}} {} \
      cbx1 [list {        Ornament:} {} \
        [list -state readonly -width 10 -tooltip $tip1]] [list $ornam {*}$ornams] \
      chb22 {{} {-padx 5} {-toprev 1 -t "Use it"}} {0} \
      seh_2 {{} {-pady 10}} {} \
      ent2 {"Geometry of menu:"} "$geo" \
      chb2 {{} {-padx 5} {-toprev 1 -t "Use it"}} {0} \
      seh_3 {{} {-pady 10}} {} \
      chbT {"    Type of menu:" {-expand 0} {-w 8 -t "topmost"}} $::em::ontop \
      rad3 [list "                 " {-fill x -expand 1} "-state $dkst"] \
        [list "$::em::dk" dialog dock desktop] \
      chb3 {{} {-padx 5} {-toprev 1 -t "Use it"}} {0} \
    ] -head $em_message -weight bold -centerme .em {*}[theming_pave]]
    set r [lindex $res 0]
  }
  ::apave::shadowAllowed $sa
  set ::em::ncolor [::apave::getN $::em::ncolor $ncolorsav -2 $::apave::_CS_(MAXCS)]
  if {$r} {
    if {$fco1 eq ""} {
      lassign $res - - chb1 - chb12 orn chb22 geo chb2 chbT dk chb3
    } else {
      lassign $res - PD - - chb1 - chb12 orn chb22 geo chb2 chbT dk chb3
    }
    set orn [string trim [string range $orn 0 1]]
    # save options to menu's file
    if {$chb1} {::em::save_options c= $::em::ncolor}
    if {$chb12} {::em::save_options fs= $::em::fs}
    if {$chb2} {::em::save_options g= $geo}
    if {$chb22} {::em::save_options o= $orn}
    if {$chb3} {
      ::em::save_options dk= $dk
      ::em::save_options t= $chbT
    }
    if {($fco1 ne "") && ([get_PD] ne $PD)} {
      set ::em::prjname [file tail $PD]
      set ::em::argv [::apave::removeOptions $::em::argv d=* f=*]
      foreach {o v} [list d $PD f "$PD/*"] {lappend ::em::argv "$o=\"$v\""}
    }
    set ::em::argv [::apave::removeOptions $::em::argv c=* fs=* o=* dk=* t=*]
    foreach {o v} [list c $::em::ncolor fs $::em::fs o $orn dk $dk t $chbT] {
      lappend ::em::argv "$o=$v"
    }
    set ::em::argc [llength $::em::argv]

    # the main problems of e_menu's colorizing to solve are:
    #
    #  - e_menu allows to set a color scheme (CS) as an argument (c=)
    #
    #  - e_menu allows to set a part of CS as argument(s) (fg=, fS=...), thus
    #    the appropriate colors of CS are replaced with these ones;
    #    this is good when it's wanted to tune some color(s) of CS to be
    #    applied to the menu; however, this is not applied to dialogs
    #
    #  - e_menu allows to set a whole of CS as arguments (fg=, fS=...), thus
    #    these 'argumented' colors are applied to the menu and dialogs;
    #    this way is followed in TKE editor's e_menu plugin
    #
    #  - e_menu allows to set fI=, bI= arguments for active item's colors;
    #    it's not related to apave's CS and used by e_menu only;
    #    this way is followed in TKE editor's e_menu plugin
    wm deiconify .em
    if {$::em::ncolor>-2} {
      set ::em::optsFromMenu 0
      set instead [::em::insteadCS]
      array unset ::em::ar_geany
      set ::em::insteadCSlist [list]
      if {$instead} {
        # when all colors are set as e_menu's arguments instead of CS,
        # just set the selected CS and remove the 'argumented' colors
        set ::em::argv [::apave::removeOptions $::em::argv \
          fg=* bg=* fE=* bE=* fS=* bS=* cc=* fI=* bI=* fM=* bM=* ht=* hh=* gr=*]
        set ::em::argc [llength $::em::argv]
        initcolorscheme true
        # this reads and shows the menu, with the new CS
        reread_menu $::em::lasti
      } else {
        set ::em::argc [llength $::em::argv]
        unsetdefaultcolors
        initdefaultcolors
        initcolorscheme
        reread_menu $::em::lasti
        # this takes up e_menu's arguments e.g. fS=white bS=green (as part of CS)
        initcolorscheme
      }
    }
  } else {
    set ::em::ncolor $ncolorsav
  }
  ::em::dialog destroy
  repaintForWindows
  return
}
#=== Input dialog for getting data
proc ::em::input {cmd} {
  set dialog [::apave::APaveInput new]
  set dp [string last " == " $cmd]
  if {$dp < 0} {set dp 999999}
  set data [string range $cmd $dp+4 end]
  set cmd "$dialog input [string range $cmd 2 $dp-1] -centerme .em"
  catch {set cmd [subst $cmd]}
  if {[set lb [countCh $cmd \{]] != [set rb [countCh $cmd \}]]} {
    dialog_box ERROR " Number of left braces : $lb\n Number of right braces: $rb \
      \n\n     are not equal!" ok err OK -centerme .em
  }
  set res [eval $cmd [::em::theming_pave]]
  $dialog destroy
  set r [lindex $res 0]
  if {$r && $data ne ""} {
    lassign $res -> {*}$data
    ::em::save_menuvars
  }
  repaintForWindows
  return $r
}
#=== incr/decr window width
proc ::em::win_width {inc} {
  set inc [expr $inc*$::em::incwidth]
  lassign [split [wm geometry .em] +x] newwidth height
  incr newwidth $inc
  if {$newwidth > $::em::minwidth || $inc > 0} {
    wm geometry .em ${newwidth}x${height}
  }
}
#=== get and save a writeable command
proc ::em::writeable_command {cmd} {
  # cmd's contents:
  #   0 .. 2   - a unique mark (e.g. %#A for 'A' mark)
  #   3        - a space
  #   4 .. end - options and a command
  set mark [string range $cmd 0 2]
  set cmd  [string range $cmd [set posc 4] end]
  set pos "1.0"
  set geo +100+100
  set menudata [::em::read_menufile]
  for {set i [set iw [set opt 0]]} {$i<[llength $menudata]} {incr i} {
    set line [lindex $menudata $i]
    if {$line eq {[OPTIONS]}} {
      set opt 1
    } elseif {$opt && [string first $mark $line]==0} {
      set iw $i
      set cmd [string range $line $posc end]
      set i1 [string first "geo=" $cmd]
      set i2 [string first ";" $cmd]
      if {$i1>=0 && $i1<$i2} {
        set geo "[string range $cmd $i1+4 $i2-1]"
        set i1 [string first "pos=" $cmd]
        set i2 [string first " " $cmd]
        if {$i1>0 && $i1<$i2} {
          set pos "[string range $cmd $i1+4 $i2-1]"
          set cmd [string range $cmd $i2+1 end]
        }
      }
    } elseif {$line eq {[MENU]} || $line eq {[HIDDEN]}} {
      set opt 0
    }
  }
  set dialog [::apave::APaveInput new]
  set cmd [string map {"|!|" "\n"} $cmd]
  set res [$dialog misc "" "EDIT: $mark" "$cmd" {"Save & Run" 1 Cancel 0} TEXT \
    -text 1 -ro 0 -w 70 -h 10 -pos $pos {*}[::em::theming_pave] -ontop $::em::ontop \
    -head "UNCOMMENT usable commands, COMMENT unusable ones.\nUse  \\\\\\\\ \
    instead of  \\\\  in patterns." -family Times -hsz 14 -size 12 -g $geo]
  $dialog destroy
  lassign $res res geo cmd
  if {$res} {
    set cmd [string trim $cmd " \{\}\n"]
    set data [string map {"\n" "|!|"} $cmd]
    set data "$mark geo=$geo;pos=$data"
    set cmd [string range $cmd [string first " " $cmd]+1 end]
    if {$iw} {
      set menudata [lreplace $menudata $iw $iw "$data"]
    } else {
      lappend menudata "$data"
    }
    ::em::write_menufile $menudata
    set cmd [string map {"\n" "\\n"} $cmd]
    prepr_name cmd
  } else {
    set cmd ""
  }
  ::em::focused_win 1
  return $cmd
}
#=== start subtask(s)
proc ::em::start_sub {ind istart ipos sub typ c1 sel} {
  set ::em::ipos $ipos
  if {$ipos == 0 || $sub eq ""} {
    shell_run "Nobutt" $typ $c1 - "&" $sel  ;# this task is current menu item
    if {$ind == $istart} {return true}  ;# safeguard from double start
  } else {
    run_a_ah $sub
  }
  return false
}
#=== get subtask info
proc ::em::get_subtask {linf ipos} {
  return [split [lindex $linf $ipos] ":"]
}
#=== start timed task(s)
proc ::em::start_timed {{istart -1}} {
  set istarted 0
  for {set repeat 1} {$repeat} {} {
    set repeat 0
    set ind 0
    foreach tti $::em::taski { ;# values in sec
      lassign $tti isec ipos iN
      lassign [lindex $::em::tasks $ind] inf typ c1 sel
      if {$ipos==0} {
        incr iN
      }
      set ::em::TN $iN
      set csec [clock seconds]
      if {$csec >= $isec} {
          # check for subtask e.g. -45*60/-15*60:ah=2,3/.../0
        set inf [string trim $inf /]
        set linf [split $inf /]   ;# subtasks are devided with "/"
        set ll [llength $linf]    ;# ipos is position of current subtask
        lassign [get_subtask $linf $ipos] isec sub ;# current subtask
        if {[start_sub $ind $istart $ipos $sub $typ $c1 $sel]} {
          set istarted 1
        }
        if {[incr ipos] >= $ll} {
          set ipos 0
          lassign [get_subtask $linf $ipos] isec sub ;# 1st subtask
        } else {  ;# process subtask
          lassign [get_subtask $linf $ipos] isec sub ;# new subtask
          if {[string first "TN=" $isec]==0} {
            if {$iN >= [::apave::getN [string range $isec 3 end]]} {
              run_a_ah $sub
              ttask "del" $ind  ;# end of task if TN of cycles
              set repeat 1      ;# are completed
              break
            }
            if {[incr ipos] >= $ll} {
              set ipos 0
              set isec "0"
            } else {
              lassign [get_subtask $linf $ipos] isec sub
            }
          } else {  ;# if interval>0, run now
            if {$isec ne "" && [string range $isec 0 0] ne "-"} {
              if {[start_sub $ind $istart $ipos $sub $typ $c1 $sel]} {
                set istarted 1
              }
            }
          }
        }
          # update the current task
        ttask "upd" $ind $inf $typ $c1 $sel $isec $ipos $iN
      }
      incr ind
    }
  }
  after [expr $::em::inttimer * 1000] ::em::start_timed
  return $istarted
}
#=== time task
proc ::em::ttask {oper ind {inf 0} {typ 0} {c1 0} {sel 0} {tsec 0} {ipos 0} {iN 0}
{started 0}} {

  set task [list $inf $typ $c1 $sel]
  set it [list [expr [clock seconds] + abs(int($tsec))] $ipos $iN]
  switch -- $oper {
    "add" {
      set i [lsearch $::em::tasks $task]
      if {$i >= 0} {return [list $i 0]}  ;# already exists, no new adding
      lappend ::em::tasks $task
      lappend ::em::taski $it
      set started [start_timed [expr {[llength $::em::tasks] - 1}]]
    }
    "upd" {
      set ::em::tasks [lreplace $::em::tasks $ind $ind $task]
      set ::em::taski [lreplace $::em::taski $ind $ind $it]
    }
    "del" {
      set ::em::tasks [lreplace $::em::tasks $ind $ind]
      set ::em::taski [lreplace $::em::taski $ind $ind]
    }
  }
  return [list $ind $started]
}
#=== push/pop timed task
proc ::em::set_timed {from inf typ c1 inpsel} {
  set ::em::TN 1
  lassign [split $inf /] timer
  set timer [::apave::getN $timer]
  if {$timer == 0} {return 1}  ;# run once
  if {$timer>0} {set startnow 1} {set startnow 0}
  lassign [ttask "add" -1 $inf $typ $c1 $inpsel $timer] ind started
  if {$from eq "button" && $ind >= 0} {
    if {[em_question "Stop timed task" "Stop the task\n\n\
        [.em.fr.win.fr$::em::lasti.butt cget -text] ?"]} {
      ttask "del" $ind
    }
    return false
  }
  return [expr !$started && $startnow]  ;# true if start now, repeat after
}
#=== create file.mnu template
proc ::em::create_template {fname} {
  set res no
  if {[em_question "Menu isn't open" \
  "ERROR of opening\n$fname\n\nCreate it?"]} {
    if {[catch {set chan [open "$fname" "w"]} e]} {
      em_message "ERROR of creating\n\n$fname\n\n$e"
    } else {
      chan configure $chan -encoding utf-8
      set dir [file dirname $fname]
      if {[file tail $dir] == $::em::prjname} {
        set menu "$::em::prjname/nam3.mnu"
      } else {
        set menu [file join $dir "nam3.mnu"]
      }
      puts $chan "R: nam1 R: prog\n\nS: nam2 S: comm\n\nM: nam3 M: m=$menu"
      close $chan
      set res [::em::addon edit $fname]
      if {!$res} {file delete $fname}
    }
  }
  return $res
}
#=== process %IF wildcard
proc ::em::IF {sel {callcommName ""}} {
  set sel [string range $sel 4 end]
  set pthen [string first " %THEN " $sel]
  set pelse [string first " %ELSE " $sel]
  if {$pthen > 0} {
    if {$pelse < 0} {set pelse 1000000}
    set ifcond [string trim [string range $sel 0 $pthen-1]]
    if {[catch {set res [expr $ifcond]} e]} {
      em_message "ERROR: incorrect condition of IF:\n$ifcond\n\n($e)"
      return false
    }
    set thencomm [string trim [string range $sel $pthen+6 $pelse-1]]
    set comm     [string trim [string range $sel $pelse+6 end]]
    if {$res} {
      set comm $thencomm
    }
    set comm [string trim $comm]
    catch {set comm [subst -nobackslashes $comm]}
    set ::em::IF_exit [expr {$comm ne ""}]
    if {$callcommName ne ""} {
      upvar 2 $callcommName callcomm ;# to run in a caller
      set callcomm $comm
      return true
    }
    if {$::em::IF_exit} {
      switch -- [string range $comm 0 2] {
        "%I " {
          # ::Input variable can be used for the input
          # (others can be set beforehand by "%C set varname varvalue")
          if {![info exists ::Input]} {
            set ::Input ""
          }
          return [::em::addon input $comm]
        }
        "%C " {set comm [string range $comm 3 end]}
        default {
          if {[lindex [set _ [checkForWilds comm]] 0]} {
            return [lindex $_ 1]
          } elseif {[checkForShell comm]} {
            shell0 $comm &
          } else {
            set argm [lrange $comm 1 end]
            set comm1 [lindex $comm 0]
            if {$comm1 eq "%O"} {
              ::apave::openDoc $argm
            } else {
              if {[::iswindows]} {
                set comm "cmd.exe /c $comm"
              }
              if {[catch {exec {*}$comm &} e]} {
                em_message "ERROR: incorrect command of IF:\n$comm\n\n($e)"
              }
            }
          }
          return false ;# to run the command and exit
        }
      }
      catch {[{*}$comm]}
    }
  }
  return true
}

# *****************************   EOF   *****************************

#=== get an external CS to put into apave CSs (sort of tuning CS list)
#? proc ::em::testCS {} {
 #? ::apave::initWM; ::em::initall; set cc [::apave::paveObj csCurrent]; set ca [::apave::cs_Max]; if {[catch {::em::em_message "[::apave::paveObj csGetName $cc]: $cc of $ca:\n\n CS-$ca: [::apave::paveObj csGet $ca]\n\n[string map {{ } \n} $::em::argv]" ok "CS" -text 1 -w 99 -h 15} e]} {puts "ERROR: $e"}
#? }
