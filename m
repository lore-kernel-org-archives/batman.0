Message-ID: <59044.85.41.146.90.1195884923.squirrel@krisma.oltrelinux.com>
In-Reply-To: <4747BE35.3040307@absorb.it>
References: <4747BE35.3040307@absorb.it>
Date: Sat, 24 Nov 2007 07:15:23 +0100 (CET)
Subject: Re: [B.A.T.M.A.N.] batmand still doesn't start the right way
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi

can you give the exact IP configuration (network, netmask end bcast IP)
for every iface?

-- Antonio

> Hi all,
>
> still having problem with batman. Mostly it starts without any problems,
> but sometimes it seems not to do what it should. In the following
> example, for instance, batmand sends OG-messages only through ath0:1
> (192.168.41.186) and ath1:1 (192.168.42.186), but not through eth0:1
> (which is the only interface where another batman-node, 192.168.40.184
> is connected, OGs from this node are received). Any Ideas?
>
> Regards,
> Rene
>
> --------------------------------------------------------------------
> root@OpenWrt:~# /etc/init.d/batmand start
> Starting batmand...
> Using interface eth0:1 with address 192.168.40.186 and broadcast address
> 192.168.43.255
> Using interface ath0:1 with address 192.168.41.186 and broadcast address
> 192.168.43.255
> Using interface ath1:1 with address 192.168.42.186 and broadcast address
> 192.168.43.255
> root@OpenWrt:~# tcpdump -i ath1:1 port 4305
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on ath1:1, link-type EN10MB (Ethernet), capture size 96 bytes
> 05:51:36.614733 IP 192.168.42.186.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:36.832907 IP 192.168.42.186.4305 > 192.168.43.255.4305: UDP, length
> 15
> 05:51:37.224704 IP 192.168.42.186.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:37.683458 IP 192.168.42.186.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:37.843369 IP 192.168.42.186.4305 > 192.168.43.255.4305: UDP, length
> 15
>
> 5 packets captured
> 10 packets received by filter
> 0 packets dropped by kernel
> root@OpenWrt:~# tcpdump -i ath0:1 port 4305
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on ath0:1, link-type EN10MB (Ethernet), capture size 96 bytes
> 05:51:44.454408 IP 192.168.41.186.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:44.702985 IP 192.168.41.186.4305 > 192.168.43.255.4305: UDP, length
> 15
> 05:51:44.732650 IP 192.168.41.186.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:45.492874 IP 192.168.41.186.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:45.682386 IP 192.168.41.186.4305 > 192.168.43.255.4305: UDP, length
> 15
> 05:51:45.693262 IP 192.168.41.186.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:46.582916 IP 192.168.41.186.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:46.622357 IP 192.168.41.186.4305 > 192.168.43.255.4305: UDP, length
> 15
> 05:51:46.712604 IP 192.168.41.186.4305 > 192.168.43.255.4305: UDP, length
> 25
>
> 9 packets captured
> 18 packets received by filter
> 0 packets dropped by kernel
> root@OpenWrt:~# tcpdump -i eth0:1 port 4305
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on eth0:1, link-type EN10MB (Ethernet), capture size 96 bytes
> 05:51:52.051159 IP 192.168.40.184.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:52.543207 IP 192.168.40.184.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:53.130721 IP 192.168.40.184.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:53.622574 IP 192.168.40.184.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:54.200698 IP 192.168.40.184.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:54.661832 IP 192.168.40.184.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:55.180689 IP 192.168.40.184.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:55.581781 IP 192.168.40.184.4305 > 192.168.43.255.4305: UDP, length
> 25
> 05:51:56.150711 IP 192.168.40.184.4305 > 192.168.43.255.4305: UDP, length
> 25
>
> 9 packets captured
> 18 packets received by filter
> 0 packets dropped by kernel
> root@OpenWrt:~#
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>


