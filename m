Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 21 Oct 2016 17:53:23 +0200
Message-ID: <2233621.78qBEKtBva@bentobox>
In-Reply-To: <580A3456.5010002@yahoo.com>
References: <580A26A4.5030005@yahoo.com> <2284104.QWR2gm6sJD@bentobox>
 <580A3456.5010002@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2615851.nOHWJ4WAXd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] High latency with batman-adv on ethernet
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2615851.nOHWJ4WAXd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 21. Oktober 2016 23:29:26 CEST johnzeng wrote:
> [root@alarmpi ~]# batctl -v
> batctl 2016.2 [batman-adv: 2016.3]

seems to be recent enough. You can compare my batman-adv settings
by just grepping /sys/class/net/bat0/mesh/*

    $ grep '' /sys/class/net/bat0/mesh/*
    /sys/class/net/bat0/mesh/aggregated_ogms:enabled
    /sys/class/net/bat0/mesh/ap_isolation:disabled
    /sys/class/net/bat0/mesh/bonding:disabled
    /sys/class/net/bat0/mesh/bridge_loop_avoidance:enabled
    /sys/class/net/bat0/mesh/distributed_arp_table:enabled
    /sys/class/net/bat0/mesh/fragmentation:enabled
    /sys/class/net/bat0/mesh/gw_bandwidth:10.0/2.0 MBit
    /sys/class/net/bat0/mesh/gw_mode:off
    /sys/class/net/bat0/mesh/gw_sel_class:20
    /sys/class/net/bat0/mesh/hop_penalty:30
    /sys/class/net/bat0/mesh/isolation_mark:0x00000000/0x00000000
    /sys/class/net/bat0/mesh/multicast_mode:enabled
    /sys/class/net/bat0/mesh/network_coding:disabled
    /sys/class/net/bat0/mesh/orig_interval:1000
    /sys/class/net/bat0/mesh/routing_algo:BATMAN_IV

Btw. there are also other things I've mentioned/asked in my first reply.

[...]
> tcpdump   from  hostA 10.10.130.88
> 
> 
> [root@alarmpi ~]# tcpdump -i bat0

I said wireshark 2.x and eth0. You maybe can use these dumps to
find out if your hardware delays/drops the packets which batman-adv
encapsulates. Btw. I can not debug your hardware/driver from remote
(when this is a hardware/driver problem).

Anyway, please also read my comment at the end.


You could also dump eth0 and bat0 at the same time to check that the incoming
batadv+icmp-request packet comes out of bat0 as icmp-request packet with
nearly no extra delay. And then you can check that the icmp-reply transmitted
via the bat0 interface is transmitted with nearly no extra delay via the eth0
interface as batadv+icmp-reply.

> from hostB 10.10.130.1  ping  hostA 10.10.130.88
[...]
> tcpdump   from  hostA 10.10.130.88
> 
> 
> [root@alarmpi ~]# tcpdump -i bat0
> 15:26:17.498686 IP bogon > bogon: ICMP echo request, id 626, seq 1, 
> 15:26:18.522626 IP bogon > bogon: ICMP echo reply, id 626, seq 1, length 64
> 15:26:18.523618 IP bogon > bogon: ICMP echo request, id 626, seq 2, 
> 15:26:19.244386 IP bogon > bogon: ICMP echo reply, id 626, seq 2, length 64

Are you sure that you are dumping on the system which receives the ping
requests and has to reply to the ping requests? Because then you problem seems
to be above batman-adv. The request was given upwards "15:26:17.498686" from
bat0 (so batman-adv isn't responsible for the packet anymore) and the reply
for it was given to bat0 at "15:26:18.522626". So over 1 second delay caused
by something above the batman-adv layer.

Kind regards,
	Sven


--nextPart2615851.nOHWJ4WAXd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYCjnzAAoJEF2HCgfBJntG1ZkP/2aryJlcds8J3KrQBQsa04W7
KZRT4UudOkXURHa/Gnj/gZ25/cIcPS6QZ6WzfrPJd56QLTg4Am7vrhc33kL3wxSt
WInu4TViMrifk7pbUf1NaKvYdO2JleSO5UtAnmEfZeoMM/jT/uKfUJeQcsRQm3hN
i0q4Q3NIDNFFhKtv4+qTBhn0jtIxJaChXnwVO7Nl70/t++FxK8yHw3FUZBxpw2lX
zEe/74Lgcy/1AHqSSupysQls5ncOFn7OhDfXPI/VwSOMi4WP4VqAmHK0+VpLqogv
LmcMH6W0ZpajlV1mn7Jdany+GsZTxnZfB6+bWSJjnbit/K+AEUBxiK8B2LWZmKUT
fRmcLoFIqyl0lzit20eT+KA+TxtKtwkHpyBgm8oViHuRH+cYeIBfeICvLJkmpkVW
DvJ5mbtDXZEgVak6CHSoFdfk5OjEimTDeQ6xdWJ4VrVtIBIXFby6C2qCn4XmGdiF
+/NbEGu7C1TvW2Bojv23Ek2k0nncuUSSpjMxHP3UN6hKAgMBW8uL95z4h/bbObSs
djrWf5mn7fYqANa+bwCrknFTn2ndUFeaN1dnBCvBl/AbHUWBijQXN3o1/y0hyUsv
sOV9LNgkXOgdHIEaoC32MYpltza0RiNqZmp774yYEoiH28zADd/G6M68AN5VJ6Gn
i9lDHMzzLibaHwaqja7Q
=WjfG
-----END PGP SIGNATURE-----

--nextPart2615851.nOHWJ4WAXd--

