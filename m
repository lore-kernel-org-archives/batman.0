Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 May 2011 09:26:30 +0200
References: <1306534222-11710-1-git-send-email-ordex@autistici.org>
	<201105280020.26937.sven@narfation.org>
	<201105280035.24310.lindner_marek@yahoo.de>
In-Reply-To: <201105280035.24310.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1508403.epJ5qIxlKy";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105280926.32059.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move the ttl field to the
	third position of unicast_* packets
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1508403.epJ5qIxlKy
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> On Saturday 28 May 2011 00:20:21 Sven Eckelmann wrote:
> > >  struct unicast_frag_packet {
> > > =20
> > >       uint8_t  packet_type;
> > >       uint8_t  version;  /* batman version field */
> > >=20
> > > -     uint8_t  dest[6];
> > >=20
> > >       uint8_t  ttl;
> > >=20
> > > +     uint8_t  align;
> > > +     uint8_t  dest[6];
> > >=20
> > >       uint8_t  flags;
> > >=20
> > > +     uint8_t  align;
> > >=20
> > >       uint8_t  orig[6];
> > >       uint16_t seqno;
> > > =20
> > >  } __packed;
> >=20
> > Wait a second - are there two "align" in a single struct. Sry, have to
> > Nack  that one :)
>=20
> Yes, I suggested that because the tt patches will replace the first align
> with the ttvn field.

But it doesn't compile. I cannot forward stuff which is too broken. And=20
personally I don't care who suggested it when my builtin c-parser explodes.

Ok, now I did the "work" to apply and and to compile that stuff to prove my=
=20
point. Here are the slightly shortened results (gcc-4.6 from sid):

  CC [M]  aggregation.o
In file included from types.h:27:0,
                 from main.h:121,
                 from aggregation.c:22:
packet.h:114:11: error: duplicate member =E2=80=98align=E2=80=99
make[2]: *** [aggregation.o] Error 1
make[1]: *** [_module_/batman-adv] Error 2
make[1]: Leaving directory `linux-2.6.39'
make: *** [all] Error 2

My suggestion: Rename the first align in every packet structure to 'reserve=
d'.

Then to the next part which I don't like: the patch forgot to touch=20
batman_packet, icmp_packet, icmp_packet_rr, bcast_packet and vis_packet. It=
=20
doesn't make sense to patch half of the on-wire types to reduce the number =
of=20
COMPAT_VERSIONs.

Kind regards,
	Sven

--nextPart1508403.epJ5qIxlKy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN4KOnAAoJEF2HCgfBJntGKrQQANcirh3O4CDY3qCizBhkKMWc
5veUlSTU5vcXNPwh+n8r1RXxFgKKdx+2yJL1O8y7oSbZpZhSVaxEgeoFZt2l98NO
o64EMFuApplePCEj4aJwY2rpnqaveRMmSW7esm2a3so6fq6EtQRy6WOA3DieriKi
p3eDrSNtirPF0UHOv0kGGgmjsH6aTATeKU7ZB3wVdWYIAwKi/c7b9DW+/GGnSo5K
ejxtcByS+NWqO2AaVQklSsJ0l4ea8B9RBUZ7fndwnQoiR8qjWcnJEPCSfqLpBL0J
m36Eo49HyC2HaBi/zJip1nBd4IraKDpgZdpMrSL21H7tGAkioIG0aAumTeJIHlrU
nZ0gNplrNO0on42sOSDJTLPsTpx6H4A382p17Z6RpQV6adpUdLn1xVYvcRa4BfLp
KT3xXoQfA/fdT7Hs3BUteP5WCHu1f3ZOqEZ7E7qX2K3n5fHU26msQrmv23nSMA+b
wAx2PbF52PCotgvrtOae337a4WOSSsT+sfEsK7F0zw6u2VpnCb7glIg2iUVioewm
t14PG6JNpry/3higTia1y0YVVVyjJPVM8ev4ezKzaOnytdwuw8Ni4ddslpAqY9nF
IqEbhtFtCdoYKbSFx1AeQ7oodljrh0+pU/uiu6vbcWjjXU8k5wMfjlkH0oqEyXbv
6E/dJrDYCfYm0b4yo13k
=A14w
-----END PGP SIGNATURE-----

--nextPart1508403.epJ5qIxlKy--
