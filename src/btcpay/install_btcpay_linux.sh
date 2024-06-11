function install_btcpay_linux {

if [[ $debug != 1 ]] ; then
grep -q bitcoin-end < $HOME/.parmanode/installed.conf || { announce "Please install Bitcoin first. Aborting." && return 1 ; }
fi

grep -q docker-end < $HOME/.parmanode/installed.conf || { announce "Must install Docker first.
" \
"Use menu: Add --> Other --> Docker). Aborting." && return 1 ; }

sned_sats

btcpay_install_preamble || return 1

choose_btcpay_version || return 1

if [[ $debug != 1 ]] ; then
set_terminal
while true ; do user_pass_check_exists 
    return_status=$?
    if [ $return_status == 1 ] ; then return 1 ; fi
    if [ $return_status == 2 ] ; then set_rpc_authentication ; break ; fi
    if [ $return_status == 0 ] ; then break ; fi 
    done
fi

install_tor

make_btcpay_directories || return 1 ; log "btcpay" "entering make_btcpay_directories..."

btcpay_config || return 1 ; log "btcpay" "entering btcpay_config..."


nbxplorer_config || return 1 ; log "btcpay" "entering nbxplorer_config..."

build_btcpay || return 1 ; log "btcpay" "entering build_btcpay..."
pause "check build went ok"

run_btcpay_docker || return 1 ; log "btcpay" "entering run_btcpay_docker..."

log "btcpay" "entering start_postgress..."
startup_postgres "install" || return 1 
log "btcpay" "exited start_progress"

sleep 4
run_nbxplorer || return 1 ; log "btcpay" "entering run_nbxplorer.."

sleep 4
run_btcpay || return 1 ; log "btcpay" "entering run_btcpay..."

if which tor >/dev/null 2>&1 ; then enable_tor_btcpay ; fi

installed_config_add "btcpay-end"

mkdir $HOME/parmanode/startup_scripts/ >/dev/null 2>&1
make_btcpay_startup_script
success "BTCPay Server" "being installed."
log "btcpay" "Btcpay install success"
return 0
}