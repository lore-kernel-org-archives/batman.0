Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 13 Aug 2013 08:08:31 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130813060831.GA22149@pandem0nium>
References: <1376224403-2494-1-git-send-email-ordex@autistici.org>
 <1376224403-2494-8-git-send-email-ordex@autistici.org>
 <20130812143129.GB18832@pandem0nium>
 <20130812175102.GK849@ritirata.org>
 <20130812212535.GM849@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20130812212535.GM849@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 7/9] batman-adv: adapt the neighbor
 purging routine to use the new API functions
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


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2013 at 11:25:35PM +0200, Antonio Quartulli wrote:
> On Mon, Aug 12, 2013 at 07:51:02PM +0200, Antonio Quartulli wrote:
> > On Mon, Aug 12, 2013 at 04:31:29PM +0200, Simon Wunderlich wrote:
> > > On Sun, Aug 11, 2013 at 02:33:21PM +0200, Antonio Quartulli wrote:
> > > > From: Antonio Quartulli <antonio@open-mesh.com>
> > > >=20
> > > > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> > > > ---
> > > >  originator.c | 9 ++++++---
> > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/originator.c b/originator.c
> > > > index b3f6910..3ee8806 100644
> > > > --- a/originator.c
> > > > +++ b/originator.c
> > > > @@ -380,6 +380,8 @@ batadv_purge_orig_neighbors(struct batadv_priv =
*bat_priv,
> > > >  	bool neigh_purged =3D false;
> > > >  	unsigned long last_seen;
> > > >  	struct batadv_hard_iface *if_incoming;
> > > > +	struct batadv_algo_ops *bao =3D bat_priv->bat_algo_ops;
> > > > +	uint32_t neigh_metric, best_metric;
> > > > =20
> > > >  	*best_neigh_node =3D NULL;
> > > > =20
> > > > @@ -414,10 +416,11 @@ batadv_purge_orig_neighbors(struct batadv_pri=
v *bat_priv,
> > > >  			batadv_bonding_candidate_del(orig_node, neigh_node);
> > > >  			batadv_neigh_node_free_ref(neigh_node);
> > > >  		} else {
> > > > -			if ((!*best_neigh_node) ||
> > > > -			    (neigh_node->bat_iv.tq_avg >
> > > > -			     (*best_neigh_node)->bat_iv.tq_avg))
> > > > +			neigh_metric =3D bao->bat_metric_get(neigh_node);
> > > > +			if (!*best_neigh_node || (neigh_metric > best_metric)) {
> > >=20
> > > Shouldn't you initialize best_metric at some point?
> >=20
> > Actually I did initialise it with UINT_MAX but I have the feeling I for=
got to
> > "add" the change to the commit. However this is only saving us from a w=
arning
> > (which means the initialisation is needed) but not from any other probl=
em:
> > best_metric will always have a value when best_neigh_node will be not N=
ULL.
> >=20
> > Anyhow, good catch :)
> > Thanks for raising the point.
> >=20
> > Do you think I should send the entire patchset again? Or can I just res=
end this
> > patch only? Marek?
>=20
> Sorry, I was wrong. The initialisation I was talking about is done in
> batadv_find_ifalter_router() (so I did not forgot to add it :-)).
>=20
> Here instead it is not useful at all.

I think we still need an initialisation here. Even my compiler complains. :)

Cheers,
	Simon

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlIJzV8ACgkQrzg/fFk7axbXHQCbBx04Q2i1hCZb9dnpDSITKOry
+HgAn3kVV7csHCbz24VbewrpvVB3y++e
=L2Nr
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
