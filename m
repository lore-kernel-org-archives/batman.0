Message-ID: <473B0AFD.7020801@leipzig.freifunk.net>
Date: Wed, 14 Nov 2007 15:49:33 +0100
From: tetzlav <tetzlav@leipzig.freifunk.net>
MIME-Version: 1.0
Subject: Re: AW: [B.A.T.M.A.N.] wrong ip rules / tunnel crashes
References: <470056.58415.qm@web26904.mail.ukl.yahoo.com>
In-Reply-To: <470056.58415.qm@web26904.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Marek Lindner schrieb:
>> batmand delete olsr-rules and set "from 104.0.0.0/8 lookup 68"!?
>>     
>
> which olsr-rules are deleted ? I can't see a difference there.
>   

Sorry, my fault - I should open my eyes:
at first look i thought batmand deleted the "from all to 104.0.0.0/8
lookup olsr" set.

> 2 choices:
> - You deleted the OLSR rules after each batmand start (hackish).
> - You use the --no-policy-routing option and set all rules by 
> yourself. This option allows a tight integration into a firmware and
> full control of the policy routing.
>   

ok ;)

after a small&dirty hack in batman-startscript
olsrd+batman+gatewaytunnel working:

--- 8< ---
        # policy-routing workaround for olsr ip-rules
        if [ "$gw_choose" != 0 -o -n "$gw_tunnel" ] && [ "$(nvram get
ff_policyrt)" = 1 ]; then
            echo -e "\nWorkaround to prevent conflicts between
olsrd/batmand"
            # eval $(/usr/bin/netparam)    # allready done

            for dev in WIFI LAN WAN; do   
                # needs consistent '$dev_proto=olsr' for olsr-devices
                # (unfortunately not any more in ff-v1.6.x)

                if [ "$(eval 'echo ${'$dev'OLSR}')" = 1 ]; then
                    OLSRNET="$(eval 'echo ${'$dev'NET}')/$(eval 'echo
${'$dev'PRE}')"

                    echo "* deleting all batmand ip rules 'from $OLSRNET
lookup 68'"
                    while ip rule del from $OLSRNET lookup 68
2>/dev/null; do :; done

                    echo "* set ip rule 'from $OLSRNET lookup olsr prio
6800'"
                    ip rule add from $OLSRNET lookup olsr prio 6800
                    echo "ip rule del from $OLSRNET lookup olsr prio
6800" >> $IF_LOCK
                fi
            done
            echo
        fi
--- >8 ---


but i noticed that the gatewaytunnel crashes somtimes if a package with
wrong source-adress comes along:

(client)
root@17-3:~# tcpdump -ni gate0
tcpdump: WARNING: arptype 65534 not supported by libpcap - falling back
to cooked socket
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on gate0, link-type LINUX_SLL (Linux cooked), capture size 96
bytes
01:31:01.584874 IP 169.254.0.2.1024 > 88.198.178.18.53:  43979+[|domain]
01:31:01.670353 IP 88.198.178.18.53 > 169.254.0.2.1024:  43979[|domain]
01:32:01.580469 IP 169.254.0.2.1024 > 88.198.178.18.53:  62407+[|domain]
01:32:01.641472 IP 88.198.178.18.53 > 169.254.0.2.1024:  62407[|domain]
01:32:20.330535 IP 104.61.17.3.41155 > 134.109.133.25.143: P
4242585185:4242585222(37) ack 1209814060 win 2003 <nop,nop,timestamp
165019315 636115595>
01:32:20.331694 IP 104.61.17.3.41156 > 134.109.133.25.143: P
4243816576:4243816613(37) ack 373738705 win 1413 <nop,nop,timestamp
165019315 636115598>
01:32:20.334014 IP 104.61.17.3.49819 > 88.198.44.10.993: P
4250143974:4250144011(37) ack 2087267410 win 2003 <nop,nop,timestamp
165019316 1323419075>
tcpdump: pcap_loop: recvfrom: Network is down
30 packets captured
63 packets received by filter
0 packets dropped by kernel


(gateway)
root@17-35:~# batmand -cd3
[...]
Gateway - assigned 169.254.0.2 to client: 105.61.17.3
Gateway - assigned 169.254.0.2 to client: 105.61.17.3
Gateway - assigned 169.254.0.2 to client: 105.61.17.3
Deleting route to 105.61.17.32/32 via 105.61.89.90 (table 66 - vlan1:bat)
Adding route to 105.61.17.32/32 via 105.61.89.92 (table 66 - vlan1:bat)
Deleting route to 105.61.17.17/32 via 105.61.89.90 (table 66 - vlan1:bat)
Adding route to 105.61.17.17/32 via 105.61.89.92 (table 66 - vlan1:bat)
Gateway - assigned 169.254.0.1 to client: 105.61.89.90
Deleting route to 105.61.17.17/32 via 105.61.89.92 (table 66 - vlan1:bat)
Adding route to 105.61.17.17/32 via 105.61.89.90 (table 66 - vlan1:bat)
Gateway - assigned 169.254.0.1 to client: 105.61.89.90
Deleting route to 105.61.17.19/32 via 105.61.89.90 (table 66 - vlan1:bat)
Adding route to 105.61.17.19/32 via 105.61.89.92 (table 66 - vlan1:bat)
Deleting route to 105.61.17.19/32 via 105.61.89.92 (table 66 - vlan1:bat)
Adding route to 105.61.17.19/32 via 105.61.89.90 (table 66 - vlan1:bat)
Gateway - assigned 169.254.0.2 to client: 105.61.17.3
Deleting route to 105.61.17.32/32 via 105.61.89.92 (table 66 - vlan1:bat)
Adding route to 105.61.17.32/32 via 105.61.89.90 (table 66 - vlan1:bat)
Gateway - assigned 169.254.0.1 to client: 105.61.89.90
Gateway - assigned 169.254.0.1 to client: 105.61.89.90
Gateway - assigned 169.254.0.1 to client: 105.61.89.90
Gateway - assigned 169.254.0.1 to client: 105.61.89.90
Unix socket: got connection
Unix client closed connection ...

root@17-35:~# logread
[...]
Nov 14 15:35:37 (none) daemon.err batmand[30596]: Error - can't delete
route to 105.61.17.17/32 via 105.61.89.90 (table 66): No such process
Nov 14 15:38:14 (none) daemon.err batmand[30596]: Error - can't delete
route to 105.61.17.32/32 via 105.61.89.90 (table 66): No such process
Nov 14 15:40:09 (none) daemon.err batmand[30604]: Error - got packet
from unknown client: 105.61.17.3 (virtual ip 104.61.17.3) 
Nov 14 15:40:09 (none) daemon.err batmand[30604]: Error - got packet
from unknown client: 105.61.17.3 (virtual ip 104.61.17.3) 
Nov 14 15:40:10 (none) daemon.err batmand[30604]: Error - got packet
from unknown client: 105.61.17.3 (virtual ip 104.61.17.3) 
Nov 14 15:40:11 (none) daemon.err batmand[30604]: Error - got packet
from unknown client: 105.61.17.3 (virtual ip 104.61.17.3)


Regards
tetzlav
