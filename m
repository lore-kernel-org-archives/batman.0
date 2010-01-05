Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 5 Jan 2010 15:06:42 +0100
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A273698@RESQNAOEX01.qnao.net>
In-Reply-To: <94CAE17FD1DB4640BF8FF28D61FDFA8A273698@RESQNAOEX01.qnao.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1408183.6A2MOAx2Vh";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001051506.45679.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman adv to batmand
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1408183.6A2MOAx2Vh
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Conner, Eric wrote:
> Can batman adv nodes see batmand nodes and vice versa?

What do you mean by "see"? batman-adv and B.A.T.M.A.N. Layer 3 stuff operat=
es=20
on complete different layers. So don't expect a batmand-only node to pop up=
 in=20
/proc/net/batman-adv/originators of an batman-adv-only node.

But they can coexist when switched/routed/tunneled/... correctly. So they c=
an=20
see and reach each other using some other techniques. You can also run batm=
and=20
over batman-adv... even if I don't see a real good example were this would =
be=20
recommended.

Best regards,
	Sven

--nextPart1408183.6A2MOAx2Vh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLQ0dzAAoJEF2HCgfBJntGLhAQAIkU4ZojU/I5rrKVPYB6ZROV
B2WDrXHlSo4ZkXksL269YAyvC+QtGwYzlbavyWO/vyh8+Hh/+TY3/2eGndabA8jp
D9NjtU4/zYbqOqhx9/T/pMyG+PZuCXE+kmAZnYHEvWpd4LwG29j0tJmoAEsr7kOD
r3u5NjUGYimC8+2arIApW36jGcgXhFp960/Sc28NMK6wG4v3aolaaJallIoNXqQP
gcZN7pkN9EKIIF0HHEqFSvivl9KElx+PeXHnkX42lZaP+VmbK4zCLHkrudi+DnAM
xCQWcBwS2TiDCKU6sjF3dvGN0w+UwDLRnArf81GTx72ny1sFEyZNAaX/XDlaC85F
5PqvGRUPDsV4Yq/F9d+AiGV1dwfmx3zVndmD5iPaXJo3KT6fu580Fze+9ir8sSQI
qSVZwW6M8zVmg4UPskrwieCKIx/EZIdnn8CRNwImcYnxtxj6ahfjRBfoOfS+Y1YA
XRbZA+eVp2csvHizF6JpRFHeMEef/GmZQ8Rrjtz+3nCSCSH9s8+XocKgtf84dGJH
x1mP3m0DHHrN0UY+O+n8SYVKr9k+hLinXeua4pgdQUO7tT5xTTU9KQeVgtSv2Dqc
YOH51N8nwciPX33iiubFokj7h3MmFnDtGDWe7khAaXYPh8PXS0R2Oql/KCssESDg
l+0wimhi8w4GVMTlzLvo
=GyRR
-----END PGP SIGNATURE-----

--nextPart1408183.6A2MOAx2Vh--
