Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 02 Aug 2011 10:32:15 +0200
Message-ID: <77194694.R5bZIYz2sd@sven-laptop.home.narfation.org>
In-Reply-To: <9bf008cbb049b3d76dcb7899e48f949c@mail.gmail.com>
References: <9bf008cbb049b3d76dcb7899e48f949c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1353576.Kv2FLyCP28";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] DNS Batmand
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1353576.Kv2FLyCP28
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"

On Monday 01 August 2011 16:10:41 Camila Troncoso wrote:
> I=B4m working for some time with a wireless mesh.  I have several dev=
ices
> with a basic linux inside (Openwrt) and they are running Batmand prot=
ocol.
> One of the mesh nodes acts as a gateway to internet, obtaining IP and=
 DNS
> trough pppoe. The other nodes act as clients and connect to internet
> trough this gateway.

Do you really use batmand? There is a maintainer for this daemon, but I=
 would=20
say that there is no measurable difference between now and the time whe=
n no=20
maintainer was available.

> The only problem that I=92m facing , is that even when the gateway cr=
eates
> the tunnel ( gate0) with the client node and gave it internet connect=
ivity
> , it doesn=92t modify the /etc/resolv.conf file, and the client node =
isn=92t
> capable of resolving names (DNS).

It is a long time since I used batmand, but at least I think that the g=
ateway=20
functionality was never intended to be used as full replacement for DHC=
P.=20
Actually, it has a complete different task scope. This means that it ha=
ndles=20
all the routing stuff, but resolving of names is a complete different t=
opic.=20
You would have to use an external nameserver (own server or just a free=
 one=20
[1]) or use a special node in the mesh as dns server. Every node has to=
 be=20
preconfigured with this nameserver in their /etc/resolv.conf (or better=
:=20
inside the uci configuration [2]).

> I don=92t understand why the gateway node is not giving the client no=
de all
> the necessary information of the internet connection.  I suppose by
> protocol , if the gateway makes a tunnel , gives IP and route to the
> clients nodes, It also has to give them a way to resolve names (DNS).=


It depends what you define as "necessary". I would say that necessary i=
s only=20
the ip stuff. So everything is done by the gateway... Nameserver is onl=
y=20
optional and I don't see the reason why this is wrong.

If you really want DHCP... please feel free to use batman-adv [3]. Ther=
e is=20
also AHCP [4] for Layer3 protocols, but I never used it. At least the b=
abel=20
guys seem to be happy about it. This is enough to be mentioned here :)
It is not meant to be used to enhance the batmand gateway stuff, but it=
 can be=20
used to automatically configure the nameserver instead of preconfigurin=
g it.

To make it short: batmand is a routing daemon and not something like=20=

pppoe/dhcp/ahcp/...

Kind regards,
=09Sven

[1] http://theos.in/windows-xp/free-fast-public-dns-server-list/
[2] http://wiki.openwrt.org/doc/uci/network
[3] http://www.open-mesh.org/projects/batman-adv/wiki
[4] http://www.pps.jussieu.fr/~jch/software/ahcp/
--nextPart1353576.Kv2FLyCP28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJON7YPAAoJEF2HCgfBJntGSdoP/2DEj3c7Jacw4MrSAJh8s7vY
KmjgtvwpG4BMq0ky2Mc8KonbBirKufLCanpInL0WbuXt6VdYQWEA5mg2JY2bkuWP
9/zfbo+OIYWJ33yjrFMfQwstK6t87f/QZyirajkMTA6NajmyHreSM8QogcqR/Rza
6JPThbqrpTq4+F3p27iQI4UFdAWOBSyxcCtF+DWUIK5+dePDsBLtuYP/BuHiX6xF
vftKxSjRqEPSZHdgZ9hZktr+EYN3wCZEpTYvQmb8iFYAmedkiLre0IuLbHqqkAhD
euF0Pza7/LP2AOzcJ0ZVIzjbMjc9D0uYunbd7zLEqQgGnxuoUUx3jMg1yV8/UBu6
R9hioYJh+/CIOSuNoUezcnVXvFjLDOgTWjHAuBE8Ov2+lnGlN3015N7amdy8c0R6
lGv1/BX8qhblvWpjv9sSkUsofT/R91nGC7up0lq/GMLwRywY1N71a6WzLHShwblN
dcQfkzFizaComy4o7fbLv3PjMt6+r8fgTMXtiyQRoX3uc2GwXuT7b5t0s+Vqxu3M
qVxxJwAacbqxVHieZYBwROEixxPMq1oVpSE2iQvfGpMLkdiSFSHqfd5pBFDaPFKq
M66lKYik4ZQey81v7XEPww/+kV3HcNRsevE5oAabO+wdoNsOZ8pasUg1ZwnrgGq+
CLxkag1SUzr/I6ShyDST
=OR8Y
-----END PGP SIGNATURE-----

--nextPart1353576.Kv2FLyCP28--

