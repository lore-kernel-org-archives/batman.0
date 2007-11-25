From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batmand still doesn't start the right way
Date: Sun, 25 Nov 2007 17:32:00 +0100
References: <4747BE35.3040307@absorb.it>
	<200711241744.20844.lindner_marek@yahoo.de>
	<47491D72.8020007@absorb.it>
In-Reply-To: <47491D72.8020007@absorb.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711251732.00986.axel@open-mesh.net>
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

Hi,
According to your log files the 144 batman does send OGM and also receives 
them. For me that does not look like a problem with batman.

If it is not HW related, it might still be a problem with the alias 
interfaces.

I guess your olsr is operating on the real interface names (not alias 
interfaces). So if the alias interface implementation is broken only batman 
is affected.

ciao,
axel

On Sonntag 25 November 2007, rene wrote:
> Hi,
>
> just had a look around over the installations and found the problem
> again. This time between two mipsel's. The setup: AP144 has a wireless
> connection to AP43. Just like that (192.168.1.X are olsr-routes):
>
> -- AP 144 --------------------------------------------------------
> root@144:~# route -n | grep ^192.168.1.43
> 192.168.1.43    0.0.0.0         255.255.255.255 UH    1      0        0
> eth1 root@144:~# ping 192.168.1.43
> PING 192.168.1.43 (192.168.1.43): 56 data bytes
> 64 bytes from 192.168.1.43: icmp_seq=0 ttl=64 time=2.8 ms
> 64 bytes from 192.168.1.43: icmp_seq=1 ttl=64 time=5.5 ms
>
> --- 192.168.1.43 ping statistics ---
> 2 packets transmitted, 2 packets received, 0% packet loss
> round-trip min/avg/max = 2.8/4.1/5.5 ms
> root@144:~# ps | grep batman
>   905 root        436 S   /usr/sbin/batmand eth1:1 vlan1:1
>   907 root        436 S   /usr/sbin/batmand eth1:1 vlan1:1
>   909 root        436 S   /usr/sbin/batmand eth1:1 vlan1:1
>  9661 root        280 S   grep batman
> root@144:~# ifconfig eth1:1
> eth1:1    Link encap:Ethernet  HWaddr 00:13:10:27:D6:A6
>           inet addr:192.168.40.144  Bcast:192.168.43.255 
> Mask:255.255.252.0 UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           Interrupt:4 Base address:0x1000
>
> root@144:~# ifconfig vlan1:1
> vlan1:1   Link encap:Ethernet  HWaddr 00:13:10:27:D6:A4
>           inet addr:192.168.41.144  Bcast:192.168.43.255 
> Mask:255.255.252.0 UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>
> -- AP 43 ---------------------------------------------------------
> root@43:~#  route -n | grep ^192.168.1.144
> 192.168.1.144   0.0.0.0         255.255.255.255 UH    1      0        0
> eth1 root@43:~# ping 192.168.1.144
> PING 192.168.1.144 (192.168.1.144): 56 data bytes
> 64 bytes from 192.168.1.144: icmp_seq=0 ttl=64 time=2.3 ms
> 64 bytes from 192.168.1.144: icmp_seq=1 ttl=64 time=2.0 ms
>
> --- 192.168.1.144 ping statistics ---
> 2 packets transmitted, 2 packets received, 0% packet loss
> round-trip min/avg/max = 2.0/2.1/2.3 ms
> root@43:~# ps | grep batman
>   903 root        436 R   /usr/sbin/batmand eth1:1 vlan1:1
>   907 root        436 S   /usr/sbin/batmand eth1:1 vlan1:1
>   908 root        436 S   /usr/sbin/batmand eth1:1 vlan1:1
>  5230 root        280 S   grep batman
> root@43:~# ifconfig eth1:1
> eth1:1    Link encap:Ethernet  HWaddr 00:18:39:6B:E0:95
>           inet addr:192.168.40.43  Bcast:192.168.43.255  Mask:255.255.252.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           Interrupt:2 Base address:0x5000
>
> root@43:~# ifconfig vlan1:1
> vlan1:1   Link encap:Ethernet  HWaddr 00:18:39:6B:E0:93
>           inet addr:192.168.41.43  Bcast:192.168.43.255  Mask:255.255.252.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>
> root@43:~#
>
> ------------------------------------------------------------------
>
>
>
>
> And now lets see what batman is doing:
>
> -- AP 144 --------------------------------------------------------
> root@144:~# tcpdump -i eth1:1 port 4305 and src 192.168.40.144
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on eth1:1, link-type EN10MB (Ethernet), capture size 96 bytes
>
> 0 packets captured
> 0 packets received by filter
> 0 packets dropped by kernel
> root@144:~# tcpdump -i vlan1:1 port 4305 and src 192.168.41.144
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on vlan1:1, link-type EN10MB (Ethernet), capture size 96 bytes
> 06:41:17.865478 IP 192.168.41.144.4305 > 192.168.43.255.4305: UDP, length
> 15 06:41:17.904019 IP 192.168.41.144.4305 > 192.168.43.255.4305: UDP,
> length 25 ...
>
> -- AP 43 ---------------------------------------------------------
> root@43:~# tcpdump -i eth1:1 port 4305 and src 192.168.40.43
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on eth1:1, link-type EN10MB (Ethernet), capture size 96 bytes
> 06:41:02.984846 IP 192.168.40.43.4305 > 192.168.43.255.4305: UDP, length 20
> 06:41:03.065075 IP 192.168.40.43.4305 > 192.168.43.255.4305: UDP, length 20
> ...
> 19 packets captured
> 38 packets received by filter
> 0 packets dropped by kernel
> root@43:~# tcpdump -i vlan1:1 port 4305 and src 192.168.41.43
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on vlan1:1, link-type EN10MB (Ethernet), capture size 96 bytes
> 06:41:31.255300 IP 192.168.41.43.4305 > 192.168.43.255.4305: UDP, length 20
> 06:41:31.406760 IP 192.168.41.43.4305 > 192.168.43.255.4305: UDP, length 25
> ...
> 18 packets captured
>
> ----------------------------------------------------------------
>
> So batman does not send any OGMs over eth1:1 from AP144. As a result
> there is no wireless batman-link between the two Accesspoints.
>
> You can find the output of batmand -c -d4 at:
> http://www.opennet-initiative.de/firmware/misc/log_AP43.log.gz
> http://www.opennet-initiative.de/firmware/misc/log_AP144.log.gz
>
>
> If you require more information, just ask.
> Regards,
> Rene
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


