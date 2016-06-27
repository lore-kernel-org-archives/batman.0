Return-Path: <a@unstable.cc>
Date: Mon, 27 Jun 2016 14:19:59 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160627061959.GB10666@prodigo>
References: <20160612041426.26339-1-a@unstable.cc>
 <1613308.eWzkVEsf7s@bentobox> <20160627023613.GX10666@prodigo>
 <2649945.JKXkXjyaxK@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zb2WCku5UPqpvxO1"
Content-Disposition: inline
In-Reply-To: <2649945.JKXkXjyaxK@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 3/4] batman-adv: B.A.T.M.A.N. V -
 implement GW selection logic
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


--zb2WCku5UPqpvxO1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2016 at 08:19:22AM +0200, Sven Eckelmann wrote:
> On Monday 27 June 2016 10:36:13 Antonio Quartulli wrote:
> > On Mon, Jun 13, 2016 at 01:26:31PM +0200, Sven Eckelmann wrote:
> > > On Sunday 12 June 2016 12:14:25 Antonio Quartulli wrote:
> > > > +       if (orig_throughput < (gw_throughput + threshold))
> > > > +               goto out;
> > >=20
> > > Possible overflow problem in batadv_v_gw_is_eligible. We don't
> > > know what the user will add here and what the gw_throughput is.
> > >=20
> > > We already had a similar problem in the BATMAN_IV gw selection
> > > code which resulted in weird gw selections. See f63c54bba31d
> > > ("batman-adv: Avoid u32 overflow during gateway select").
> >=20
> > Sven, correct me if I am wrong, but in f63c54bba31d we are changing the=
 type of
> > the variables aimed to contain the value computed by the "overflowing"
> > operation, while in this case we have everything in a if condition: sho=
uld the
> > temporary result be implicitly casted to a larger variable as required ?
>=20
> No, it isn't casted to a larger type. Yes, C has some wild casting rules =
but I
> would not be aware of an "help the programmer to avoid overflows" casting
> rule.
>=20
> We had no other idea how to fix it in the mentioned commit. But here we c=
an do
> it without casting to u64.

ok, thanks !

I will modify the patch in the next series.

Cheers,


--=20
Antonio Quartulli

--zb2WCku5UPqpvxO1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXcMWPAAoJEJ4aZjxxc6bKhjsP/j2fylKbfuquL1DLiTlfjRPs
Xw1fMvew/vYPWxwvaoecCLT34iXjXgAyCT8pbJ1UgLnSPveRFKVOy5/7xxRPozlu
/32tgA+rdXTNbtEj0X0E48D4U0qTVYMwFISOKHA9kYFs0nc47CYDE6u5HGkxGxwT
VsvH/tuSV0vtvZcx/e3yi5+FFivZN9U+Yp5h3MBI58WVUSNF/L+/XutL57TVUzyd
NDW0VMT2c4nbyTtzpsXDQsQmfKPIKGP8B1JIO4iAGyFOpJU7EahozF5t8RZG8QlV
h+uWbgrZCqrnGkKdl2UOBwo8EuQfnnUCy1StYxxkNjgYzArAEa1ErDVse4jb32AS
pMCMHGg5qEBfzGJJZYJva5Bi2Um028H3OaziH/R3wfFmiD2R4kXfbtPYTd733X0N
MoWtkXTxhlIOLoPwGqKRh/uIqsOy0CtfM3iFocI/XWwfhQeyM3V447KqrrMJxI77
N/fxBo1MSEYCuJtBup7kQISXlycTs4eEQWE2rTkbUZhcBj9o1QPMtuaWAsE5ixB3
qcGFz7Bdv9xSFz1/m9wT4bsYzP91RmUz9a3AGCKwElyKBFN8nay/hw7WmvISfZ+c
1trrho6Mr0XwNNeWmUN4QbPb/J8U4NS+aQOD47ssGBtwahk3rFBMo1LnFn6nJ80R
Ig7Xr0Y894k9yMktXHQF
=iODe
-----END PGP SIGNATURE-----

--zb2WCku5UPqpvxO1--
