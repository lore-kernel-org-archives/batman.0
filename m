Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 20 Aug 2010 13:27:15 +0200
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTim9xwEgYLwK0bOzzmKkLMK6aedMDvD+SjrnTXFe@mail.gmail.com>
	<AANLkTikG3x-LEQdndaZsnhQn0VAejEk=S0pe_c2cWXA3@mail.gmail.com>
In-Reply-To: <AANLkTikG3x-LEQdndaZsnhQn0VAejEk=S0pe_c2cWXA3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8785299.QhsOndGD0m";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008201327.21282.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Nat Question
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
Cc: David Beaumont <djb31st@gmail.com>

--nextPart8785299.QhsOndGD0m
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Friday 20 August 2010 11:58:32 David Beaumont wrote:
> So large pings appear to be going over the batman interface.

So, first you say that all packets go over the bat interface and that this=
=20
part works fine. Now you say that large packets will also work... which is =
no=20
gain of information for the batman-adv related parts.

> However still not getting any web traffic through
>=20
> root@Generic:~# echo "HEAD / HTTP/1.1\nHost: git.open-mesh.net\n\n"|nc
> git.open-mesh.net 80
>=20
> root@Generic:~# wget http://www.google.com
> Connecting to www.google.com (74.125.39.104:80)
>=20
> What else can i provide to help track down the problem here :-(

Create a real minimal setup. Minimal as possible. Get that working and then=
 at=20
parts to it (iptables, bridges, ...) until it doesn't work anymore. Check i=
f=20
that is real the part which makes the problem by reducing the complexity of=
=20
other parts you already added.

You already told us that it is not related to batman-adv and that the bridg=
e=20
makes problems.

Actually nobody understands here what you are currently try to archive with=
=20
your setup and why all the iptables or maybe ebtables stuff/bridges/... is=
=20
needed to find a problem.

And why have both mesh and net (for whatever they are used) a masquerade ru=
le=20
in postrouting?


Simplest setup would be:
 * net is a nat router; everything in iptables to accept:
    iptables -F
    iptables -t nat -F
    iptables -t mangle -F
    iptables -X
    iptables -P INPUT ACCEPT
    iptables -P FORWARD ACCEPT
    iptables -P OUTPUT ACCEPT
   masquerade enabled
    iptables -t nat -A POSTROUTING -o "${OUTIF}" -j MASQUERADE
 * configure outif (the thing which has globally routable address)
 * enable wired connection between net and mesh by adding them to the same=
=20
   subnet (eth0 on net 192.168.1.1, eth0 on mesh 192.168.1.2)
 * Try to ping each other
 * test if connection between net and internet works flawless
 * test if connection between mesh and indirectly to the internet over net
   works flawless
 * set mtu of eth0 on both sides to 1530
 * check if `ping -M do -s 1500` works between both net and mesh
 * remove ip addresses of eth0 on both ends (but keep devices up)
 * add eth0 on both sides using `batctl if add` to bat0
 * set mtu of bat0 to 1500 on both hosts
 * give bat0 the same ips which were used before by eth0
 * set bat0 up
 * check if both hosts finds each other using `batctl o`
 * try to ping other host
 * try if internet works flawless indirectly from mesh over net
 * remove ip from bat0 devices
 * add bat0 to a bridge on both ends
 * set ips which were used by bat0 to the bridge devices
 * set mtu of bridge to 1500
 * try to.... I think you can guess the next 1000 steps by yourself

Regards,
	Sven

--nextPart8785299.QhsOndGD0m
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMbmaUAAoJEF2HCgfBJntGCK4P/Rt+T3sCFmggCnCdMiLlDG/y
CincHNDwO8C3ec+pKATZdg0T16BCO5QanjukbV6m8pTBRwRE9izXgFIcvIfc8tpz
289PsJFe75qw/RiGvqRaWBBJ7iOHjr8qrMo94VHEFSYhA6Dv4pcIM4h8ZoFRBdEU
d5ylB9S31h/pHAil9XbeZ7Q3CSFhb0GQ/27oNVRFLG3pyiNj9sDHNOcAPgRihryo
iSq531qB2tDAHxcvDXYtQFsoThKZGJoh19Qh1/R2QOFQYYUM6+8S7umZNWc4sNoY
8Ff68/VfcSoHRdkmUMQVLjq5PQQyiWIPNEydWR9JqfgdrwkdJJCp9zU1OY2vkj9Y
WGZDDSM+Ghrbdm546bcWSQugvXRfYG9nje2eIxOyqI2dMbAppHln9kCck3rDy59A
OKP4nYAQghnYMEIRwoCIMhxSP912so1hZEsw5MbyonT7rLQAL4uMrce0J9HT2RMA
4PPvQacbCeyaUKveuJfxk3u054xBn7Kd0niQYOK2IDCwnjXbpQKLtja2YZA9hahH
2avyY13mpik1JZ7CjM3SRe5gqW6HSchMb+NkxIpW+FXY4HCelCVctbPfgJF1dtXd
Pj/e/3m3anrhpzCbJdX2CmDXvf233TjzjCGakr0NS9CGuon7VuX72JcPHic/YpcT
bmMc/DcFqqrR+VO1xspk
=H4xA
-----END PGP SIGNATURE-----

--nextPart8785299.QhsOndGD0m--
