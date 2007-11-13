Message-ID: <473A322D.7030302@leipzig.freifunk.net>
Date: Wed, 14 Nov 2007 00:24:29 +0100
From: tetzlav <tetzlav@leipzig.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] wrong ip rules
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

Today I tried batmand 0.3-beta rv791 (on ASUS-WL-500gPremium) and
noticed that batmand set definitly wrong ip rules
or has problems with alias-Interfaces and/or olsrd:

> root@17-3:~# ip addr show eth2
> 4: eth2: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc prio qlen 1000
>     link/ether 00:90:4b:7d:20:7a brd ff:ff:ff:ff:ff:ff
>     inet 104.61.17.3/8 brd 104.255.255.255 scope global eth2
>     inet 10.61.17.3/24 brd 10.61.17.255 scope global eth2
> root@17-3:~# ip rule
> 0:      from all lookup local
> 6597:   from all lookup main
> 6598:   from all to 104.0.0.0/8 lookup olsr
> 6599:   from 104.0.0.0/8 lookup olsr
> 32766:  from all lookup main
> 32767:  from all lookup default
> root@17-3:~# ip addr add dev eth2 105.61.17.3/8 broadcast + label eth2:bat
> root@17-3:~# ip addr show eth2
> 4: eth2: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc prio qlen 1000
>     link/ether 00:90:4b:7d:20:7a brd ff:ff:ff:ff:ff:ff
>     inet 104.61.17.3/8 brd 104.255.255.255 scope global eth2
>     inet 10.61.17.3/24 brd 10.61.17.255 scope global eth2
>     inet 105.61.17.3/8 brd 105.255.255.255 scope global eth2:bat
> root@17-3:~# batmand -r2 eth2:bat
> Using interface eth2:bat with address 105.61.17.3 and broadcast
> address 105.255.255.255
> root@17-3:~# ip rule
> 0:      from all lookup local
> 6597:   from all lookup main
> 6598:   from all to 104.0.0.0/8 lookup olsr
> 6599:   from 104.0.0.0/8 lookup olsr
> 6600:   from all to 105.0.0.0/8 lookup 66
> 6699:   from all lookup 65
> 6700:   from all to 105.0.0.0/8 lookup 67
> 6800:   from all iif lo lookup 68
> 6801:   from 127.0.0.0/8 lookup 68
> 6802:   from 104.0.0.0/8 lookup 68
> 6803:   from 104.0.0.0/8 lookup 68
> 6804:   from 192.168.1.0/24 lookup 68
> 32766:  from all lookup main
> 32767:  from all lookup default

batmand delete olsr-rules and set "from 104.0.0.0/8 lookup 68"!?


Regards
tetzlav
