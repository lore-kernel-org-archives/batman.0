Return-Path: <trizonelabs@googlemail.com>
MIME-Version: 1.0
Date: Wed, 2 May 2012 15:00:18 +0300
Message-ID: <CAJuY50wYqnTpCkWtOOALdWy+RwCWpapMnprO0=Vz3SRVedmbEQ@mail.gmail.com>
From: 3zl Trizonelabs <trizonelabs@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] scripting batman-adv - best practice
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

i did start to script some basic helper functions and would like some opinion
Like say "best practice" :

#------------get_bat_if -----------
get_bat_if(){ #returns batman_interface_name     0= ok 1=false(bat
interface not existing)
     #local _bif =  DONT !! if contruction needs uninit var
     if _bif=$(basename $(dirname $(find /sys/class/net/*/mesh -type
d) )) 2&>/dev/null;
        then
         echo "$_bif"
         return 0
        else
         return 1
     fi
}

#-----------get_bat_wif--------------------
get_bat_wif(){ #return 0 active( wif=up) 1:inactive (wif=down) *
echoes $_bat_wif
     set -- $(batctl if | awk '{print $1,$2}') # $1 "wlan0:"  $2
"active" | "inactive"
     [ -z $(batctl if ] && exit 1
     local _bat_wif=$1 _bat0_status=$2
     echo ${_bat_wif%":"}
     [ "active" = "$_bat0_status" ] && return 0 || return 1
 }

#--------------get_bat_bridge -----------------
get_bat_bridge(){ # $1 bat_ifname returns bridgename attached to  0=
ok 1=false(bat interface not existing)
   local _bat_ifn=${1:-"bat0"}
   #ls -l /sys/devices/virtual/net/${_bat_ifn}/brport/bridge
   if _bat_br=$(basename $(ls -l
/sys/devices/virtual/net/${_bat_ifn}/brport/bridge | awk '{print
$11}'))
    then
        echo "$_bat_br"
         return 0
        else
         return 1
     fi
}

#------------bat_isup-----------------------
bat_isup(){ # test ok
 [ "down" = $(cat "${_bsysfs}operstate") ] && return 1 || return 0
#better  using carrier ??
}

#----------get_bat_neigh_cnt-----------
get_bat_neighb_cnt(){ # return 0 if neighbours - echo no. of neighbours
    local _bneighb=$(( $(batctl o | awk 'END{print NR}') -2))
    echo $_bneighb
    [ "$_bneighb" -gt 0 ] && return  || return 1
}


any input would be highly appreciated

regards
3zl
joker.eu5.org
