From: elektra <onelektra@gmx.net>
Date: Tue, 3 Mar 2009 19:26:45 +0100
References: <49AD6C20.8060404@java-system.com>
In-Reply-To: <49AD6C20.8060404@java-system.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903031926.46231.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. first experience (2 questions)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi Marco!

If you experience intermittend operation this is with 99.9% probability a 
driver issue.

Please use a Atheros-based interface with Madwifi driver and all patches  from 
OpenWRT's Madwifi!

And: Use nosbeacon option when creating adhoc VAP and fix the cell-ID 
(IBSSID).

Example:
wlanconfig ath0 create wlandev wifi0 wlanmode adhoc nosbeacon
iwconfig ath0 ap 02:CA:FF:EE:BA:BE

This is the only driver that works reliably. Broadcom proprietary driver with 
IBSS-fix hack works also (Linux 2.4.X from OpenWrt only)

Happy meshing!

cu elektra



>
> I just installed OpenWRT and B.A.T.M.A.N. on 3 Fonera router (IPs are
> 192.168.2.200-201-202)
> Started BATMAN on each fonera
> Power of fonera limited to 9dBm (instead of 18dBm) since I'm
> experimenting in my small apartment
>
> Then I started BATMAN on my laptop (IP 192.168.2.65)
>
> This is the output of batmand -d 1 wlan0
>   Originator  (#/255)         Nexthop [outgoingIF]:   Potential nexthops
> ... [B.A.T.M.A.N. 0.3, MainIF/IP: wlan0/192.168.2.65, UT: 0d 0h 2m]
> 192.168.2.200   (235)   192.168.2.200 [     wlan0]:   192.168.2.200
> (235)   192.168.2.202 (229)   192.168.2.201 (229)
> 192.168.2.201   (245)   192.168.2.201 [     wlan0]:   192.168.2.201
> (245)   192.168.2.200 (208)   192.168.2.202 (225)
> 192.168.2.202   (236)   192.168.2.202 [     wlan0]:   192.168.2.202
> (236)   192.168.2.201 (228)   192.168.2.200 (219)
> EOD
> BOD
>   Originator  (#/255)         Nexthop [outgoingIF]:   Potential nexthops
> ... [B.A.T.M.A.N. 0.3, MainIF/IP: wlan0/192.168.2.65, UT: 0d 0h 2m]
> 192.168.2.200   (236)   192.168.2.200 [     wlan0]:   192.168.2.200
> (236)   192.168.2.202 (229)   192.168.2.201 (229)
> 192.168.2.201   (245)   192.168.2.201 [     wlan0]:   192.168.2.201
> (245)   192.168.2.200 (210)   192.168.2.202 (225)
> 192.168.2.202   (237)   192.168.2.202 [     wlan0]:   192.168.2.202
> (237)   192.168.2.201 (229)   192.168.2.200 (221)
> EOD
> BOD
>   Originator  (#/255)         Nexthop [outgoingIF]:   Potential nexthops
> ... [B.A.T.M.A.N. 0.3, MainIF/IP: wlan0/192.168.2.65, UT: 0d 0h 2m]
> 192.168.2.200   (237)   192.168.2.200 [     wlan0]:   192.168.2.200
> (237)   192.168.2.202 (229)   192.168.2.201 (229)
> 192.168.2.201   (245)   192.168.2.201 [     wlan0]:   192.168.2.201
> (245)   192.168.2.200 (212)   192.168.2.202 (225)
> 192.168.2.202   (237)   192.168.2.202 [     wlan0]:   192.168.2.202
> (237)   192.168.2.201 (229)   192.168.2.200 (223)
> EOD
> BOD
>   Originator  (#/255)         Nexthop [outgoingIF]:   Potential nexthops
> ... [B.A.T.M.A.N. 0.3, MainIF/IP: wlan0/192.168.2.65, UT: 0d 0h 2m]
> 192.168.2.200   (239)   192.168.2.200 [     wlan0]:   192.168.2.200
> (239)   192.168.2.202 (229)   192.168.2.201 (229)
> 192.168.2.201   (246)   192.168.2.201 [     wlan0]:   192.168.2.201
> (246)   192.168.2.200 (213)   192.168.2.202 (225)
> 192.168.2.202   (238)   192.168.2.202 [     wlan0]:   192.168.2.202
> (238)   192.168.2.201 (229)   192.168.2.200 (223)
> EOD
>
>
> Then I started 3 terminal windows with ping command to each of 3 foneras
> I get a lot of error from ping command, please check at the following
> output example
>
>  >From 192.168.2.202 icmp_seq=10 Destination Port Unreachable
>  >From 192.168.2.202 icmp_seq=11 Destination Port Unreachable
>  >From 192.168.2.202 icmp_seq=12 Destination Port Unreachable
>
> 64 bytes from 192.168.2.201: icmp_seq=13 ttl=64 time=1.89 ms
> 64 bytes from 192.168.2.201: icmp_seq=14 ttl=64 time=1.64 ms
> 64 bytes from 192.168.2.201: icmp_seq=15 ttl=64 time=1.64 ms
> 64 bytes from 192.168.2.201: icmp_seq=16 ttl=64 time=1.61 ms
> 64 bytes from 192.168.2.201: icmp_seq=17 ttl=64 time=1.78 ms
>
>  >From 192.168.2.202 icmp_seq=18 Destination Port Unreachable
>  >From 192.168.2.202 icmp_seq=19 Destination Port Unreachable
>
> 64 bytes from 192.168.2.201: icmp_seq=20 ttl=64 time=1.68 ms
> 64 bytes from 192.168.2.201: icmp_seq=21 ttl=64 time=1.68 ms
> 64 bytes from 192.168.2.201: icmp_seq=22 ttl=64 time=1.84 ms
> 64 bytes from 192.168.2.201: icmp_seq=23 ttl=64 time=1.65 ms
> 64 bytes from 192.168.2.201: icmp_seq=24 ttl=64 time=1.58 ms
>
>
> The final result shows a loss of packets from 12% to 64%
>
> 1st question: Where is my error?
>
> 2nd question: I'm still able to perform ping to fonera router also after
> kill of batmand, is this ok?
>
>
> Thanks
> Marco
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n


