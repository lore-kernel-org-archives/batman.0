Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 24 Dec 2009 17:35:29 +0100
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A27301B@RESQNAOEX01.qnao.net>
	<200912241656.56674.lindner_marek@yahoo.de>
	<94CAE17FD1DB4640BF8FF28D61FDFA8A082C7E@RESQNAOEX01.qnao.net>
In-Reply-To: <94CAE17FD1DB4640BF8FF28D61FDFA8A082C7E@RESQNAOEX01.qnao.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart25763204.4exHhHp7mv";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200912241735.47412.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [BULK]  Re:  [BULK]  Re:  can't start batmand
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

--nextPart25763204.4exHhHp7mv
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Conner, Eric wrote:
[...]
> > Now I get a second error
> >
> > Error can't flush routing rules: operation not supported
>=20
> batmand requires the kernel policy routing features enabled.
> How do I go about enabling these features?

It is called "IP: policy routing" and can be found in kernels menuconfig un=
der

=2D> Networking support (NET [=3Dy])                                       =
                                                                           =
                                           =20
  -> Networking options
    -> TCP/IP networking (INET [=3Dy])

The option is called IP_MULTIPLE_TABLES in .config. So just enable it,=20
recompile your kernel, install it and reboot with it.

Best regards,
	Sven

--nextPart25763204.4exHhHp7mv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLM5hRAAoJEF2HCgfBJntG0ggQAKSM3zBUiurLLZ4kb2LlHKCK
9w9FVFgXdCXmGSpJFVE+lSinXbXFMRqr8BqJ5uE1joEM39Yo+POUkyF1w4S82Gco
dgN0P77EP40kM4JcKxDFhnXvRgW+It2tM11fhbf3Sw2Ox/mA2wYglNRiEfUdF1qe
JtHsxfZQxnCvdmapfexfx909+Ykz8f5DiOVOTQk3oc7MmeR56nlAinIIkUP64xPD
tTzfzzF7HAFWK7atFpDZuPIZaPvvDI/cgPTH1vec+B4kOWjn+7Zk8knmKcBWDhpE
nXky3qCSJrkZEF5K6SuBne3HM+1s8YOFqmseAvd/10L0PplTJZCpUGNFowABBYmU
oprhERzHsqQ9umZnQ7S6bGXnee3GOpsL1HTG/3DIM1LXb8CZR1AZ2ChgnCPuUuNO
JzjeE/zriQ6ir/YqvS2U/ErW8y+HWA2eajjdoDEoyAnAR2P5D/O0NmRQ0NFbpYsT
cfybp/3dabv0IgJk+mWG2BJVq1mlVuD+k1BIlTvQ+Doi/S5QLEwB8WCZArFSfqqj
P8mbAcNGhkW28mtceZ/yl1s+xwOqJEqc/TYfpZJleuvzNagKc2c2d+Xwr3ZdYzhq
cUEaDuc+9UIp3Ja1DcUSgjLrGUENnTgV3AGLrb8LdKjx4mY2LBUFhQcBfJWCjTmx
AiJpumUL0pHpx+sXdXKt
=IQCe
-----END PGP SIGNATURE-----

--nextPart25763204.4exHhHp7mv--
