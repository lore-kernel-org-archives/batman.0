Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: batadv gw_mode client 0?
Date: Wed, 24 Jun 2020 21:36:47 +0200
Message-ID: <4434528.9OTWPoQ4Dk@sven-edge>
In-Reply-To: <3DDDEFCA-57DC-43E1-8534-F816F872CD2B@xecoenergy.com>
References: <927533E5-C265-44BF-B271-1A7A9A084447@xecoenergy.com> <20687769.zqcOZmODRP@bentobox> <3DDDEFCA-57DC-43E1-8534-F816F872CD2B@xecoenergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3465042.cCPKWQqU6M"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Rob Cowart <rob.cowart@xecoenergy.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart3465042.cCPKWQqU6M
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 24 June 2020 21:23:09 CEST Rob Cowart wrote:
[...]
>   I have another question regarding batman, is there a way to connect to the nodes using only batman?

batman-adv doesn't have any special TCP like protocol or remote shell access 
protocol. But you can either try to find the neighbors using link local IPv6 
and directly use this to connect to the remote:

    ping ff02::1%bat0
    # or
    ping ff02::1%wlan0

And if you see a couple of dups like this:

    $ ping ff02::1%wlan0
    PING ff02::1%wlan0 (ff02::1%22): 56 data bytes
    64 bytes from fe80::84ec:1cff:fea1:5629: seq=0 ttl=64 time=1.211 ms
    64 bytes from fe80::6c39:baff:fe1c:6d11: seq=0 ttl=64 time=7.107 ms (DUP!)

then you can just ssh to this node over IPv6 link local like this:

    ssh fe80::6c39:baff:fe1c:6d11%wlan0

Just make sure that you are actually add the interface name + "%" separator.

>   We have a situation where we've deployed batman V / alfred mesh networks (in several factories in Mexico, US and China) and then found dnsmasq is not up to the task of keeping our ips straight (with 20-30 nodes per mesh even) over months and years.  So we're trying to remotely change them all to static, but midway through the mesh (or whatever part of the mesh lets us ssh to the nodes) breaks down.  The nodes still show on batctl 
> pi@raspberrypi:~ $ sudo batctl n
> [B.A.T.M.A.N. adv 2018.4-23-g89ba2134-dirty, MainIF/MAC: wlan0/b8:27:eb:fb:4e:58 (bat0/d6:86:8d:7d:39:4d BATMAN_V)]
> IF             Neighbor              last-seen
> b8:27:eb:4e:73:6d   25.330s (        1.0) [     wlan0]
> b8:27:eb:ff:0e:b6   23.320s (        1.0) [     wlan0]
> b8:27:eb:08:13:37   18.850s (        1.0) [     wlan0]
> b8:27:eb:aa:1e:6d   37.010s (        1.0) [     wlan0]
> b8:27:eb:35:c6:77   63.590s (        1.0) [     wlan0]
> b8:27:eb:e9:34:41   18.280s (        1.0) [     wlan0]
> b8:27:eb:84:ca:90   30.560s (        1.0) [     wlan0]
> b8:27:eb:1e:eb:cd   27.410s (        1.0) [     wlan0]
> b8:27:eb:cb:80:34   23.100s (        1.0) [     wlan0]

Not sure what the ELP interval is here but the last seen is extremely high. I 
would guess that the lower link actually broke down and the neighbor entries
just  didn't time out yet.

> Also I was trying to figure out how to snoop what alfred is doing, since our MQTT goes over alfred over batman and that's what's not working...

There was a wireshark dissector written by some person [1]. But it might need 
some updating to get it working with newer wireshark versions.

> So if you started from scratch how would you architect, is there a way to use batman for everything?

But the combination mqtt with alfred sounds weird. Alfred just stores some 
very simple "facts" and distributes it slowly through the network. But MQTT is 
a messaging protocol and is often used for realtime message transport. So in 
most situations you would skip alfred and just use mqtt over whatever network 
you want. No special batman-adv stuff needed.

Kind regards,
	Sven

[1] https://github.com/basros/alfred-dissector

--nextPart3465042.cCPKWQqU6M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl7zq08ACgkQXYcKB8Em
e0ZKdA//XVsZSrCs6NITaeye4INuTyzIaPTTNq4NEKWRPPiriG1nGw/ceD8/PNkT
fIv03bd6WcIAmmWWMYjzU7zFF/Vd0heImEiLz2McDNfn3GF9E9fS8xGJ9Aw30D09
pF0FoZ5j6ukoJFG5ifkbbhTXalPu3sfV1H2ysmjxre23w9p3xXlr8NOzSPZP6Bbo
ADrvOm3nwkvHkTUPJMAlkEzI3o8E+FoX5aP9Lpsq2ZJskajf6ugEy/8WJ16GBj1q
ljkEEHA5KJv51jCxxncmtFgCKr9s9Pt5RgrOb7t+GBo9b2LKCGuctVqi1VQDkUPQ
ir9iPzYWL0YS0ZJjCaz3LJaywQHuhIS7+H1/F9Z92vnBLrFwHRX5SM+NEx/p6mcR
XP2BOsUOcvITvN+lMTHsVRc+GLzlUeeapULSnf4obTlqVAWlkcdk2U8I767UdTe1
HQNmLJF2ZV0AmQRwOPRYwpMk9yJBMDqyGg2dCbWJn0pmSCuB8Nui8ir8NGD0J8ki
VRQINDeMz7lTJWDVXql8TUyZPzb4mOJZeE8vsVaJH7SMfUoZ9aAJlekbFhyzZfDz
+m2KdRGnvCT+fWp9eoKbzK7HO9Qv6V9imkG28xiwTY8FVnNX+kvn2WasE0kc+tch
jUuuEVCGKfpGFbnSMJOpYOOjM47Q0rPKiSVufFaKW6vB/R+Sb4w=
=f3Jm
-----END PGP SIGNATURE-----

--nextPart3465042.cCPKWQqU6M--


