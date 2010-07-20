Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 20 Jul 2010 21:21:32 +0200
References: <1279291156-5297-2-git-send-email-sven.eckelmann@gmx.de>
	<201007202049.31530.sven.eckelmann@gmx.de>
	<1279652233.2110.51.camel@achroite.uk.solarflarecom.com>
In-Reply-To: <1279652233.2110.51.camel@achroite.uk.solarflarecom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2147075.EQef3IHleA";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201007202121.34348.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] net: Add batman-adv meshing protocol
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
To: Ben Hutchings <bhutchings@solarflare.com>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, siwu@hrz.tu-chemnitz.de, Marek Lindner <lindner_marek@yahoo.de>, David Miller <davem@davemloft.net>, Abraham Arce <abraham.arce.moreno@gmail.com>

--nextPart2147075.EQef3IHleA
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ben Hutchings wrote:
> On Tue, 2010-07-20 at 20:49 +0200, Sven Eckelmann wrote:
> > Abraham Arce wrote:
> > > Minor comments...
> > >=20
> > > 1. Is it ok to have a README in drivers directory? why not moving it
> > > to Documentation/networking?
> >=20
> > Thanks, I will check if Documentation/networking is a better place.
> >=20
> > > 2. Compilation error, one extra arguments passed
> > >=20
> > > - stats =3D (struct net_device_stats *)dev_get_stats(skb->dev, &temp);
> > > + stats =3D (struct net_device_stats *)dev_get_stats(skb->dev, &temp);
> > >=20
> > >   LD      kernel/built-in.o
> > >=20
> > > net/batman-adv/hard-interface.c: In function 'batman_skb_recv':
> > > net/batman-adv/hard-interface.c:482: error: too many arguments to
> > > function 'dev_get_stats'
> > > make[2]: *** [net/batman-adv/hard-interface.o] Error 1
> > > make[2]: *** Waiting for unfinished jobs....
> > > make[1]: *** [net/batman-adv] Error 2
> > > make: *** [net] Error 2
> >=20
> > Do you use linux-next or net-next-2.6? Because this is needed to get it
> > compiled as dev_get_stats was changed some time ago (commit
> > 28172739f0a276eb8d6ca917b3974c2edb036da3), but this is not part of
> > 2.6.35.
>=20
> Even so, that cast is a bug following commit
> 3cfde79c6c7c8002375c4a8e5be7f602fbb9675d.

I've only noticed the changes to the batman-adv code in staging through=20
28172739f0a276eb8d6ca917b3974c2edb036da3, but missed that more is needed wi=
th=20
the above mentioned one. Thanks a lot for the hint.

Best regards,
	Sven

--nextPart2147075.EQef3IHleA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMRfc9AAoJEF2HCgfBJntGNg0QANZS46Fnp6ccSwc5uqQJ0D18
aiHoM/ahsI6oAK5MnsH0Nw+R7+lnL3FMe9UXe4yfaTDWh5hJ/gp9BMV9ySksOeGe
ght/r/0RgO358kt5RTLfJAXnj1UNr4HDvsR/gxUgz2MH5TLPQsstOjRHTDSQlp4w
N8GpZ8p6jfVcj38Tp7LvIhErDZKpnCVK4kR0QTarNXkflyJendB0cBsf0AaHEilY
0ZIWo31Y4kPG3GstOASDGTKxhs1VUErAZJBNoAAgeiGSEb4H79XnHgCZhLT+GixA
PYNx/zDZr5WVD2wkM3UZtH2CEzxuNQO6EAuMw81OLWWjYljlCLTTYGbgRozIa83m
0F5GeSMHnelFVeWE6+gCBTOnBuq4AxZxF5KMZaLwV5liCMZah5gzDjm9ju9xoSFF
jdqg7nUm0De3v9SA04RjG7jYKkCcc9Qjw8a3A9914RtPpYqStfEYxm5qePWFV274
W9/96BreYf1dSHYJe1x6uKIoo3x83AiXTHzVcrKQv+SxaXZ8hYX6Mhqk0fObquUp
+I2+ezGvu8dXTfQ3F1Oeareef6QKUmLdXD7Rqvs6p6LWE/2B8RDVBoeWbRHdIoMB
EIXzNnYn4u6kdV2vbcQWiqq05M+CnrGyT7O6ApeA3CoehdHA/ezez/Rlf3C9YKq0
GR7kWrIphFtTm3+kLTzY
=O5Sp
-----END PGP SIGNATURE-----

--nextPart2147075.EQef3IHleA--
