From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 2 Jun 2009 19:50:01 +0200
References: <4313f3060905190727x279f2d0boc4e74e4df6e821bc@mail.gmail.com>
	<200906012135.22488.sven.eckelmann@gmx.de>
	<200906021236.42019.lindner_marek@yahoo.de>
In-Reply-To: <200906021236.42019.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1767118.rn2NvpADjD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200906021950.07235.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Add padding around allocation debugger structures
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
To: b.a.t.m.a.n@open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1767118.rn2NvpADjD
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 02 June 2009 06:36:41 Marek Lindner wrote:
> On Tuesday 02 June 2009 03:35:07 Sven Eckelmann wrote:
> > So my question to marek: Is it really needed to have "struct
> > hna_global_entry" packed in hna.h:57? If not then we should remove it a=
nd
> > this problem should be gone. And what is with "struct hna_element".
>
> The first 5 bytes of both structs are used as base for the hash index. If
> the compiler changes the order or something similar it might not work.
Ok, then it should be safe to force the alignment of the pointers in=20
hna_global_entry. Everything else seems to be much more complicated and=20
doesn't create much cleaner code.

Best regards,
	Sven

--nextPart1767118.rn2NvpADjD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKJWZKAAoJEF2HCgfBJntG9xIQAJ3Gt5KjEjUH9Wiuz025SWkP
WlrthOwZM1pG+0dbrKZ/wv4rKlYxLC7XYRCveySty4JHJ9V2DUxmxRU3Px8q/GwH
7d8PCx9o+SHK8wo7en6px3g0WPtRVNBDpYCnUz35aWN+Fy7ydD4V4F34XoS3tR0Q
USHACE93meodqedL7iirAijYflTFP0GvMaaNNOlJx7kjzxyybe+O35qm3m5HMyvK
D7shqvp5bjD/UCXKGpB29kp7IlzlwCrhstLjha6lUVvbQd6jqgheqVfzxLd+W+xu
Yq0+RsqcFJpq1p0EO2Ptqt1xytbsnXMgZaIELRf1k/LvBNOQwKPzT3mi/xWCQwet
XVqtYtZyZPjSsKSd8+k0r8u+yUJGc6SS0I/XgzAMwMxnMZBcEWxYtxAQs4RyPiAU
4dz0xzRWC5XmlvnxYqB/lB9aernfpOl6OiVllF6PT5MzyNqELIyPSSVUhIde1VkO
14SMuQpYvoqGZl23EKlIuN1dSw6UktoOhqsuFcJcZmkl6/rdhmmfmC0HQS+q4iP4
VoxR/K2hpnAJ37go/ms4WVoJWtzNRp8C+YwvPeiVDzKUY2HQ6AUs3kOJYHf3zXjP
BPom9LeujPXT12mO3bHfhHdn5p09XKvInRRVNBFw4BL84ElgHY22OFskKph6ZtSe
2OOYLXHlmpQ+EPe2Q8vU
=I5gD
-----END PGP SIGNATURE-----

--nextPart1767118.rn2NvpADjD--
