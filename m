Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Jun 2009 22:51:07 +0200
References: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
	<200906222246.11849.sven.eckelmann@gmx.de>
	<5161afcd0906221348m7895318bwc87cf9d2369ca70@mail.gmail.com>
In-Reply-To: <5161afcd0906221348m7895318bwc87cf9d2369ca70@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3209271.N0x3agoVD5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200906222251.08240.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] HTTP transfers greater than 1000 bytes fail
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart3209271.N0x3agoVD5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 22 June 2009 22:48:21 Jacob Marble wrote:
> OK, what if I set the MTU of ath0 higher?  Lemme see.
You must also set the mtu of the bat0 higher (to 1500 to be more exact) whe=
n=20
you set the ath0 mtu to 1524 - it will not be increased automatically.

Regards,
Sven

--nextPart3209271.N0x3agoVD5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKP+68AAoJEF2HCgfBJntGiX0QAM9BxWIJ8G1T5rS0cupvPyzT
53FdsD855plAN8uSxc6ADyub4z5UxqN+vnUsuEmoBIhHViqTuT60aU1aYJemWvCo
67P7QihoAWyE7TwKAlJJ/0L4Aj4NO8w43dpyC2vqF3WaV3td/28qjser1P+rM1g/
rXoZ2Jzty1NhoHPknULg5sAa4Px78nJcitrqcz+6PTUGnxOhAqLMRQDY422mKFsD
kKh9Z85b1UShf1fWzVDg/2ZNp/QOlJZua6xcBLXeO7n+L/qIpRZ8De7u60Djg12E
HiQju7Z9Ulqu+lEKdERSv9qOY1oFY2PI7CkvvVui4IDBON3KaOSOPz2PB1KeIuTu
XbbIIByXAleo1Pl9hlNvHngxOsA3IjjnOFcZi3nOviZhTSzxF3jZadtY6KsTz57S
xxzdnyiitNlKjSEgJxdMLEoHj7DlusHNO0AE/InNEyq8g5N7kG6UOCkBBvDCYwfj
BWrJsLDNz+aCuGlYJ0H866hMcfE44VL/rIl7ZvzBblaPT4hxvuiisb6lhTAje5wu
XXDGtd692SXsBd09b31pES1XhCvAEdz3ONbXWrc7k6bB3TOlH0Oc1FfZz+A5neSO
llC/v1Bi+teBY1PLZlrRRhXXszdBS5eqlkDMpmbUIt4VL4QoWUbuRIHRC30E/E2w
uoIZCrSu2xfa6dm9pHvS
=prYF
-----END PGP SIGNATURE-----

--nextPart3209271.N0x3agoVD5--
