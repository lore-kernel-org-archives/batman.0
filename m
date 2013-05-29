Return-Path: <ordex@autistici.org>
Date: Wed, 29 May 2013 16:48:17 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130529144817.GS3333@ritirata.org>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <1369779649-2537-10-git-send-email-ordex@autistici.org>
 <20130529143221.GD23657@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O7Os1+MGCLLi8F5z"
Content-Disposition: inline
In-Reply-To: <20130529143221.GD23657@pandem0nium>
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


--O7Os1+MGCLLi8F5z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 04:32:21PM +0200, Simon Wunderlich wrote:
> On Wed, May 29, 2013 at 12:20:48AM +0200, Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> > ---
> >  gateway_client.c | 74 +++++++++++++++++++++++++++++++-----------------=
--------
> >  main.h           |  1 +
> >  2 files changed, 42 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/gateway_client.c b/gateway_client.c
> > index 69488b2..0a9f1d0 100644
> > --- a/gateway_client.c
> > +++ b/gateway_client.c
> > @@ -113,13 +113,13 @@ void batadv_gw_deselect(struct batadv_priv *bat_p=
riv)
> >  static struct batadv_gw_node *
> >  batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
> >  {
> > -	struct batadv_neigh_node *router;
> > +	struct batadv_algo_ops *bao =3D bat_priv->bat_algo_ops;
> >  	struct batadv_gw_node *gw_node, *curr_gw =3D NULL;
> >  	uint32_t max_gw_factor =3D 0, tmp_gw_factor =3D 0;
> > -	uint32_t gw_divisor;
> > -	uint8_t max_tq =3D 0;
> > -	uint8_t tq_avg;
> >  	struct batadv_orig_node *orig_node;
> > +	struct batadv_neigh_node *router;
> > +	uint32_t metric, max_metric =3D 0;
> > +	uint32_t gw_divisor;
> > =20
> >  	gw_divisor =3D BATADV_TQ_LOCAL_WINDOW_SIZE * BATADV_TQ_LOCAL_WINDOW_S=
IZE;
> >  	gw_divisor *=3D 64;
> > @@ -137,18 +137,19 @@ batadv_gw_get_best_gw_node(struct batadv_priv *ba=
t_priv)
> >  		if (!atomic_inc_not_zero(&gw_node->refcount))
> >  			goto next;
> > =20
> > -		tq_avg =3D router->bat_iv.tq_avg;
> > +		metric =3D bao->bat_metric_get(router);
> > =20
> >  		switch (atomic_read(&bat_priv->gw_sel_class)) {
> >  		case 1: /* fast connection */
> > -			tmp_gw_factor =3D tq_avg * tq_avg;
> > +			tmp_gw_factor =3D metric * metric;
>=20
> Hmm, that is rather strange ... I think fiddling with the metric directly
> this way is weird when abstracting. For example:
>  1.) Assuming we don't know how the metric looks like, we can't just
>      multiplicate them. A logarithmic scaled metric or even arbritrary
>      metric would look different compared to the linear metrics as we
>      use now.
>  2.) This might overflow because metric is u32 and tmp_gw_factor is too.
>      It should work for batman IV where the metric is <256, but might
>      not for BATMAN V.
>=20
> I think this "bandwidth magic" should be abstracted as well somehow, if
> we want to keep on using it that way.

I totally agree. Thanks for your feedback, but I don't really know how I co=
uld
abstract this behaviour. This is totally GW related, but hardcoded around t=
he
metric semantic. here we would need a routing API that should be implemente=
d by
the GW component....mhhh..suggestions? :D

[...]

> > =20
> > -	if (curr_tq_avg - neigh_old->bat_iv.tq_avg > BATADV_GW_THRESHOLD)
> > +	if (bao->bat_metric_is_similar(bao->bat_metric_get(neigh_old),
> > +				       curr_metric))
> >  		out_of_range =3D true;
>=20
> Hmm ... if you add the abs for metric_is_similar as suggested for the pat=
ch introducing
> the function, this one would fail. For BATMAN IV, curr_metric would be 0x=
ffffffff and
> the neigh_old would be something < 256, making this function fail for the=
 BATADV_GW_MODE_SERVER
> case.=20

mh I see. the problem is in the max value being wrong for the TQ metric....=
mh we
have to think about that.

>=20
> Actually BATADV_GW_MODE_SERVER could just set out_of_range and goto out, =
I don't understand
> the purpose of this "artificially setting the tq towards ourself" is good=
 for.

This behaviour has been introduced to avoid killing client connections while
they are roaming from node to node. As I explained on IRC this is the wanted
behaviour.

Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--O7Os1+MGCLLi8F5z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRphUxAAoJEADl0hg6qKeOBKwP/R2zOr6NmK6RDACKvIsxPlRM
2+F+s5FLvLTMsGpjXaH++yiEw/61aw/OH9KFU5PKRbjN1cs8mquUAwr5HrC/pTcp
2I9lHX6UZlrVInglHMJ18PMkL16ldL9/uh0AnUkBxSGHNOykFxfZd/XjTtEoQ7SB
Yi7N1jlXbLR8Akrqn62qsuFw9Oxb/a7HgYkYS3m6827gMOLo74tGL9N5vLY08TyT
TXBlKW3KZS5gwUvM/Xxeagt8v2NLmBTEQ6oMgIs7OsRTmwoOLZlXMwLt+fqVaapU
bztOVSW4+EFyCxDie73/siAaHUFOeRGomdSEYjzCMLMC8YzXg5in21HV3Xk96JSS
lyrIvX8vpGihW7mrCiMH1z9flW0nDzLtBqiVuONyJmhO/YT5tSDH9vLOV6SgTMX7
IDpw90Re3gAUaz9316pMAIrVbXfrz/iRyxMucQ+U4JiFPAP5j+wzqAtSY1oj7uHG
m5cTm84QWF+WKt99M9dqL00EyaJ7VsP4kWOMXMcUIVfH3XLwtdgH4f2UmaZMj05e
P7NJQVau9ALJ/ugCEruYHmytF2tkrYPvcuspUh9K/9nvlC2b6ARNH7r4Q3fxxbAb
itAkzoZOTmzADcHcIQX0V6oK0+0tIzAJ//f2dyvPh9r+0WFBp/TaZTHwJRJnog+F
B8gP/Xe0RTi/r21ggIb9
=w+v5
-----END PGP SIGNATURE-----

--O7Os1+MGCLLi8F5z--
