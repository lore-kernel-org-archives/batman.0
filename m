Return-Path: <ordex@autistici.org>
Date: Fri, 16 Aug 2013 08:29:52 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130816062952.GW849@ritirata.org>
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <1376376232-2178-3-git-send-email-ordex@autistici.org>
 <201308161201.36653.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FYef6pHvFBuPZp1D"
Content-Disposition: inline
In-Reply-To: <201308161201.36653.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/9] batman-adv: make struct
 batadv_orig_node algorithm agnostic
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


--FYef6pHvFBuPZp1D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2013 at 12:01:36PM +0800, Marek Lindner wrote:
> On Tuesday, August 13, 2013 14:43:45 Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >=20
> > some of the struct batadv_orig_node members are B.A.T.M.A.N. IV
> > specific and therefore they are moved in a algorithm specific
> > substruct in order to make batadv_orig_node routing algorithm
> > agnostic
> >=20
> > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> > ---
> >  bat_iv_ogm.c | 93
> > ++++++++++++++++++++++++++++++++++++++++++------------------ originator=
=2Ec
> > | 77 ++++++++++++++++++------------------------------- originator.h |  2
> > +-
> >  types.h      | 30 +++++++++++++-------
> >  4 files changed, 114 insertions(+), 88 deletions(-)
> >=20
> > diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> > index a0b11b0..b8114d6 100644
> > --- a/bat_iv_ogm.c
> > +++ b/bat_iv_ogm.c
> > @@ -87,6 +87,42 @@ static uint8_t batadv_ring_buffer_avg(const uint8_t
> > lq_recv[]) return (uint8_t)(sum / count);
> >  }
> >=20
> > +static struct batadv_orig_node *
> > +batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const uint8_t *ad=
dr)
> > +{
> > +	struct batadv_orig_node *orig_node;
> > +	int size;
> > +
> > +	orig_node =3D batadv_orig_hash_find(bat_priv, addr);
> > +	if (orig_node)
> > +		return orig_node;
> > +
> > +	orig_node =3D batadv_orig_node_new(bat_priv, addr);
> > +	if (!orig_node)
> > +		return NULL;
> > +
> > +	spin_lock_init(&orig_node->bat_iv.ogm_cnt_lock);
> > +
> > +	size =3D bat_priv->num_ifaces * sizeof(unsigned long) * BATADV_NUM_WO=
RDS;
> > +	orig_node->bat_iv.bcast_own =3D kzalloc(size, GFP_ATOMIC);
> > +	if (!orig_node->bat_iv.bcast_own)
> > +		goto free_orig_node;
> > +
> > +	size =3D bat_priv->num_ifaces * sizeof(uint8_t);
> > +	orig_node->bat_iv.bcast_own_sum =3D kzalloc(size, GFP_ATOMIC);
> > +	if (!orig_node->bat_iv.bcast_own_sum)
> > +		goto free_bcast_own;
> > +
> > +	return orig_node;
> > +
> > +free_bcast_own:
> > +	kfree(orig_node->bat_iv.bcast_own);
> > +free_orig_node:
> > +	batadv_orig_node_free_ref(orig_node);
> > +
> > +	return NULL;
> > +}
>=20
> Kernel doc ?


yap

>=20
>=20
> > @@ -297,18 +297,13 @@ void batadv_originator_free(struct batadv_priv
> > *bat_priv) /* this function finds or creates an originator entry for the
> > given * address if it does not exits
> >   */
> > -struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv
> > *bat_priv, +struct batadv_orig_node *batadv_orig_node_new(struct
> > batadv_priv *bat_priv, const uint8_t *addr)
>=20
> When you are writing the kernel doc don't forget that you changed the beh=
avior=20
> of this function.

sure

>=20
>=20
> > @@ -356,37 +350,21 @@ struct batadv_orig_node *batadv_get_orig_node(str=
uct
> > batadv_priv *bat_priv, */
> >  	batadv_orig_node_vlan_free_ref(vlan);
> >=20
> > -	size =3D bat_priv->num_ifaces * sizeof(unsigned long) * BATADV_NUM_WO=
RDS;
> > -
> > -	orig_node->bcast_own =3D kzalloc(size, GFP_ATOMIC);
> > -	if (!orig_node->bcast_own)
> > -		goto free_vlan;
> > -
> > -	size =3D bat_priv->num_ifaces * sizeof(uint8_t);
> > -	orig_node->bcast_own_sum =3D kzalloc(size, GFP_ATOMIC);
> > -
> >  	for (i =3D 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
> >  		INIT_HLIST_HEAD(&orig_node->fragments[i].head);
> >  		spin_lock_init(&orig_node->fragments[i].lock);
> >  		orig_node->fragments[i].size =3D 0;
> >  	}
> >=20
> > -	if (!orig_node->bcast_own_sum)
> > -		goto free_bcast_own;
> > -
> >  	hash_added =3D batadv_hash_add(bat_priv->orig_hash, batadv_compare_or=
ig,
> >  				     batadv_choose_orig, orig_node,
> >  				     &orig_node->hash_entry);
> > -	if (hash_added !=3D 0)
> > -		goto free_bcast_own_sum;
> > +	if (hash_added !=3D 0) {
> > +		kfree(orig_node);
> > +		return NULL;
> > +	}
>=20
> Why not go to free_orig_node ?
>=20

dunno :) will do. thanks

> Cheers,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--FYef6pHvFBuPZp1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSDcbgAAoJEADl0hg6qKeOkvgP/A1jqDG049v8IhuDlK7QF3BK
ctdldK2p6llY3v8iA4jZ9E4Qhs8qWbgTafTix9coDUpipjs+0vgp3GtstqLFvnw3
+k485BMp1riQ9DWl3laopRFAc1lrVDJsG73Lq2JiGSbBS/+/NWhXpKCRD4Kqmqun
JECGmld3GI6Nie6BGKelUa4Ds1pljDEVAdN1QuphyEr0LAkbkgkNqd0ztl4GixTr
L3itpqyRKjMPST4DX8V1SdUkPa32i6oZwJXzitFB6vZKtz9xp3Y+6/hj9RBQpj5e
AFhT6GlsC5UU6KzwuWBNOnNUUL/O342NxYVxJGLaa7cT2EsXkuOjBIH5MpHBXuHm
uRvxw0RnU8nyn0g6zlf0fZkkACVU4xSqNtddm6K6g6Cnrf/C1m2U9Wzv00y13MrU
FK3Gq5/M/doERoyya0iyXnNiislkd5AdTAfq8dn3bjmTGsdOHN1+705/wTK9QYRo
k2ANQyMFbUYebipKyrCuLQaMGsG9M+Fe7zJ7fkPRrywHJbzXhoTtmtgV9eLS9Ba1
BuXmUFBGNlziaE82f4fIbNYg+PvRK5qW2X2bHgXfzrEwRpycd9CK7wqPQYzQ9wWv
gsdc+swmSBuGZ5I/W1X62ifVcB1pGJYcjxEI+If+n82DX/kZW9TRa7Er0UORFeAD
qShN1KgMebnJxBDnsys/
=nTFy
-----END PGP SIGNATURE-----

--FYef6pHvFBuPZp1D--
