function make_bitcoin_conf {
#Parmanode default config settings. Can be changed.
#Create a bitcoin.conf file in data directory.
#Overrides any existing file named bitcoin.conf
set_terminal

file="$HOME/.bitcoin/bitcoin.conf"
loop=do

if [[ -n $1 && $1 == umbrel ]] ; then export prune=0 ; loop=break ; file="$mount_point/.bitcoin/bitcoin.conf" ; fi

if [[ -f $HOME/.bitcoin/bitcoin.conf ]] # if a bitcoin.conf file exists
	then 

        while true ; do
        if [[ $installer == parmanodl || $loop=break ]] ; then export prune=0 ; break ; fi #overwrites any existing conf file 
	    set_terminal ; echo "
########################################################################################

    A bitcoin.conf file already exists. You can keep the one you have, but be
    aware if this file was not originally birthed by Parmanode, it may cause conflicts
    if there are unexpected settings. Your prune choice will still be added to it.

    It's safest to discard the old copy, but the choice is yours.

                           o)           overwrite

                           yolo)        keep the one you have

                           a)           abort installation

########################################################################################
"
choose "xpq" ; read choice

case $choice in 
    q|Q|QUIT|Quit|quit) exit 0 ;; 
    p|P) return 1 ;; 
    o|O) log "bitcoin" "conf overwrite" && break ;;
    yolo|YOLO|Yolo) apply_prune_bitcoin_conf ; return 0 ;; 
    *) invalid ;; 
esac 
done
fi

echo "server=1
txindex=1
blockfilterindex=1
daemon=1
rpcport=8332

zmqpubrawblock=tcp://127.0.0.1:28332
zmqpubrawtx=tcp://127.0.0.1:28333

whitelist=127.0.0.1
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
rpcallowip=10.0.0.0/8
rpcallowip=192.168.0.0/16
rpcallowip=172.17.0.0/16" | sudo tee "$file" > /dev/null && log "bitcoin" "bitcoin conf made"  

apply_prune_bitcoin_conf # Here is where the prune choice is added to bitcoin.conf
}
