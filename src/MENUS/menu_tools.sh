function menu_tools {

while true ; do
set_terminal
echo -e "
########################################################################################
 
                      $cyan          P A R M A N O D E - Tools   $orange

                    
                 (u)     Update computer (Linux or Mac)

                 (ip)    What's my computer's IP address?

                 (d)     Delete your previous preference to hide certain Parmanode
                            messages

                 (h)     Check system resources with \"htop\" (installs if needed)

                 (a)     Bring in a Parmanode drive from another installation, or
                         add a new external drive to Parmanode

                 (ub)    Convert an Umbrel external drive to Parmanode, without 
                         losing Bitcoin data. 
                 
                 (ru)    Reverse an Umbrel conversion to Parmanode (ie back to Umbrel)
                

                 ... More soon

########################################################################################
"
choose "xpq" ; read choice ; set_terminal

case $choice in

    u|U|up|UP|update|UPDATE|Update)
    if [[ $OS == "Linux" ]] ; then sudo apt-get update -y && sudo apt-get upgrade -y ; fi
    if [[ $OS == "Mac" ]] ; then set_terminal ; please_wait ; brew update && brew upgrade ; fi
    ;;

    ip|IP|iP|Ip)
        IP_address
        return 0
        ;;
    d|D)
        rm $HOME/.parmanode/hide_messages.conf
        echo "Choices reset" ; sleep 0.6 
        ;;

    p|P)
        return 0
        ;;

    h|H|htop|HTOP|Htop)

        announce "To exit htop, hit$cyan q$orange"

        if [[ $OS == "Mac" ]] ; then htop ; break ; return 0 ; fi

        if ! which htop ; then sudo apt-get install htop -y >/dev/null 2>&1 ; fi

        htop

        ;;

    a|A|add|ADD|Add)
        add_drive 
        ;;
    
    ub|UB|Ub)
        umbrel_import 
        ;;
    ru|RU|Ru)
        umbrel_import_reverse
        ;;


    q|Q|Quit|QUIT)
        exit 0
        ;;
    "")
        return 0 
        ;;

    *)
        invalid 
        ;;
    esac
done
return 0
}
