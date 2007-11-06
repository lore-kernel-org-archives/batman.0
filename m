Message-ID: <473055F2.8020206@leipzig.freifunk.net>
Date: Tue, 06 Nov 2007 12:54:26 +0100
From: tetzlav <tetzlav@leipzig.freifunk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] routing tables
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

> root@13-18:~# batmand -v
> B.A.T.M.A.N. 0.3-beta rv780 (compatibility version 4)

> root@13-18:~# ip r s t 65
> throw 105.61.89.81  proto static
> 105.61.89.86 dev vlan1  proto static  scope link  src 105.61.89.81
> 105.61.89.89 dev vlan1  proto static  scope link  src 105.61.89.81
> 105.61.89.90 dev vlan1  proto static  scope link  src 105.61.89.81
> 105.61.89.92 dev vlan1  proto static  scope link  src 105.61.89.81

> root@13-18:~# ip r s t 66
> 105.61.17.1 via 105.61.89.92 dev vlan1  proto static  src 105.61.89.81
> 105.61.17.17 via 105.61.89.92 dev vlan1  proto static  src 105.61.89.81
> 105.61.17.32 via 105.61.89.86 dev vlan1  proto static  src 105.61.89.81
> throw 105.61.89.81  proto static
> 105.61.17.2 via 105.61.89.89 dev vlan1  proto static  src 105.61.89.81
> 105.61.17.18 via 105.61.89.89 dev vlan1  proto static  src 105.61.89.81
> 105.61.17.35 via 105.61.89.89 dev vlan1  proto static  src 105.61.89.81
> 105.61.17.21 via 105.61.89.90 dev vlan1  proto static  src 105.61.89.81
> 105.61.89.86 dev vlan1  proto static  scope link  src 105.61.89.81
> 105.61.89.89 dev vlan1  proto static  scope link  src 105.61.89.81
> 105.61.89.90 dev vlan1  proto static  scope link  src 105.61.89.81
> 105.61.89.92 dev vlan1  proto static  scope link  src 105.61.89.81


The 105.61.89.x-IPs are secandary BATMAN-interfaces (cable-connections).
Why are routes to this IPs in the table 65 (for announced networks)?
Bug or Feature? I think this is new in rv780...


Regards
tetzlav
