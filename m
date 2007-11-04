Message-ID: <472D281F.4010208@leipzig.freifunk.net>
Date: Sun, 04 Nov 2007 03:02:07 +0100
From: tetzlav <tetzlav@leipzig.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Experiences with B.A.T.M.A.N. 0.3-beta rv767
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

We playing around with B.A.T.M.A.N. 0.3-beta rv767 in our leipziger
Freifunk-testing-Firmware (based on v1.6.10):

the Routing works fine (if i start "batmand  eth1:bat vlan1:bat") -
great work!
but the gateway-function (option "-r 2") drives me mad:

* why the tunnel-interface (gateX) now have IP-Adresses!?

* what this log-message (on gateway) wants to tell me? (105.61.89.81 is
  an Node who wants to build up an gateway-tunnel)

> Nov  3 16:49:38 (none) kern.err batmand[1819]: Error - got packet from
> unknown client: 105.61.89.81 (virtual ip 104.61.13.37)  
> Nov  3 16:49:40 (none) kern.err batmand[1819]: Error - got packet from
> unknown client: 105.61.89.81 (virtual ip 104.61.13.37)  
> Nov  3 16:49:41 (none) kern.err batmand[1819]: Error - got packet from
> unknown client: 105.61.89.81 (virtual ip 104.61.13.13)  
> Nov  3 16:49:42 (none) kern.err batmand[1819]: Error - got packet from
> unknown client: 105.61.89.81 (virtual ip 104.61.13.13)  
> Nov  3 16:49:43 (none) kern.err batmand[1819]: Error - got packet from
> unknown client: 105.61.89.81 (virtual ip 104.61.17.28)  
> Nov  3 16:49:43 (none) kern.err batmand[1819]: Error - got packet from
> unknown client: 105.61.89.81 (virtual ip 104.61.13.37)

(there is no rule to throw 104/8 to batman tables)

> root@13-18:~# ip rule show
> 0:      from all lookup local
> 6600:   from all to 105.0.0.0/8 lookup 66
> 6601:   from all to 105.61.89.80/28 lookup 66
> 6699:   from all lookup 65
> 6700:   from all to 105.0.0.0/8 lookup 67
> 6701:   from all to 105.61.89.80/28 lookup 67
> 32766:  from all lookup main
> 32767:  from all lookup default
> root@13-18:~# ip r s t 65
> throw 105.61.89.81  proto static
> 105.61.89.89 dev vlan1  proto static  scope link  src 105.61.89.81
> 105.61.89.90 dev vlan1  proto static  scope link  src 105.61.89.81
> 105.61.88.193 via 105.61.89.90 dev vlan1  proto static  src 105.61.89.81
> root@13-18:~# ip r s t 66
> 105.61.17.32 via 105.61.89.90 dev vlan1  proto static  src 105.61.89.81
> throw 105.61.89.81  proto static
> 105.61.17.35 via 105.61.89.89 dev vlan1  proto static  src 105.61.89.81
> 105.61.17.21 via 105.61.89.90 dev vlan1  proto static  src 105.61.89.81
> 105.61.89.89 dev vlan1  proto static  scope link  src 105.61.89.81
> 105.61.89.90 dev vlan1  proto static  scope link  src 105.61.89.81
> root@13-18:~# ip r s t 67
> throw 105.61.89.81  proto static
> unreachable default  proto static 
> root@13-18:~# batmand -bcd 2
> WARNING: You are using the unstable batman branch. If you are
> interested in *using* batman get the latest stable release !
>      Gateway     (#/255)         Nexthop [outgoingIF], gw_class ...
> [B.A.T.M.A.N. 0.3-beta rv767, MainIF/IP: eth1:bat/105.61.13.18, UT: 0d
> 0h 4m]
>    105.61.89.89    (255)    105.61.89.89 [ vlan1:bat], gw_class  65 -
> 16MBit/4MBit, reliability: 0
>    105.61.17.35    (255)    105.61.89.89 [ vlan1:bat], gw_class  65 -
> 16MBit/4MBit, reliability: 0

* I noticed, that LAN-clients (on batmannodes) sometimes get 169.x.y.z
  Addresses per DHCP if i start  batmand with "-r 2"-option?

B.A.T.M.A.N. 0.2 worked fine, but we want/must use B.A.T.M.A.N. 0.3,
because the available policy-routing cause no problems with parallel
driven olsrd.


Regards
tetzlav

