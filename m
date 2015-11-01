Return-Path: <mpa@pengutronix.de>
Date: Sun, 1 Nov 2015 16:35:14 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20151101153514.GB32213@pengutronix.de>
References: <1787438.NkeQ2a2MeO@sven-edge>
 <1446290970-24053-1-git-send-email-sven@narfation.org>
 <20151101151302.GA32213@pengutronix.de>
 <2794351.UgJrBE9pQk@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <2794351.UgJrBE9pQk@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix kerneldoc of main
 functions
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 01, 2015 at 04:32:09PM +0100, Sven Eckelmann wrote:
> On Sunday 01 November 2015 16:13:02 Markus Pargmann wrote:
> > > diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
> > > index 06bab51..3404195 100644
> > > --- a/net/batman-adv/bitarray.c
> > > +++ b/net/batman-adv/bitarray.c
> > > @@ -29,10 +29,16 @@ static void batadv_bitmap_shift_left(unsigned long
> > > *seq_bits, s32 n)>=20
> > >  	bitmap_shift_left(seq_bits, seq_bits, n, BATADV_TQ_LOCAL_WINDOW_SIZ=
E);
> > > =20
> > >  }
> > >=20
> > > -/* receive and process one packet within the sequence number window.
> > > +/**
> > > + * batadv_bit_get_packet - receive and process one packet within the
> > > sequence + *  number window
> >=20
> > Are you sure this works? IIRC some time ago multi line function
> > descriptions were not supported.
>=20
> Yes, it works since 2009 [1,2,3].
>=20
> Here is the kerneldoc (text) output for the function you've quoted:
>=20
>     Name:
>    =20
>     batadv_bit_get_packet - receive and process one packet within the seq=
uence number window

Ok, I am probably mixing it up with something else then. Thanks for
clarifying.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWNjEyAAoJEEpcgKtcEGQQKhAQAJp25OhKRs2vx+8QX3JeUjtl
9p+Mxi98x64ly3J4E6FaxNAWSf3wxRT9jPD0xdgNgJa/mRMmpHKT+NPGVE4MQiKo
MBYxCVIJD75hoaNcAWfhMd1sTZ/VDNu+kBNx/6nz0Ufs5ceZSgajTU4zt7Io90H6
0IMDukB3Db4ERtx9dhuPwyw1eRfgxLB/YD6bCRc6VuUJwxxd1Qpes8Xr7pr6nNUt
Efgv2Um/hMgltMon9idqI7T8/qmZfFFi9SbMxJyyVbiAf+e9BO2gx7VdSIXKXe32
gNMGEPXctL8xpeDmbYhyx4lPJ6UDG/hOA4mpNCvR4EJn+HGXHfp4LBDZFOXgg5qk
H7e+jradQu2pMjvUdsxmKO186L1g3BAFW0i1ZdgCnGzYQaqjiuCPU/WykcGiN/Dc
edD/NfF/Wvw2dG3KWslNlbzdiNU/6W0ykV6SZmlS2nFwy+5wsnl3c+qv+csdfh9/
vE5i0Fe1ALyXefJQMGJMGvB4xd+jS/+AM3aylT7oj8lg9Eb+GaJLJ+PwlqwE+vgG
5EZhv6AhDSTvFgKz15VKeQnva08aIXJIMwLv9z5kRXSd13YvnRaMve5WHEtaawEN
aWLMaITJszREpQgTLAyN8xtcHgxYwFS+gImbmsYMOu/bjpnbKOhY2ahQyb3qDYKp
gjDskB+sEOW52e+lC9gf
=ewt+
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
