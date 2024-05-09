function make_bitcoin_symlinks {
set_terminal

while true ; do

if [[ $OS == "Linux" && $drive == "internal" ]] ; then
    return 0 
    #no symlink needed
    fi

if [[ $OS == "Linux" && $drive == "external" ]] ; then
    cd $HOME && ln -s /media/$(whoami)/parmanode/.bitcoin/ .bitcoin  
    break  #symlink can be made withouterrors even if target doesn't exist yet
    fi

if [[ $OS == "Mac" && $drive == "internal" ]] ; then
    cd $HOME/Library/"Application Support"/ ; rm -rf  Bitcoin
    cd $HOME/Library/"Application Support"/ && ln -s $HOME/.bitcoin Bitcoin 
    break
    fi

if [[ $OS == "Mac" && $drive == "external" ]] ; then
    cd $HOME/Library/Application\ Support/ >/dev/null 2>&1 && rm -rf Bitcoin >/dev/null 2>&1 
    cd $HOME && rm -rf .bitcoin >/dev/null 2>&1 
    cd $HOME/Library/Application\ Support/ && ln -s /Volumes/parmanode/.bitcoin Bitcoin && \
    cd $HOME && ln -s $parmanode_drive/.bitcoin .bitcoin 
    break
    fi
done

set_terminal ; echo -e "
########################################################################################

                                $cyan 
                                 Symlinks created
$orange
    NOTHING TO DO, IT'S JUST FOR YOUR INFORMATION IN CASE YOU WANT IT.

    A symlink to the data directory has been created.

    For external drives, $HOME/.bitcoin points to
$green
            $parmanode_drive/.bitcoin
$orange
    For Mac users with an internal drive, 
    $HOME/Library/Application Support/Bitcoin (the default location),
    now points to:
$green
            $HOME/.bitcoin
$orange
########################################################################################
"
enter_continue
return 0
}
