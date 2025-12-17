# Last changes:


Version `4.8.3 (17 Dec'25)`

  - BUGFIX: Escape key at editing menus
  - CHANGE: packages: apave 4.8.3, baltip 1.6.5


Version `4.7.3 (24 Sep'25)`

  - BUGFIX: Escape key at editing menus
  - CHANGE: packages: apave 4.7.3


Version `4.6.6 (15 Aug'25)`

  - CHANGE: menu.em & fossil.em to comply with apave 4.6.6 (focusing OK button)
  - CHANGE: packages: apave 4.6.6


Version `4.6.5 (2 Aug'25)`

  - BUGFIX: aftershocks of previous
  - CHANGE: packages: apave 4.6.4


Version `4.5.3 (19 Feb'25)`

  - NEW   : doctest: code may include #< comments to execute by doctest
  - CHANGE: packages: apave 4.5.3


Version `4.4.11 (6 Jan'25)`

  - BUGFIX: rare & weird bug of opening tcltk.em from alited's Preferences
  - CHANGE: tcltk.em ("rlwrap tclsh" added)
  - CHANGE: menu.em (.tk file extension recognized as Tcl's)
  - CHANGE: packages: apave 4.4.11


Version `4.4.10 (7 Sep'24)`

  - CHANGE: menu.em (running tcl files)
  - CHANGE: tiny clearance
  - CHANGE: packages: apave 4.4.10


Version `4.4.9 (7 Aug'24)`

  - BUGFIX: in em::callmenu, submenu's geometry for geo=1x2-3-4 (thanks to George)
  - CHANGE: tiny clearance
  - CHANGE: packages: apave 4.4.9


Version `4.4.6 (4 Jul'24)`

  - NEW   : em::checkXfce4 to correct terminal command for xfce4-terminal
  - NEW   : ee= command can include %s, %H wildcards
  - NEW   : #RUNF: / #EXEC: / #ARGS: comments can include %f, %d, %pd, %s, %H, %% wildcards
  - CHANGE: menu.em (.tcl .tm .test extensions to run tclsh)
  - CHANGE: packages: apave 4.4.6


Version `4.4.4 (24 Apr'24)`

  - BUGFIX: font size of editor text after changing it in "Project"
  - CHANGE: massive renaming & clearance
  - CHANGE: packages: apave 4.4.4


Version `4.4.3 (22 Apr'24)`

  - NEW   : if a dialogue set "topmost" manually, reopen it on executing its command
  - DELETE: HC= option
  - CHANGE: misc.em, tests.em
  - CHANGE: clearances
  - CHANGE: packages: apave 4.4.3


Version `4.3.5 (30 Dec'23)`

  - CHANGE: for Tcl 9.0: catch {glob ...} patterns changed, to insure against errors
  - CHANGE: fossil.em and fossil2.em exchanged items
  - CHANGE: packages: apave 4.3.5

Version `4.3.4 (20 Dec'23)`

  - NEW   : for ee= option: %% wildcard
  - CHANGE: packages: apave 4.3.4


Version `4.3.3 (13 Dec'23)`

  - BUGFIX: pass "-ontop 1" option to "Edit menu / Template"
  - CHANGE: packages: apave 4.3.3


Version `4.3.0 (30 Nov'23)`

  - NEW   : %H wildcard in .em files (home dir)
  - CHANGE: *.em files: %H instead of ~ and clearances
  - CHANGE: packages: apave 4.3.0


Version `4.1.6 (27 Sep'23)`

  - BUGFIX: (esp. for Windows) some issues with the grabbing windows
  - CHANGE: fossil2.em
  - CHANGE: packages: apave 4.1.6


Version `4.1.2 (30 Aug'23)`

  - BUGFIX: %b wildcard + quoted argument in %IF .. %THEN %b ..
  - CHANGE: menu.em
  - CHANGE: packages: apave 4.1.2


Version `4.0.6 (12 Apr'23)`

  - CHANGE: grep.em
  - CHANGE: packages: apave 4.0.6


Version `4.0.5 (31 Mar'23)`

  - BUGFIX: after running "ee=" command, do exit
  - CHANGE: packages: apave 4.0.5


Version `4.0.3 (22 Mar'23)`

  - CHANGE: menu.em, fossil.em
  - CHANGE: packages: apave 4.0.3


Version `4.0.1 (6 Mar'23)`

  - BUGFIX: in em::template::help, \\n were mapped to \n (+ "Find")
  - CHANGE: misc.em
  - CHANGE: packages: apave 4.0.1


Version `4.0.0 (1 Mar'23)`

  - NEW   : .em - new format of menus, more simple & viewable
  - NEW   : ornamental EXEC/SHELL allow to edit commands; no exit if "on top"
  - NEW   : mp=1 argument to enable the mouse pointer set on a last item (default 0)
  - NEW   : ms= argument to revive e_menu executables
  - NEW   : highlighting a current line at editing menus
  - NEW   : .em made Windows compatible
  - NEW   : %UF, %UD wildcards
  - DELETE: arguments: bd=, t4=..t9= (unusable)
  - DELETE: delegating wildcards
  - CHANGE: cancel repeating an old timer at starting the new one
  - CHANGE: s_menu.tcl to handle with ttk themes
  - CHANGE: em::prepr_win: skip \n and \t at mapping Windows' menu items
  - CHANGE: restarting Projects dialogue after editing the projects' file
  - CHANGE: item names with $::globalvar are updated after runs
  - CHANGE: tiny-up: fossil.em, fossil2.em, template.em
  - CHANGE: restored em::for_buttons
  - CHANGE: F1-F9 hot keys (an example in menu.em)
  - CHANGE: packages: apave 4.0.0


Version `3.7.0 (8 Feb'23)`

  - OLD   : v3.7.0 moved to a separate branch, for possible bugfixes only
  - NEW   : SH= option: geometry of a caller to center dialogues on it
  - NEW   : em::isbaltip to dismiss baltip etc. at SH= not {} ("shell actions")
  - NEW   : results > file: made by e_menu (in wish & tclkit.exe not working)
  - CHANGE: m=menu.mnu may be shortened to m=menu
  - CHANGE: menu.mnu, utils.mnu, fossil.mnu, git.mnu, misc.mnu
  - CHANGE: packages: apave 3.7.0


Version `3.6.6 (27 Jan'23)`

  - BUGFIX: find a project dir in "PD list" file, passed with PD= argument
  - CHANGE: packages: apave 3.6.6


Version `3.6.5 (25 Jan'23)`

  - NEW   : "SH=1" option to run writeable commands ("%#s") without dialogue
  - NEW   : writeable command: only saving after Ctrl+W / "Save & Exit" of popup menu
  - DELETE: "sh=" option and other shadowing stuff
  - DELETE: "for_buttons" proc
  - DELETE: "center_window" proc
  - CHANGE: "lappend $var" instead of "{*}$lappend"
  - CHANGE: corrected some "catch" and similar clearance
  - CHANGE: test1.mnu, fossil2.mnu
  - CHANGE: packages: apave 3.6.5


Version `3.6.4 (18 Jan'23)`

  - CHANGE: fossil.mnu (commit -m --branch), utils.mnu (clearance)
  - CHANGE: packages: apave 3.6.4


Version `3.6.3 (4 Jan'23)`

  - CHANGE: pointer set by event -warp
  - CHANGE: doctest_of_emenu.tcl: "package require Tk"


Version `3.6.2 (28 Dec'22)`

  - CHANGE: clearance: frame instead of ttk::frame & label, bg of checkbox
  - CHANGE: packages: apave 3.6.2


Version `3.6.0 (7 Dec'22)`

  - CHANGE: fossil.mnu: filtering files for timeline
  - CHANGE: test1.mnu: writeable cbx
  - CHANGE: menu.mnu: check for selection in "Run Tcl"
  - CHANGE: packages: apave 3.6.0


Version `3.5.7 (19 Oct'22)`

  - CHANGE: TF= option processed before m=, using in tests.mnu
  - CHANGE: -shiftX 8 option for baltip::tip
  - CHANGE: git.mnu: empty commit
  - CHANGE: packages: apave 3.5.7, baltip 1.5.1


Version `3.5.6 (5 Oct'22)`

  - CHANGE: em::Tclexe gets path to Tcl executable
  - CHANGE: tc= option: additional checks for full path to tclsh
  - CHANGE: wt= option: additional checks for cmd.exe & powershell.exe
  - CHANGE: packages: apave 3.5.6


Version `3.5.5 (14 Sep'22)`

  - CHANGE: continue code rearranging in alited's style
  - CHANGE: packages: apave 3.5.5, baltip 1.4.1


Version `3.5.4 (31 Aug'22)`

  - BUGFIX: "Projects" dialogue's font & window size
  - BUGFIX: resizing e_menu's window to min.width/height
  - NEW   : wt= option for Windows console
  - NEW   : em::menuOption to set/get options of menus (now, geometry of menu exited)
  - NEW   : warning at running EXEC/SHELL items
  - CHANGE: git2.mnu (edit ~/.gitconfig)
  - CHANGE: handling runs in Linux terminal
  - CHANGE: handling process ID
  - CHANGE: F4 hot key in menu.mnu
  - CHANGE: clearances, mostly of [expr ...]
  - CHANGE: "solo" in "About" dialogue, for solo mode
  - CHANGE: packages: apave 3.5.4, baltip 1.4.0


Version `3.4.16 (23 Jun'22)`

  - BUGFIX: menu.mnu corrected ("Run" in Windows)
  - BUGFIX: test1.mnu, tests.mnu to display a tail file name
  - NEW   : ee= option to run its value as a command in terminal
  - NEW   : forget installed in Tcl/Tk packages & namespaces used in e_menu
  - CHANGE: remove accompanying files of baltip package
  - CHANGE: edit button in Projects calls e_menu's editor
  - CHANGE: apave package


Version `3.4.12 (10 Jun'22)`

  - BUGFIX: running an external editor with arguments (exec -- {*}$::em::editor)
  - CHANGE: doctest_of_emenu.tcl (-DTs -s -DTv -v -DTb -b arguments)
  - CHANGE: header label: "Use space & arrow"
  - CHANGE: git.mnu, fossil.mnu (OK button focused), tests.mnu (DT* args)
  - CHANGE: ::em::edit uses e_menu's editor for .mnu
  - CHANGE: apave, baltip packages


Version `3.4.11 (20 May'22)`

  - BUGFIX: rest colors for themeWindow (in ::em::theming_pave)


Version `3.4.10 (14 May'22)`

  - NEW   : in ::em::shell0, run Tcl files by the Tcl executable (that runs e_menu)
  - CHANGE: apave, klnd packages


Version `3.4.8 (8 Mar'22)`

  - BUGFIX: b4= option (-padx of items)
  - BUGFIX: ::EMENUFILE to be initialized in "internal" e_menu.tcl
  - BUGFIX: unnecessary 'wm geometry..' => possible issue with some tclkits
  - NEW   : tc= option sets Tcl executable (for commands starting with tclsh/wish)
  - NEW   : #ARGS1:/#RUNF1:/#EXEC1:OFF disables runs by these
  - NEW   : matched quotes highlighted
  - CHANGE: running e_menu faster & tiny-ups
  - CHANGE: e_help.tcl: man pages checked for .html & .htm extensions
  - CHANGE: menu.mnu modified
  - CHANGE: apave, klnd packages


Version `3.4.7 (26 Jan'22)`

  - bugfix: checkForShell in shell0 (tclsh to tclkit)
  - bugfix: o=-1 instead of o=0
  - bugfix: skipped last line of .mnu
  - bugfix: ::em::font_f2 (-family) may be multi-word
  - SD= argument (path to src directory)
  - Tclexe to run Tcl executable at running tclsh & wish and at restarting
  - new option: NE=1 for dialogues (sets ::em::NE) to run dialogues repeatedly
  - changed option: o=-2 & o=-1 (no ornament & top line only)
  - EXEC (any command) joined to the RUNF, ARGS company
  - .mnu modified, fow Windows esp.
  - apave, baltip, klnd packages updated


Version `3.4.4 (25 Aug'21)`

  - new options: -ls, -pk, -DF, -BF, -PI
  - running e_menu (when sourced) to select an item
  - em::read_f_file and em::menuof modified
  - regexp for ARGS[0-9]= and RUNF[0-9]= corrected
  - checkbutton's color toggles together with "on top"
  - -ontop of dialogues added
  - menu variables' initialization changed (\n, \ substitutions etc.)
  - saving menu variables after question (%Q)
  - .mnu modified
  - apave package updated


Version `3.3.2b1 (27 Mar'21)`

  - atrace.tcl in.
  - trace/untrace items in test1.mnu
  - submenu's geometry equals to hidden parent's
  - o=-1 means "hint off"
  - checking by ::apave::endWM
  - apave, baltip packages upd.
  - BUGFIX: ::apave::cs_Max instead of ::apave::_CS_(MAXCS)

Version `3.2.8 (31 Jan'21)`

  - "ex=" argument to run a list of items and exit
  - modifying style of scale, scrollbar, combobox
  - modifying menu's font size
  - CS made milder
  - revising popup menus of text widget
  - color of matching bracket is magenta
  - modifying & moving highlight matches procs from ::em to ::apave
  - labelFlashing's -data allows var contents along with var name
  - fillGutter can be run to update a gutter, e.g. at switching CS
  - squeezing icons
  - ::apave::paveObj became ::apave::obj, using one apave object
  - playing with widths of cbx & opc in .mnu, successfully
  - updating hl_tcl package
  - BUGFIX: running a= commands


Version `3.2.7 (17 Jan'21)`

  - baltip package in.
  - apave package upd.
  - 'Project' dialog rearranged ('Ornament' etc.)
  - 'About' dialog got links
  - editor: color highlighting; new menu items; brackets matched at left
  - encoding utf-8 for all files, incl. doctested
  - invokeBrowser removed
  - openDoc to open documents
  - colors added for tips (fW bW)
  - check for qterminal in Linux
  - .mnu updated
  - BUGFIX: f1=, f2= options (font names)


Version `3.1 (12 Sep'20)`

  - apave 3.1
  - restarting on errors of %C
  - .mnu updated: fossil commit, save stuff


Version `3.0.2a1 (18 Jul'20)`

  - checking & showing errors at evaluating %C


Version `3.0.1 (17 Jul'20)`

  - esp. for TKE: any c= disabled at start, if color args set CS
  - border added to get menus separated for dk=dock/desktop
  - "main" proc changed to allow "testCS" to work properly
  - apave upd.
  - BUGFIX: highlighting substring between markers R:, S: etc.


Version `3.0 (4 Jul'20)`

  - trimmed e_menu/*.tcl for TKE
  - MW menu type behaves as M
  - "dk=" option
  - "ts=" mode amended
  - save_menuvars & focusback corrected
  - I: in marker list for editor
  - checkboxes of 'Project...'
  - %ms wildcard; execom; restart-app; PD.txt picker; s1.wav; ExpandOptions
  - editing PD.txt if 'Project...'
  - brackets checked on entering in menu editor


Version `2.1.0 (19 Jun'20)`

  - #RUNF1..99 added, to run any (e.g. main.tcl) as %RF wildcard
  - %P2 (project's nickname) be set in PD.txt file as 2nd item, after dir
  - 'sh=' option to allow shadowing menus, 0 by default
  - checking for equality braces before running input dialogs (%I)
  - 'ornamental' view corrected
  - readonly 'tex' widgets got '-takefocus 0' by default
  - fonts amended
  - calling 'xterm' amended (perhaps preferrable terminal, with tt=)
  - terminal isn't called when a command to exec is empty
  - git stuff in .mnu corrected
  - saving CS & geometry in "Project..."
  - removing "Set geometry" from popup menu
  - %IF sets flag of %THEN/%ELSE performed, to exit at RE/SE
  - logging messages to stdout at executing commands
  - <<Paste>> event removes selection in 'edit menu'
  - color scheming upd., TKE's CS incl.
  - BUGFIX: RE/SE/ME not working properly
  - BUGFIX: saving an option in [OPTIONS] failed if it was not there


Version `2.0.1 (31 May'20)`

  - b0=0 option set by default
  - color scheming upd., TKE's CS incl.
  - whole display made clearer, incl. popups
  - Menu button for popups, F2 for choosers
  - menus reread after commands (%U wildcard dropped)
  - selecting projects & CS from popup menu
  - change CS & geometry in popup menu "Project"
  - -msgLab option for widgets of input dialog
  - code rearranged (with e_addon.tcl)
  - apave & .mnu upd.


Version `1.55 (25 Apr'20)`

  - apave package v2.6.2
  - getN function upd. (min, max args)
  - help function upd. ("About")
  - clean-ups


Version `1.54 (23 Apr'20)`

  - apave package v2.6.1
  - icons added to popups & dialogs
  - fossil mnu corr.


Version `1.53 (20 Apr'20)`

  - apave package v2.5
  - bug fix: focusing items at hotkey pressing (pr_button)
  - fossil mnu corr.
  - clean-ups


Version `1.52 (15 Apr'20)`

  - apave package v2.4


Version `1.51 (21 Mar'20)`

  - bugfix: disabling "undo to blank" in editor
  - Ctrl+F acts as Ctrl+f in editor
  - upper letters as hotkeys (if possible)
  - CHANGELOG.md added


Version `1.50 (14 Mar'20)`

  - tt= argument, %TT wildcard introduced


Versions `1.45 through 1.49`

  - macros %MC entered
  - %U wildcard got an argument
  - #ARGS processing corrected
  - rt= argument (size ratio "min/init")
  - apave changed
  - .mnu changed


Version `1.44 (12 Jan'20)`

  - s="" hides HELP/EXEC/SHELL when g= specified
  - cleanup


Version `1.42 (26 Dec'19)`

  - bugfix for choosers (if no choice, fields were cleared)
  - -width/-w, -height/-h for editor may set low/high limits
  - parent/child relations corrected
  - .mnu changed: fonts/sizes, variables initialized, readonly checkboxes


Versions `1.35 through 1.41`

  - "on top" means also "don't close a menu at choosing an item"
  - %C Tcl command added to [OPTIONS]
  - fossil.mnu enhanced with dialogs and %C of [OPTIONS]
  - 'readonly' mode for text widget
  - '-state disabled' replaced by '-ro 1' for .mnu's texts
  - dangerous commands of .mnu are colored by TKE marker's color
  - 'ftx' file content widget
  - theme colors fixed, incl. ones passed by TKE
  - pavecli.tcl for shell scripts
  - doctest-for-emenu updated, mostly for "doctest source"
  - package require pave


Version `1.34 (2 Nov'19)`

  - date/time attributes of menus untouched at executing their commands
  - removing temporary files (menus/*.tmp~) on exit
  - .mnu changed accordingly
  - main.mnu: file differences for Fossil (default) / Git
  - grep.mnu: input dialogs for a search string
  - help updated at aplsimple.github.io


Version `1.33 (31 Oct'19)`

  - pave: file content widgets (fco, flb) added
  - fossil.mnu, git.mnu changed accordingly
  - TKE colors reset for e_menu


Versions `1.30 through 1.32`

  - no moving menu at clicking "On top"
  - when "On top"=on, no exit after RE: and SE: commands
  - delegating "On top"=on to child menus
  - yesnocancel dialog added to existing yesno, okcancel
  - only files less than 1Mb are read (outside of TKE, in file managers)
  - Tcl/Tk offline help file names normalized
  - new %F_ wildcard meaning %F underlined
  - ";" can be used as a command divider in a1=, a2= commands
  - pave modified


Version `1.29 (3 Sep'19)`

  - ::em::prjname
  - help: bitbucket.org -> github.com
  - fossil menus revised and rewritten
  - git menus changed


Version `1.28 (23 Aug'19)`

  - exec -ignorestderr when running Linux terminal
  - "# ARGS1.." works as "#ARGS1.." for in-text arguments
  - possible issue with 'workdir' fixed
  - in pave, in editor, Alt+Up/Down to move lines up/down
  - in pave, undo is enabled by default for text widget
  - few .mnu changed


Version `1.27 (3 Aug'19)`

  - ln=, cn= arguments, to read a word under caret if no selection
  - yn= argument, to confirm exit at Escape pressing
  - in=1.0 in [OPTIONS] section, to save & restore last run position
  - in=1.0 included in .mnu files


Version `1.26 (25 Jul'19)`

  - e_menu.tcl: catched {cd $cpwd} - as the directory may be deleted by commands
  - paveme.tcl: set attrs..-nocomm - as more secure
  - hg.mnu shorted & hg2.mnu expanded with 'hg forget/remove/add'


Version `1.25 (14 Jul'19)`

  - bugfixing: add [OPTIONS] if absent in edited menu
  - 'cd %d' before 'Edit/create selection' & 'Open in browser' in menu.mnu


Version `1.24 (12 Jul'19)`

  - TF= argument, %TF wildcard
  - saving/restoring the variables in [OPTIONS]
  - saving/restoring the cursor's position at editing a menu
  - Ctrl+Y to delete a line at editing
  - Ctrl+D to double a line at editing
  - popup menu at editing
  - hg2.mnu: 'Push with BIN'
  - help updated amd moved to aplsimple.bitbucket.io
  - clearance a bit

Version `1.23 (23 Jun'19)`

  - ss= argument, %ss wildcard
  - option "Do save the edited file" in Preferences/Plugins/e_menu


Version `1.22 (9 Jun'19)`

  - %AR, %L wildcards
  - "ts=", "l=" arguments ("z8=" stuff removed due to %AR)
  - "==" instead of ">>" for input dialogs
  - "-disabledtext" option for input dialogs
  - setting a revision number in "Differences" item of menu.mnu
  - "hg help" in hg.mnu


Version `1.21 (4 Jun'19)`

  - E_MENU_OPTIONS environment variable for options outside the plugin
  - co= option (additional line continuator)
  - tailing spaces trimmed by editor
  - [MENU] section of menu file
  - %b and %B made equal in %IF
  - clearance a bit


Version `1.20 (2 Jun'19)`

  - input dialog (%I wildcard) enhanced
  - line continuation for long items
  - test1.mnu for demo of these
  - help rebuild


Version `1.19 (31 May'19)`

  - help rewritten totally; e_menu's code changed accordingly


Version `1.18 (25 May'19)`

  - bug fixing for double 'exec' in S proc
  - bug fixing for 'pa=' argument - needs to be 0 at calling submenu
  - bug fixing for [string length $] - fired always, not critical
  - %x wildcard (a file extension from %f)
  - changed menu.mnu, hg.mnu, side.mnu, utils.mnu; removed python.mnu
  - starting modifications of help (mainly about 'project dependence')


Version `1.17 (26 Apr'19)`

  - bug fixing for "silent" parameter of shell0 proc:
  - %IF %THEN %ELSE wildcards can include %Q, %D, %T, %I, %C
  - #ARGS10: .. ARGS99: .. arguments for "Run me" are allowed
  - lxterminal replaced xterm in menu.mnu


Version `1.16 (31 Mar'19)`

  - pave code changed:
    - dialog's width calculated neatlier
    - "-ontop" option for dialogs (incl. e_menu's D, Q)
    - \\n to \n converting in "message" (for using dialogs in .mnu)
    - combobox coloring continued
  - some .mnu changed


Version `1.15 (16 Mar'19)`

  - theming in accordance with TKE current theme
  - %D message in %IF clause
  - diff a current tab against left/right tab (utils.mnu)


Version `1.14 (2 Mar'19)`

  - e_menu.tcl changed as for submenu arrow icon:
    - nicely visible
    - Windows issues resolved
  - paveme.tcl changed (menubar added)
  - git2.mnu, side.mnu changed (appearance)


Version `1.13 (9 Feb'19)`

  - pave*.tcl changed (focused, themed)
  - utils.mnu: wget (edited item)
  - %T, %S, %z5 wildcards


Version `1.12 (31 Jan'19)`

  - PaveDialog input: entering data used in commands
  - hg.mnu: input dialogs added
  - %F wildcard added: 'assumed filename' ="%f" if "%f" exists, otherwise ="*"
  - bug fix: workdir taken from %f


Version `1.11 (15 Jan'19)`

  - y[0-9]= arguments as module args from #ARGS[0-9] placeholders
  - s3= argument equal to the first of y[0-9]= or s=


Version `1.10 (11 Jan'19)`

  - fixed after-shocks of pavedialogs
  - corrected the window centering (paveme.tcl)


Version `1.9 (11 Jan'19)`

  - EOL of editable items chanded to |!| instead of \\n (that are for commands)


Version `1.8 (29 Dec'18)`

  - bug fixed as for getting file name to edit (with %E wildcard)
  - command edited 'on fly' (e.g. as in grep.mnu's GREP TEMPLATE)
  - Ctrl+W hotkey for e_menu's editor
  - TKE editor's colors for e_menu's editor
  - icon removed from e_menu's editor
  - menu.mnu, grep.mnu, hg.mnu updated


Version `1.7 (24 Dec'18)`

  - TKE *default_foreground, default_background* used for e_menu main colors
  - e_menu's internal editor called to edit the .mnu
  - menu.mnu, hg.mnu updated


Version `1.6 (20 Dec'18)`

  - %B / %T wildcards are cancelled as browser / terminal
  - %D wildcard (message) is run without catching errors
  - new %C / %T wildcards to run Tcl code with catched / non-catched errors
  - hg.mnu updated (rollback, merge -P)
  - new grep.mnu to search for a selected text in a current directory


Version `1.5 (17 Dec'18)`

  - Windows issue fixed: multiline command batch formed 'on fly'


Version `1.4 (16 Dec'18)`

  - *sel_tcl.tmp* instead of *tmp_sel.tcl* as a temporary file name (for SCM ignoring).
  - %PD wildcard may be extended to contain a list of project directories.
  - %P wildcard allows to prepare a command by Tcl substitutions and replacing \n.
  - menu.mnu changed, fossil.mnu changed, git.mnu changed, new hg.mnu
  - e_menu.tcl is reformatted as for using em:: namespace.
