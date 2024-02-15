function menu_main {
set_terminal
while true ; do
#if [[ ! $announcements == off ]] ; then export blinkon="\033[5m" ; else unset blinkon ; fi 

#export blinkon="\033[5m"
#export blinkoff="\033[0m"
set_terminal_custom 51
source $original_dir/version.conf >/dev/null
source $hm >/dev/null 2>&1 #hide messages
if [[ $vPatch -gt 9 ]] ; then space="" ; else space=" " ; fi #in case version number is high, adjust menu border

# if statements in the menu printout makes the menu dynamic, ie changes according to the
# tests performed. Variables are set to assist logic in the menu choice execution part
# of the code at the bottom.
echo -e "$orange
########################################################################################
#                                                                                      #
#    P A R M A N O D E --> ${cyan}Main Menu$orange                                                   #
#                                                                                      #
#    Version:$bright_blue $version                                                               $orange  $space#
#                                                                                      #
########################################################################################
#                                                                                      #
#    (o)                  Overview/Status of Programs                                  #
#                                                                                      #
#    (add)                Add more Programs                                            #
#                                                                                      #
#    (u)                  Use Programs                                                 #
#                                                                                      #
#    (remove)             Remove/Uninstall Programs                                    #
#                                                                                      #
#--------------------------------------------------------------------------------------#
#                                                                                      #
#    (t)                  Tools                                                        #
#                                                                                      #
#    (s)                  Settings  (change colour theme)                              #
#                                                                                      #
#    (mm)                 Bitcoin Mentorship Info  .... (Study with Parman)            #
#                                                                                      #
#    (e)                  Education (Lotsa stuff)                                      #
#                                                                                      #
#    (d)                  Donate ;)                                                    #
#                                                                                      #
#    (l)                  See logs and config files                                    #
#                                                                                      #
#    (update)             Update Parmanode  ........... (Improvements always coming)   #
#                                                                                      #
#    (uninstall)          Uninstall Parmanode  ........ (Who'd do such a thing?)       #
#                                                                                      #
#    (aa)                 Hide/Show Main Menu announcements ... (Donchu dare!)         #
#                                                                                      #
#    (ap)                 About Parmanode                                              #
#                                                                                      #
########################################################################################

 Type your$green choice$orange without the brackets, and hit$green <enter>$orange 
 Or to quit, either hit$green <control>-c$orange, or type$green q$orange then$green <enter>$orange.
"
if [[ ! $announcements == off ]] ; then
echo -e "
$pink Tip: combine u with the next menu options. eg, try ub for bitcoin menu     $orange 
$bright_blue NEW: ColdCard Firmware install Wizard. See Tools menu. $orange
$blinkon$red WARNING!! YOU DON'T HAVE ENOUGH BITCOIN $orange$blinkoff"
fi

read choice #whatever the user chooses, it gets put into the choice variable used below.
set_terminal

case $choice in #the variable choice is tested through each of the case-choices below.
# these end in a closing bracket, have some code, and end with a ;;
# once there is a match, the case block is exited (after the esac point below). Then
# it repeats because case is inside a while loop.
aa)
if [[ $announcements == off ]] ; then
delete_line "$hm" "announcements="
echo "announcements=on" | tee -a $hm 
else
delete_line "$hm" "announcements="
echo "announcements=off" | tee -a $hm
fi
;;
o|O)
menu_overview 
;;

a|add|Add|ADD)
    menu_add_new
    ;;
use|USE|Use|u|U)
    menu_use
    ;;
remove|REMOVE)
    menu_remove ;;
l|L) 
    menu_log_config ;;
mm|MM)
     mentorship
     ;;

e|E)
    menu_education ;;
t|T)
    menu_tools ;;
s|S)
    menu_settings ;;
d|D)
    donations ;;
un|uninstall|UNINSTALL)
uninstall_parmanode
;;
up|update|UPDATE|Update)
    update_parmanode || continue
    if [[ $main_loop != 0 ]] ; then
    set_terminal ; 
    announce "You need to exit and reload Parmanode to use the new version of Parmanode."
    continue
    fi

    if [[ $exit_loop == false ]] ; then return 0 ;fi
;;
ap|AP|Ap|aP)
    about ;;

addn) menu_add_node ;;
addw) menu_add_wallets ;;
addo) menu_add_other ;;


uany) menu_use any ;; 
ub) menu_use b ;; 
ubb) menu_use bb ;;
ubre) menu_use bre ;; 
ubtcp) menu_use btcp ;;
ue) menu_use e ;;
uers) menu_use ers ;;
uf) menu_use f ;;
ul) menu_use l ;; 
ulnb) menu_use lnb ;;
ut) menu_use t ;;
us) menu_use s ;;
ur) menu_use r ;;
uts) menu_use ts ;;
ubtcpt) menu_use btcpt ;; 
us) menu_use s ;;
utrz) menu_use trz ;;
ull) menu_use ll ;;
ups) menu_use ps ;;
upbx) menu_use pbx ;;
upih) menu_use pih ;;
uqbit) menu_use qbit ;;
umem) menu_use mem ;;
uersd) menu_use ersd ;;
upool) menu_use pool ;;


"rf-npm"|"rf-nodejs"|"rf-get_nodejs_and_npm")
debug "before nodejs"
get_nodejs_and_npm 20 x
sudo npm install -g npm
;;



ul|UL|Ul)
clear ; please_wait
menu_lnd
;;

debugon) 
export debug=1 ;;
debugoff) 
export debug=0 ;;

q | Q | quit)
    exit 0 ;;
*)
    invalid ; clear ;;

esac ; done ; return 0
}
