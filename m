Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 6 Oct 2009 11:43:04 +0200
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910052324.55426.sven.eckelmann@gmx.de>
	<d9bba8670910060226i3068db6awc4f126c9b6c51b1a@mail.gmail.com>
In-Reply-To: <d9bba8670910060226i3068db6awc4f126c9b6c51b1a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6235866.YzOCrdDzB9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910061143.08021.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv and TCP problem
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

--nextPart6235866.YzOCrdDzB9
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

a wrote:
> It is correct. I'm using openwrt and, at the moment, without -M option.
> 1500byte packets work, with fragmentation.
> However, my TCP packets are small (about 60bytes). I have verified TCPDump
> file and packets arrive. It seems that the Linux IP stack does not forward
> them to the application.
> Moreover, if I disable batman on B1-GW1 link, it works
So it would be a good idea to do what Marek said. Give him a dump with `bat=
ctl=20
td` on the gateway and if I could add something: complete tcpdump of both e=
nds=20
so we can see what packets receive on both sites.

Best regards,
	Sven

--nextPart6235866.YzOCrdDzB9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJKyxEpAAoJEF2HCgfBJntGYVwP/3mENmZwIi34Ly1c1vde07jD
dSM4NZjmDxngV291wjN6hg8xBGmlBYzztAGLG/jDrgI2JMBUKcErzFiucSJ2BS6S
1u2VQgBN8iWEO1Ol+7w4xSru6tqiGRNgNBYa6Hq/iAHBiXy+LweXD9Z61likf+E0
QcTUTrmyKhL87miZnJj2DC6Rgoq8a5KU2eXbPyz3VaPyBvHtSZfhOa60NcHXBRBj
Sh2E5hTKHrnJgg51om+Pw6pZ/F9O13GlfsiAxKLWMgk2a1z5V3tKyNqQSqKLT3li
RYlzrzn8GNgutMjQRjy0aE3WmEdBwoHsTTrQWqDbjwmJ6a93s3H2ZKnQEykN212I
OKucrwp2FFUlI5lx8R168jqCLqc/AaGTgBKHJ8YYA1TIpEYh2P9yATL+PbxtMZ9O
GZ0iwQRqd5Y2JQ90HgcaAKnCiLuHyJH9R70QfWcVWmhMXd8yx/7p4wkEMgGcA4uV
bfpqRPfo3JJDhXdJrs7kLVO0KDK7/JNB2BBbcSJ8DhMyN0R5o4tKd6cZ02fBbL+9
8Tav86+giXagxHnSdAMI06nC2UFMfldxe3XJTakH554wuT0Unlo1KajaHuri+up4
bsAo8JBFLoE3ZOTJ1HBtKm+DB03pMlxdalVh+w+dTEtfcU7Ooinm1Pvi3bhozAuX
KnHe47Gy8loaE3gLr9QU
=8NgT
-----END PGP SIGNATURE-----

--nextPart6235866.YzOCrdDzB9--
