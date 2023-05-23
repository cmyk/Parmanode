function install_mempool {

if [[ $1 != "resume" ]] ; then
{
if [[ $(uname -m) == "aarch64" || $(uname -m) == "armv71" ]] then 
    pi4_warning
    if [ $? == 1 ] ; then return 1 ; fi
fi

set_terminal
install_check "mempool" || return 1

source $HOME/.bitcoin/bitcoin.conf

if [[ -z $rpcuser ]] ; then
    while true ; do
    set_terminal
    echo "A Bitcoind username and password needs to be set for Mempool Space"
    echo "to work. Set it now? (y) (n)"
    read choice
    case $choice in q|Q|Quit|QUIT|quit) exit 0 ;; p|P) return 1 ;;
    n|N) echo "OK then, aborting installation." ; sleep 2 ; return 1 ;;
    y|Y|"") set_rpc_authentication && break ;;
    *) invalid ;;
    esac ; done ; fi


cd $HOME/parmanode
git_check #installs if not istalled
git clone http://github.com/mempool/mempool.git
cd mempool/docker

if ! which docker ; then
    if [[ $OS == "Linux" ]] ; then install_docker_linux "mempool" ; fi
    if [[ $OS == "Mac" ]] ; then download_docker_mac ; fi
fi

}
else
installed_config_remove "mempool-half"
set_terminal ; echo "Resuming Mempool install" ; enter_continue
fi

make_docker_compose

installed_conf_add "mempool-end"

cd $HOME/parmanode/mempool/docker && docker compose up -d

set_terminal ; echo "
########################################################################################

                                   S U C C E S S ! 

    Mempool Space has finished being installed. It may take a few days for the backend
    to synchronise. You can access the webpage at $IP:4080

    You can take a look before the synchronisation is finished; more info will appear
    once it's done.

########################################################################################
"
enter_continue
return 0
}

