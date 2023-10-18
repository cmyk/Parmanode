function bre_docker_modify_env {
local file="$HOME/parmanode/bre/.env"

#computer speed question
if [[ $fast_computer == no ]] ; then
swap_string "$file" "BTCEXP_SLOW_DEVICE_MODE=false" "BTCEXP_SLOW_DEVICE_MODE=true"
fi #else leave that configuration alone

#Sort out connection security method
unset rpcuser rpcpassword
source $HOME/.bitcoin/bitcoin.conf >/dev/null 2>&1
source $HOME/.parmanode/parmanode.conf >/dev/null 2>&1
if [[ -z rpcuser || -z rpcpassword ]] ; then  
delete_line "$file" "BITCOIND_USER" 
delete_line "$file" "BTCEXP_BITCOIND_PASS"
echo "BTCEXP_BITCOIND_COOKIE=$HOME/.bitcoin/.cookie" | tee -a $file >/dev/null 2>&1
else
sed s!parman!$rpcuser!     $file > $file-2 && mv $file-2 $file
sed s!hodl!$rpcpassword!   $file > $file-2 && mv $file-2 $file
fi
}