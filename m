Return-Path: <sven.eckelmann@gmx.de>
Date: Sun, 14 Mar 2010 13:04:10 +0100
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20100314120410.GA16678@sven-atom.lazhur.ath.cx>
References: <1268526950.4592.32.camel@rover>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <1268526950.4592.32.camel@rover>
Subject: Re: [B.A.T.M.A.N.] Strange sequence numbers
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 14, 2010 at 12:35:50AM +0000, Kevin Steen wrote:
> I've been lurking on this list for a few weeks, but finally tried
> compiling and running the batman-adv module from the svn sources.
>=20
> It seems to work fine between my two test machines so far, but I noticed
> some weird sequence numbers when doing a dump with 'batctl td'. In the
> sequence below, I had 'rover' running and active on rover's eth0, then I
> activated the eth1 interface on hilltop for a few seconds, then
> de-activated it.=20
>=20
> It seems like when rover re-sends the OGM from hilltop, it gets the
> sequence number wrong (1->256, 2->512, 3->768). Is this my lack of
> understanding of how it should work, a bug in batctl's display or a bug
> in batman-adv?
>=20
> rover is kernel 2.6.31-20-generic (Ubuntu karmic),
> hilltop is kernel 2.6.26-2-686 (Debian lenny)
>=20
> $ ./batctl td eth1
> 23:37:22.022554 BAT rover-eth0: OGM via neigh rover-eth0, seqno 481, tq 2=
55, ttl 50, v 9, flags [..F], length 42
> 23:37:23.002547 BAT rover-eth0: OGM via neigh rover-eth0, seqno 482, tq 2=
55, ttl 50, v 9, flags [..F], length 42
> 23:37:23.982469 BAT rover-eth0: OGM via neigh rover-eth0, seqno 483, tq 2=
55, ttl 50, v 9, flags [..F], length 42
> 23:37:24.962417 BAT rover-eth0: OGM via neigh rover-eth0, seqno 484, tq 2=
55, ttl 50, v 9, flags [..F], length 42
> 23:37:25.962320 BAT rover-eth0: OGM via neigh rover-eth0, seqno 485, tq 2=
55, ttl 50, v 9, flags [..F], length 42
> 23:37:26.943490 BAT rover-eth0: OGM via neigh rover-eth0, seqno 486, tq  =
 0, ttl 49, v 9, flags [D..], length 42
> 23:37:27.041437 BAT rover-eth0: OGM via neigh hilltop-eth1, seqno 486, tq=
   0, ttl 49, v 9, flags [D..], length 28
> 23:37:27.893422 BAT hilltop-eth1: OGM via neigh hilltop-eth1, seqno 1, tq=
 255, ttl 50, v 9, flags [..F], length 22
> 23:37:27.922233 BAT rover-eth0: OGM via neigh rover-eth0, seqno 487, tq  =
 0, ttl 49, v 9, flags [D..], length 42

Thanks for testing the code. I doubt that this is a bug in the batman-adv c=
ode.
Can you please make a capture of the raw packet data using tcpdump and/or
wireshark? I think that this is a batctl bug, but I don't have time to chec=
k it
right now. You can do the comparison by yourself using the wireshark-batman=
-adv
dissector linked in the open-mesh.net wiki.

Best regards,
	Sven

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJLnNC5AAoJEF2HCgfBJntGkSMQALVq56FiTDGU/XMB00Hpnm+c
7tzSNrMlZ0+viXLIwK7EITdMNFENPDkQuOtXTSp3Gqr6tz/k+7YGjtOSIwgDz7Pi
VwJsWTdTUIP4EptGC6e2IaJ8w0EN9RQOMee9UHkQJBe49On/4NRQyQl847ppHqLk
4wd59nUO1+aU93Rd9NlebWquXIRxkfrfO3DrKYaEjiEkykDiHAm17+hwv8Mvhtwg
64eKb25jG3LREswT9l5ZXIzFJ+vtP5UXmmx4mJcx3WEbr9j2EOJNzcA/UQGWO1KN
iAPl6CQ/cRsb2SGijev3Bz8WJawNYap0llvJOgoKtSPqZFqr1QPrgb0DJYJoh2Gm
NIncUtuhreUlTdjaj0Q7utX4NkM+Cpl5Qh4Q91KF67BoXlPP/l0Ovm7nE1WwwfLQ
AyWM0HZXBJci7sFHxx8//dURbuyfMW3f2uK/dLdcNOGsw6+9M3MMyWwdZcrmxLBv
8w0khZslRqzBorfZEQaeteK47YjTZrY82LsxVI+5D4aMnlIXHy/UbcZA/75L7g2I
3Uu6P10thA06B9yCShVCTv0LU21fsCzb37OMxtqOHrKx8WWtquFLpkc3RxRQrq78
HI54ZF+FY19AzYW4BK8e0eG4JGEUOX6yg0jZh1xWBn7KDOdEzQpQBvftA2Q9N2TB
rFi5b74CyE/QPKlQrTHE
=fuK4
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
