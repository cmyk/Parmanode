function remove_bitcoin_directories_mac {

source $HOME/.parmanode/parmanode.conf

#Remove Parmanode/bitcoin directory (installation files)
sudo rm -rf $HOME/parmanode/bitcoin >/dev/null 2>&1 \ 
    || log "bitcoin" "failed to remove /parmanode/bitcoin dir"

#check if data directory on external drive or internal drive
source $HOME/.parmanode/parmanode.conf   # gets drive choice

#check external drive first - mounted and unmounted conditions.

if [[ $drive == "external" && -d /Volumes/parmanode/.bitcoin ]] ; then #drive would have to be mounted to be true 
while true ; do
set_terminal
echo "
########################################################################################

    It appears there is a Bitcoin data directory on the external drive. Would like 
    to delete that data or leave it be (i.e. skip)?

                            d)          delete

                            s)          skip

########################################################################################
"
choose "xq" ; read choice 
if [[ $choice == "q" ]] ; then exit 0 ; fi
if [[ $choice == "s" ]] ; then log "bitcoin" "skip; not deleting .bitcoin on drive" ; break ; fi
if [[ $choice == "d" ]] ; then log "bitcoin" "deleting .bitcoin on drive" 
    cd ; rm -rf /Volumes/parmanode/.bitcoin >/dev/null 2>&1 \
    || { log "bitcoin" "error deleting .bitcoin dir"
    debug "Error deleting .bitcoin directory. Continuing." ; } ;  break ; fi 
    
log "bitcoin" "if statements all skipped in rem_bit_dir function. unexpected. " && \
invalid #if all above if statements not true, then invalid choice and loop.
done
fi #end checking external drive for data directory

#check internal drive for data directory existance 
if [[ -d $HOME/.bitcoin && ! -L $HOME/.bitcoin ]] ; then    #checks for directory, and not a symlink
while true ; do
set_terminal ; echo "
########################################################################################

    It appears there is a Bitcoin data directory on the internal drive at:
    
                            $HOME/.bitcoin

    Would like to delete that data or leave it be (skip) ?

                            d)          delete

                            s)          skip     

    If skipping, and you have chosen an external drive, it will be renamed to 
    .bitcoin_backup0 in order to created a symlink to the external drive of the 
    same name.               

########################################################################################
"
choose "xq" ; read choice 
if [[ $choice == "q" ]] ; then exit 0 ; fi
if [[ $choice == "s" ]] ; then 
            if [[ $drive == "external" ]] ; then 
            log "bitcoin" "user chose to skip deleting internal .bitcoin drive. make backup executing." && \
            make_backup_dot_bitcoin ; fi
            break ; fi
if [[ $choice == "d" ]] ; then 
    log "bitcoin" "user chose to delete internal .bitcoin dir"
    cd && rm -rf $HOME/.bitcoin >/dev/null 2>&1 \
    || { log "bitcoin" "error deleting .bitcoin on internal drive." && \
    debug "Error deleting .bitcoin directory. Continuing." ; } ; break ; fi 
    
invalid #if all above if statements not true, then invalid choice and loop.
done
fi #end checking internal drive for .bitcoin directory

#Check for Bitcoin data directory in default Mac location
if [[ -d $HOME/Library/"Application Support"/Bitcoin/ ]] ; then 

while true ; do
    set_terminal ; echo "
########################################################################################
    
    By the way, even though your Parmanode settings indicate you're wishing to use 
    an external drive for the Bitcoin data directory, an internal drive directory
    containing a Bitcoin data directory has been found in :

            $HOME/Library/Application Support/Bitcoin
    
   This must be removed or renamed for Parmanode to continue with your selected 
   settings.

                                 r) Rename

                                 d) Delete

########################################################################################
"
choose "xq" ; read choice
    case $choice in
        r|R) set_terminal ; log "bitcoin" "make bakcup internal .bitcoin" && make_backup_Bitcoin_mac ; break ;;
        d|D) log "bitcoin" "deleting Application Support/Bitcoin" && \
             rm -rf $HOME/Library/Application\ Support/Bitcoin ; break ;;
        q|Q) exit 0 ;;
        *)   invalid ;;
        esac
    done

fi #end checking internal drive for data directory at defaul mac location

#Remove symlink to drive
if [[ -L "$HOME/.bitcoin" ]] 2>/dev/null ; then 
    rm $HOME/.bitcoin && \
    log "bicoin" "symlink .bitcoin deleted"
    fi      

#Remove symlink from default Bitcoin directory to $HOME/.bitcoin
if [[ -L $HOME/Library/"Application Support"/Bitcoin ]] ; then
    log "bitcoin" "Application Support/Bitcoin symlink deleted" && \
    rm $HOME/Library/"Application Support"/Bitcoin ; fi 

return 0
}