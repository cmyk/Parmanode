function menu_add_source {

#BITCOIN
unset bitcoin_i bitcoin_p bitcoin_n
if grep -q "bitcoin-end" < $HOME/.parmanode/installed.conf ; then 
   #installed
bitcoin_i="#                                      Bitcoin Core                                    #"

elif grep -q "bitcoin-start" < $HOME/.parmanode/installed.conf ; then 
   #partially installed
bitcoin_p="#                                      Bitcoin Core                                    #"
else 
   #not installed
bitcoin_n="#                            (b)           Bitcoin Core                                #"
fi

#DOCKER
unset docker_i docker_p docker_n
if grep -q "docker-end" < $HOME/.parmanode/installed.conf ; then 
   #installed
docker_i="#                                      Docker                                          #"
elif grep -q "docker-start" < $HOME/.parmanode/installed.conf ; then
   #partially installed
docker_p="#                                      Docker                                          #"
else
   #not installed
docker_n="#                            (d)           Docker                                      #"
fi

#FULCRUM
unset fulcrum_i fulcrum_p fulcrum_n
if  grep -q "fulcrum-end" < $HOME/.parmanode/installed.conf ; then 
   #installed
fulcrum_i="#                                      Fulcrum                                         #"
elif grep -q "fulcrum-start" < $HOME/.parmanode/installed.conf ; then 
   #partially installed
fulcrum_p="#                                      Fulcrum                                         #"
else
   #not installed
fulcrum_n="#                            (f)           Fulcrum (an Electrum Server)                #"
fi

#BTCPAY
unset btcpay_i btcpay_p btcpay_n
if grep -q "btcpay-end" < $HOME/.parmanode/installed.conf ; then 
   #installed
btcpay_i="#                                      BTCPay Server                                   #"
elif grep -q "btcpay-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
btcpay_p="#                                      BTCPay Server                                   #"
else
   #not installed
btcpay_n="#                            (btcp)        BTCPay Server                               #"
fi

#Sparrow
unset sparrow_i sparrow_p sparrow_n
if grep -q "sparrow-end" < $HOME/.parmanode/installed.conf ; then  
   #installed
sparrow_i="#                                      Sparrow Wallet                                  #"
elif grep -q "sparrow-start" < $HOME/.parmanode/installed.conf ; then 
   #partially installed
sparrow_p="#                                      Sparrow Wallet                                  #"
else
   #not installed
sparrow_n="#                            (s)           Sparrow Wallet                              #"
fi

#Electrs
unset electrs_i electrs_p electrs_n
if grep -q "electrs-end" < $HOME/.parmanode/installed.conf ; then 
   #installed
electrs_i="#                                      electrs                                         #"
elif grep -q "electrs-start" < $HOME/.parmanode/installed.conf ; then
   #partially installed
electrs_p="#                                      electrs                                         #"
else
   #not installed
electrs_n="#                            (ers)         electrs                                     #"
fi

#LND
unset lnd_i lnd_p lnd_n
if grep -q "lnd-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
lnd_i="#                                      LND                                             #"
elif grep -q "lnd-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
lnd_p="#                                      LND                                             #"
else
   #not installed
lnd_n="#                            (lnd)         LND                                         #"
fi

#RTL
unset rtl_i rtl_p rtl_n
if grep -q "rtl-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
rtl_i="#                                      RTL Wallet                                      #"
elif grep -q "rtl-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
rtl_p="#                                      RTL Wallet                                      #"
else
   #not installed
rtl_n="#                            (r)           RTL Wallet                                  #"
fi

#Electrum
unset electrum_p electrum_n electrum_i
if grep -q "electrum-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
electrum_i="#                                      Electrum                                        #"
elif grep -q "electrum-start" $HOME/.parmanode/installed.conf ; then 
  #partially installed
electrum_p="#                                      Electrum                                        #"
else
 #not installed 
electrum_n="#                            (e)           Electrum                                    #"
fi


#Tor
unset tor_i tor_p tor_n
if grep -q "tor-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
tor_i="#                                      Tor                                             #"
elif grep -q "tor-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
tor_p="#                                      Tor                                             #"
else
   #not installed
tor_n="#                            (t)           Tor                                         #"
fi

#Specter
unset specter_i specter_p specter_n
if grep -q "specter-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
specter_i="#                                      Specter Wallet                                  #"
elif grep -q "specter-start" < $HOME/.parmanode/installed.conf ; then 
   #partially installed
specter_p="#                                      Specter Wallet                                  #"
else
   #not installed
specter_n="#                            (specter)     Specter Wallet                              #"
fi

#Tor Server
unset torserver_i torserver_p torserver_n
if grep -q "tor-server-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
torserver_i="#                                      Tor Server                                      #"
elif grep -q "tor-server-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
torserver_p="#                                      Tor Server                                      #"
else
   #not installed
torserver_n="#                            (ts)          Tor Server (Darknet Server)                 #"
fi

#BTCPay Tor
unset btcpTOR_i btcpTOR_p btcpTOR_n
if grep -q "btcpTOR-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
btcpTOR_i="#                                      BTCP over Tor (Darknet BTCPay)                  #"
elif grep -q "btcpTOR-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
btcpTOR_p="#                                      BTCP over Tor (Darknet BTCPay)                  #"
else
   #not installed
btcpTOR_n="#                            (btcpt)       BTCP over Tor (Darknet BTCPay)              #"
fi

#BTC RPC Explorer (not Docker)
unset btcrpcexplorer_i btcrpcexplorer_p btcrpcexplorer_n
if grep -q "btcrpcexplorer-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
btcrpcexplorer_i="#                                      BTC RPC Explorer                                #"
elif grep -q "btcrpcexplore-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
btcrpcexplorer_p="#                                      BTC RPC Explorer                                #"
else
   #not installed
btcrpcexplorer_n="#                            (bre)         BTC RPC Explorer                            #"
fi

#BTC RPC Explorer (Docker)
unset bre_i bre_p bre_n 
if grep -q "bre-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
bre_i="#                                      BTC RPC Explorer (Docker)                        #"
elif grep -q "bre-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
bre_p="#                                      BTC RPC Explorer (Docker)                        #"
else
   #not installed
bre_n="#                            (bre)         BTC RPC Explorer (Docker)                    #"
fi

#LNbits
unset lnbits_i lnbits_p lnbits_n
if grep -q "lnbits-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
lnbits_i="#                                      LNbits                                          #"
elif grep -q "lnbits-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
lnbits_p="#                                      LNbits                                          #"
else
   #not installed
lnbits_n="#                            (lnb)         LNbits                                      #"
fi

#trezor
unset trezor_i trezor_p trezor_n

if grep -q "trezor-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
trezor_i="#                                      Trezor Suite                                    #"
elif grep -q "trezor-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
trezor_p="#                                      Trezor Suite                                    #"
else
   #not installed
trezor_n="#                            (trz)         Trezor Suite                                #"
fi

#Bitbox
unset bitbox_i bitbox_p bitbox_n

if grep -q "bitbox-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
bitbox_i="#                                      BitBox                                          #"
elif grep -q "bitbox-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
bitbox_p="#                                      BitBox                                          #"
else
   #not installed
bitbox_n="#                            (bb)          Bitbox                                      #"
fi

#Ledger
unset ledger_i ledger_p ledger_n

if grep -q "ledger-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
ledger_i="#                                      Ledger                                          #"
elif grep -q "ledger-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
ledger_p="#                                      Ledger                                          #"
else
   #not installed
ledger_n="#                            (ll)          Ledger                                      #"
fi

#Parmashell
unset parmashell_i parmashell_p parmashell_n

if grep -q "parmashell-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
parmashell_i="#                                      ParmaShell                                      #"
elif grep -q "parmashell-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
parmashell_p="#                                      ParmaShell                                      #"
else
   #not installed
parmashell_n="#                            (ps)          ParmaShell                                  #"
fi

#NodeJS
unset nodejs_i nodejs_p_ nodejs_n 

if grep -q "nodejs-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
nodejs_i="#                                      NodeJS                                       #"
elif grep -q "nodejs-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
nodejs_p="#                                      NodeJS                                       #"
else
   #not installed
nodejs_n="#                            (njs)          NodeJS                                  #"
fi

#Parmabox
unset parmabox_n parmabox_i parmabox_p

if grep -q "parmabox-end" < $HOME/.parmanode/installed.conf ; then 
  #installed
parmabox_i="#                                      ParmaBox                                        #"
elif grep -q "parmabox-start" $HOME/.parmanode/installed.conf ; then 
   #partially installed
parmabox_p="#                                      ParmaBox                                        #"
else
   #not installed
parmabox_n="#                            (pbx)         Parmabox                                    #"
fi
}