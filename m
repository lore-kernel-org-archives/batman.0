Return-Path: <ordex@autistici.org>
Date: Wed, 15 Feb 2012 20:47:08 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120215194707.GB29190@ritirata.org>
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<1328830902-11574-8-git-send-email-ordex@autistici.org>
	<201202102232.01329.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <201202102232.01329.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 7/9] batman-adv: Distributed ARP Table
 - add compile option
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2012 at 10:32:00PM +0800, Marek Lindner wrote:
> On Friday, February 10, 2012 07:41:40 Antonio Quartulli wrote:
> > @@ -23,6 +23,8 @@
> >  export CONFIG_BATMAN_ADV_DEBUG=3Dn
> >  # B.A.T.M.A.N. bridge loop avoidance:
> >  export CONFIG_BATMAN_ADV_BLA=3Dy
> > +# B.A.T.M.A.N. distributed ARP table:
> > +export CONFIG_BATMAN_ADV_DAT=3Dn
>=20
> Any particular reason why you wish to disable it by default ?

It's a new (read experimental) feature. I don't want people that just upgra=
de
their batman-adv package to get this new code without having been asked :-)

This is the only reason for being off by default. But if you think we should
push people to test it....then ok :) I can switch it to true!

> > --- a/hard-interface.c
> > +++ b/hard-interface.c
> > @@ -119,9 +119,11 @@ static void primary_if_update_addr(struct bat_priv
> > *bat_priv, if (!primary_if)
> >  		goto out;
> >=20
> > +#ifdef CONFIG_BATMAN_ADV_DAT
> >  	bat_priv->dht_hash =3D (dat_addr_t)
> >  				choose_orig(primary_if->net_dev->dev_addr,
> >  					    DAT_ADDR_MAX);
> > +#endif
>=20
> A general dat_init()/dat_free() structure would be better than adding def=
ines=20
> everywhere.

ok, so that we can limit defines to dat.c/h and to structure definitions. n=
ice
suggestion :-)

> The README update is missing in this patch.

Good point. Thank you!

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPPAu7AAoJEFMQTLzJFOZFY74IAL2Ji5LAE6yvfeZj+L3Va0bq
a4D0qekZNX18ctIxo1lPe9tFy3yZt6reV0rRXK2DIsQVrtMt92DQNanHkI1GQ7dc
8IDoDCa37hrxX5Gy7l7/RIqXIlgh+/ZNhGVpwwCUV/lpR9TfmUuGMqkGMzx8ktz4
3n8x47KwAMeZTah4U3PSsSs9JRnrVBxSKw7me7YZ/n8cFu/gp09JbVhC3ChgPgLC
ocuGHKcpPq1FieE+cvw3b6Cn0cj2ZgCILQ7jrc8OLjmIHJyMTZMYd2enbDh7VCsI
VSMGGKRaqLx1woUWPJ+DyGO4OljWf9DtY5f6tGiQzFerZviqoMNOOGuoFbxDeCE=
=+9c2
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
