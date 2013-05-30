Return-Path: <ordex@autistici.org>
Date: Thu, 30 May 2013 13:29:20 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130530112920.GB2475@ritirata.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <1369779649-2537-10-git-send-email-ordex@autistici.org>
 <20130529143221.GD23657@pandem0nium>
 <20130529144817.GS3333@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20130529144817.GS3333@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [RFC 08/10] batman-adv: adapt the gateway
 feature to use the new API functions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 04:48:17PM +0200, Antonio Quartulli wrote:
> On Wed, May 29, 2013 at 04:32:21PM +0200, Simon Wunderlich wrote:
> > On Wed, May 29, 2013 at 12:20:48AM +0200, Antonio Quartulli wrote:

[...]

> > =20
> > >  	gw_divisor =3D BATADV_TQ_LOCAL_WINDOW_SIZE * BATADV_TQ_LOCAL_WINDOW=
_SIZE;
> > >  	gw_divisor *=3D 64;
> > > @@ -137,18 +137,19 @@ batadv_gw_get_best_gw_node(struct batadv_priv *=
bat_priv)
> > >  		if (!atomic_inc_not_zero(&gw_node->refcount))
> > >  			goto next;
> > > =20
> > > -		tq_avg =3D router->bat_iv.tq_avg;
> > > +		metric =3D bao->bat_metric_get(router);
> > > =20
> > >  		switch (atomic_read(&bat_priv->gw_sel_class)) {
> > >  		case 1: /* fast connection */
> > > -			tmp_gw_factor =3D tq_avg * tq_avg;
> > > +			tmp_gw_factor =3D metric * metric;
> >=20
> > Hmm, that is rather strange ... I think fiddling with the metric direct=
ly
> > this way is weird when abstracting. For example:
> >  1.) Assuming we don't know how the metric looks like, we can't just
> >      multiplicate them. A logarithmic scaled metric or even arbritrary
> >      metric would look different compared to the linear metrics as we
> >      use now.
> >  2.) This might overflow because metric is u32 and tmp_gw_factor is too.
> >      It should work for batman IV where the metric is <256, but might
> >      not for BATMAN V.
> >=20
> > I think this "bandwidth magic" should be abstracted as well somehow, if
> > we want to keep on using it that way.
>=20
> I totally agree. Thanks for your feedback, but I don't really know how I =
could
> abstract this behaviour. This is totally GW related, but hardcoded around=
 the
> metric semantic. here we would need a routing API that should be implemen=
ted by
> the GW component....mhhh..suggestions? :D
>=20

After discussing with Marek on IRC, we agreed that it is probably better to
leave this part of the code untouched.

It has to be rearranged when implementing the new GW logic discussed at WBM=
v6
and therefore does not really need to be made protocol agnostic now.



Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRpzgQAAoJEADl0hg6qKeOGnIP/0MjJc+sQFKT0DVSWdQHKzn6
Gf2o2h+Z2BB/wqug19Cl/EPp8qoALKgPX825hAvCBrBRgPID3fpaX1swyQSLDIFf
UytZ5wUi0QP2IP2bpYSQxSzzmf6+UGauAAn37dLnUeWfss2JcbobM8NX21cHEnXS
G01wd03bHA3P28Bc8wZuIhpFM916PT/CUqlNa07BhbbJsYAhCAW/b6yqW5xCYilq
WGzduoR/wTRLowrMyssMQqA7B3BsoLcCYHi8mORiXroMrkeOG2MdDdi5USI0JJxx
H3E6TeHbMcz655TgHpq6IiAh3drPk6jp4rBkv05LPnh0KvA58zqWX7YdVUkt+wbC
jrNa/etYbO9fGPur2oZojlvG+K1BReTrMSN4eWHLMSeGBZApjdCjaC3ATtR1YnEc
b5Zz2TR6VxvMdpakyKRniOWnccvvGHmh68N7IVI75yiWUC3fO6LFBURFkpCWGDgT
HVqoAosvhFkmeUy/t3DuCd7CwxB4SBQtMH48zGJuAsplutdptMhxaDmChlm31PqY
18Q+3Gzb1J7oRREnK3gkQ1yLH0TGH9YEeNPbXRhhdmUArG7N8kw7dma+QYQEqzXK
Vb6QOAswsiZZMm5pjou7G7/6ImtRH8ThEPlrn1yw2xVnuLANHnDSH8WL2Otyn08m
SG4+RTa2YKVWY+LRLKtf
=nX9Q
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
