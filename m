Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 08 Sep 2012 00:02:14 +0200
Message-ID: <1662142.Wt7UliYyVe@sven-desktop.home.narfation.org>
In-Reply-To: <CAMVTf1g7a=6v72tZ_5G4tCXmZLCGCq0UT8_wQoDvN5D_jGP7TQ@mail.gmail.com>
References: <CAMVTf1g7a=6v72tZ_5G4tCXmZLCGCq0UT8_wQoDvN5D_jGP7TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1560739.mjcvMM8KVO";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] How to force a specific network topology
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1560739.mjcvMM8KVO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Friday 07 September 2012 16:58:33 Esteban Municio wrote:
> Hi list
> 
> Is there any way to block some links between nodes in order to force a
> specific network topology in batman-adv?
> 
> Por example, if y have 3 nodes A, B, C and I want to create a string
> topology A <-> B <-> C, where A can not connect directly with C, how
> could I get it without move far away the nodes?

You can try to add a your interface to a bridge (only one interface per 
bridge) and add this bridge to batman-adv. Now you can filter packets using 
ebtables (and therefore drop packets from specific hosts).

Kind regards,
	Sven
--nextPart1560739.mjcvMM8KVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQSm7mAAoJEF2HCgfBJntGfYUP/icMj4upTH83ZVV686OA69O9
J7WZBk/mdKWq6dq/qehQiqUl6kvvF+mFDL+eD+RxCff8miYVkJv9R2dem+KtOL4B
ghiLbya84/A6z4NQWoUbpTzLVcWj4AwZDNajK4vB0Hk/2EHrPd+Qr0Z5Ntl6pjQY
4UU4Z+wBzKB0tNOYrWSaY/5rAAAnT94TenpMKCdnwdyUMDhgm2wvY0JDKAtQ8z17
VmI+Pju4ebdTw3M7RCCnbzDKpbnkh/MGPcj+WJMBcWm128OUoaTgs0pmOByOVzIp
u1nUEGdNhb8Vk71gczUNaTWkVpOBx3iQg2Fpuw51pVgjexFu0E8RWOmAFmCNsKm8
Qbfw78LSIe0vlgwiD/6Tlk+jeqz5UjJw0otTYk6/U+bm+0pKozaEX8BEXwYABmlO
BMfC6Z4rSXPebGvU7gJ4DKJejGorr85qUCQ02qRYmFw2mraoz3lFsPFtSAR1PNO8
I2lkXoI6m2AEUIw+rfSh125b0x9aUnQoGUiBeTKWFJv4AP3ro1E/N5EjsNE3+ObX
bHfl4gmxYChPwWng074iGxw1SLX4ZEwHy/w1z4LYZnAPKQsT9E+Q5eoZQttNMZ23
TWQ4F+liZP3Aud8wFhqW407wqu48cbCFygIoSU2BACRF2yIm4eg2dB/zE7EFWq2U
daTQYIYm9kz+2wtS9uBr
=5pFj
-----END PGP SIGNATURE-----

--nextPart1560739.mjcvMM8KVO--

