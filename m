Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Jun 2009 22:24:40 +0200
References: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
	<200906200323.44115.sven.eckelmann@gmx.de>
	<5161afcd0906221257m589d5ac3leea3bcd22dd20182@mail.gmail.com>
In-Reply-To: <5161afcd0906221257m589d5ac3leea3bcd22dd20182@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2235395.jBJ48heZZD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200906222224.43917.sven.eckelmann@gmx.de>
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
To: b.a.t.m.a.n@lists.open-mesh.net

--nextPart2235395.jBJ48heZZD
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 22 June 2009 21:57:07 Jacob Marble wrote:
[...]
> > You can also set the mtu on your wifi devices higher (and bat0 devices).
> > So for example wifi device to 1524 and bat0 to 1500 (like the eth
> > devices). Also check if you have bridge mtu patch from Simon[1] (includ=
ed
> > in linux 2.6.27) when you are bridging some of the devices. Also check
> > that icmp "Destination Unreachable" - "Fragmentation required, and DF
> > flag set" isn't filtered anywhere.
[...]
> The Linux workstations are attached via Ethernet, running Ubuntu.
>
> The MTU, by default, is 1500 on eth0, ath0, wifi0
> The MTU, by default, is 1476 on bat0, br-lan
>
> Ping from Linux workstation to Linux workstation works as long as the
> -s flag is 1448 or less.  1448 =3D 1476 - 28
> The -M do doesn't seem to change anything.
>
> HTTP transfers still don't go through when they are larger than ~1400
> bytes.  I'll go play with the MTUs now.
Ok, setting mtu of ath0's to 1524 and of bat0 to 1500 should help here. Jus=
t=20
for the sake of completeness: Is there bridging involved in the workstation=
s=20
or any icmp filtering on the workstations/nanostations?

Regards,
Sven

--nextPart2235395.jBJ48heZZD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKP+iIAAoJEF2HCgfBJntGQmoP/1PWZ/4XF1yYnsGWx84Zr4Xe
aHJ6FqPhbUhQvJwyZlzj+se6nuShCi1Wa5PKNT+D2Wt/VqnAuHXVvZkzoVXsteDE
Pv+iNuNybiYBKMHtd3xyvOpM8AFUKIATOrBmOObxxKXoUMWDhTxHOrc9KGpEPtBE
IQID3U8XxG3bODY0xXqU3XVvi8LF3YgyrVaHAJ4pjkKMULSHQWVnHmlIfK2iOixp
BnSMhZFbKuNHhcjPSXEGSo6ywLxh6CUfafnS4qQLQzNI9wsZf/2/WhqdTRd0Segd
5Mtv+RQUtNmhwKKxO0JxnXnOUNsrM6S1yeC4QmHexsea1OUEua/oUoJM/76pf1xF
9yuuxt39+fdVQpIVAAN5PnuMt0o6Nha72eCICf2ft25gfPBQIBaksJSkRx2nrik3
/VCzYg0Wp8kDq4mx0rm845iNpj30xV00FOPQSlVNAvInSpiXxdVjxp31bq0+qiMf
uzuKgnM32W9i1Hut78G1Bpd1I3dHyQn9MYDSuNNHGAr/ZS85zRcGSUIXBOlbRDiF
so6xIYNrsCb4sUZk4ppOfrlObQ6SgDwk3aKUZL+CVlu/T7y8CfIJcAbJy45xA83d
lXAwUeqrm4XyB49qoo8nY02Uogt1fpVzbXtUy5Vu3VZmzwwx0KbkRLmaoEq1h7CC
oHASghaVjNmFKZHme/TK
=MD4i
-----END PGP SIGNATURE-----

--nextPart2235395.jBJ48heZZD--
