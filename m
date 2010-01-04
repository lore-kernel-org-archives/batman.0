Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 4 Jan 2010 19:18:05 +0100
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A273519@RESQNAOEX01.qnao.net>
In-Reply-To: <94CAE17FD1DB4640BF8FF28D61FDFA8A273519@RESQNAOEX01.qnao.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1482371.I4AsOcxNN9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001041918.08130.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] sha256 for batmand advanced
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
Cc: "Conner, Eric" <Eric.Conner@qinetiq-na.com>

--nextPart1482371.I4AsOcxNN9
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Conner, Eric wrote:
> Does anyone have a sha256 for batmand-adv-kernelland-0.2.tar.gz?

What do you mean by "have"? I can calculate it quite easily[1] and Debian=20
includes it for example in .changes and .dsc files[2] (just renamed to batm=
an-
adv-kernelland_0.2.orig.tar.gz).

Or do you want to say that Simon should change his gnupg key and config to=
=20
generate sha2 checksums[3] even if he uses dsa[6], because sha1[4] and md5[=
5]=20
becoming more and more attack-able?

Best regards,
	Sven

[1] http://www.gnu.org/software/coreutils/manual/html_node/sha2-utilities.h=
tml
[2] http://lists.debian.org/debian-devel-changes/2009/11/msg00786.html
[3] http://www.debian-administration.org/users/dkg/weblog/48
[4] http://eurocrypt2009rump.cr.yp.to/837a0a8086fa6ca714249409ddfae43d.pdf
[5] http://www.schneier.com/blog/archives/2008/12/forging_ssl_cer.html
[6] http://lists.gnupg.org/pipermail/gnupg-devel/2009-May/025080.html

--nextPart1482371.I4AsOcxNN9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLQjDdAAoJEF2HCgfBJntGvPMQALcZsypXKpOcEYQzzwKCepZZ
vRCkV4v1CxMzVtq58md30LfXjHLRBrBKlcYBLB2Gk4q7UrdLIDTlkmG20pVWmFsb
s/uephMGJH8JIsz+rSqqCOn4ETxJGWIMd/pvEjBLT91Wj0kCRrS6nb9Dp5Ik5ZgB
msKO8Ftruj9hLPomlwWx562qDLTeLvXsSuyIlQ0zZ3FvKxs5Mum+REZP0+4IC1W0
0YdU0N2NJR8SxohyQPLDgyDipv2jPjpjPHUegt26IJwNNlUmFxPRCNad41L9u6pf
05nMA09pYhNAzf66sdl4e7fyvInp76hr2agvpWfniqqJHe35qUkscUzK4U9OaU4M
vskochLUAk5Q2efAsdCXGVkdp9wP9HWUPJGCDpoOMeZCfVOolCkZryVXbfSQn0lI
FzyMwWKSJE7RVUSggMZ2XpeD6wiLxsd6SuYqPnue1RXtjUPVRTCgqywHtB28jZ8k
vPT7uuDaOvasskeVwyh9atSAPCF4st5KCeD4HJ0GBfjLQYnPek7NYFbIIGU/71oo
lozeiJJCx8JDRfHENC3Z/HmzCX8S1x0vVLTCSYl9/lj+KB9YPOd3SCw88A/ohGu1
ifaBo0nwZYWC4zrE44tr5OBZbDiIUKbeXTFSO2WNrNVCkHLLvdM6W/aGEH7kTzcj
HDIl6Yr5/S/gIKuqcweV
=qbxY
-----END PGP SIGNATURE-----

--nextPart1482371.I4AsOcxNN9--
