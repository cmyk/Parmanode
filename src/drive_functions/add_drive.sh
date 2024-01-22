function add_drive {

info_add_drive $@ || return 1 # safe unmount executed

set_terminal ; echo -e "$pink
########################################################################################
    Please make sure the$green drive you want to bring in$pink is PHYSICALLY DISCONNECTED, 
    i.e. detach the cable, before proceeding or you could get errors. 
########################################################################################
$orange" ; enter_continue

safe_unmount_parmanode || return 1

if [[ ! $wasntmounted == true ]] ; then
set_terminal ; echo -e "$cyan
########################################################################################
   Parmanode has safely unmounted your$green regular$cyan Parmanode drive by stopping 
   the programs using it, then unmounting. PLEASE PHYSICALLY DISCONNECT THE DRIVE 
   NOW, ie detach the cable.
########################################################################################
" ; enter_continue ; set_terminal
fi

detect_drive $@ "brief" || return 1 #menu

if [[ $OS == "Mac" ]] ; then
    set_terminal
    echo "
########################################################################################

    The drive should be ready. If it is not mounted, disconnect and reconnect.

########################################################################################
"
enter_continue ; return 0 ;
fi

if [[ $OS == "Linux" ]] ; then

    if [[ ! -d /media/$USER/parmanode ]] ; then sudo mkdir -p /media/$USER/parmanode ; fi
    
    write_to_fstab2

sudo umount /media/$USER/parmanod* 
sudo mount -a

cd /media/$USER/parmanode/
sudo mkdir .bitcoin fulcrum_db electrs_db >/dev/null 2>&1
sudo chown $USER:$(id -gn) /media/$USER/parmanode # no -R in case it's another Node package drive that has been imported.
debug "chown parmanode drive"
sudo chown -R $USER:$(id -gn) .bitcoin fulcrum_db electrs_db
if [[ -L /media/$USER/parmanode/.bitcoin ]] ; then
    if ! which readlink >/dev/null ; then sudo apt update -y && sudo apt install coreutils ; fi
    sudo chown -R $USER:$(id -gn) $(readlink /media/$USER/parmanode/.bitcoin)
fi
debug "chown parmanode directories"

set_terminal ; echo "
########################################################################################

    If you saw no errors, your drive should now be mounted.

########################################################################################
"
enter_continue
return 0
fi #end if Linux
}

