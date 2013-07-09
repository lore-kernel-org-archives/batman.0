Return-Path: <ordex@autistici.org>
Date: Tue, 9 Jul 2013 19:22:53 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130709172253.GC1500@ritirata.org>
References: <1372869216-2514-1-git-send-email-ordex@autistici.org>
 <201307041707.05262.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <201307041707.05262.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5] batman-adv: make the TT CRC logic VLAN
 specific
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


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 05:07:05PM +0800, Marek Lindner wrote:
> >  /**
> > + * batadv_tt_prepare_tvlv_global_data - prepare the TVLV TT header to =
send
> > + *  within a TT Response directed to another node
> > + * @orig_node: originator for which the TT data has to be prepared
> > + * @tt_data: uninitialised pointer to the address of the TVLV buffer
> > + * @tt_len: space to reserve for the TT entries. If negative, this
> > function will + *  allocate as much space is needed for the full table
> > + *
> > + * Allocate the needed amount of memory for the entire TT TVLV and wri=
te
> > its + * header made up by one tvlv_tt_data object and a series of
> > tvlv_tt_vlan_data + * objects, one per active VLAN served by the
> > originator node.
> > + *
> > + * Return the size of the allocated buffer or 0 in case of failure.
> > + */
> > +static uint16_t
> > +batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
> > +				   struct batadv_tvlv_tt_data **tt_data,
> > +				   int32_t tt_len)
> > +{
> > +	struct batadv_tvlv_tt_vlan_data *tt_vlan;
> > +	struct batadv_orig_node_vlan *vlan;
> > +	uint16_t num_vlan =3D 0, num_entries =3D 0;
> > +
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
> > +		num_vlan++;
> > +		num_entries +=3D atomic_read(&vlan->tt.num_entries);
> > +	}
> > +
> > +	/* if tt_len is negative, allocate the space needed by the full table=
 */
> > +	if (tt_len < 0)
> > +		tt_len =3D batadv_tt_len(num_entries);
> > +
> > +	tt_len +=3D sizeof(**tt_data);
> > +	tt_len +=3D sizeof(*tt_vlan) * num_vlan;
> > +
> > +	*tt_data =3D kmalloc(tt_len, GFP_ATOMIC);
> > +	if (!*tt_data) {
> > +		tt_len =3D 0;
> > +		goto out;
> > +	}
> > +
> > +	(*tt_data)->flags =3D BATADV_NO_FLAGS;
> > +	(*tt_data)->ttvn =3D atomic_read(&orig_node->last_ttvn);
> > +	(*tt_data)->num_vlan =3D htons(num_vlan);
> > +
> > +	tt_vlan =3D (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
> > +	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
> > +		tt_vlan->vid =3D htons(vlan->vid);
> > +		tt_vlan->crc =3D htonl(vlan->tt.crc);
> > +
> > +		tt_vlan++;
> > +	}
> > +out:
> > +	rcu_read_unlock();
> > +	return tt_len;
> > +}
>=20
> Are you certain this is race condition free ? What if local or global nod=
e is=20
> added while this function is running ?

there is no problem because of the rcu_read_lock/unlock.
The only problem I see is that we may have changes to orig_node which happen
after executing this function and before filling the tvlv.

The tvlv may contain not consistent data (crc not corresponding to the data
being sent). This will be handled by another recovery procedure which will =
aim
to recover the correct state.

Is this acceptable? Actually we already have this "problem" in the current
implementation.


>=20
>=20
> > +/**
> >   * batadv_tt_tvlv_container_update - update the translation table tvlv
> > container *  after local tt changes have been committed
> >   * @bat_priv: the bat priv with all the soft interface information
> > @@ -473,10 +679,11 @@ static void batadv_tt_tvlv_container_update(struct
> > batadv_priv *bat_priv) struct batadv_tt_change_node *entry, *safe;
> >  	struct batadv_tvlv_tt_data *tt_data;
> >  	struct batadv_tvlv_tt_change *tt_change;
> > -	int tt_diff_len =3D 0, tt_change_len =3D 0;
> > +	int tt_diff_len, tt_change_len =3D 0;
> >  	int tt_diff_entries_num =3D 0, tt_diff_entries_count =3D 0;
> > +	uint16_t tt_len, change_offset;
> >=20
> > -	tt_diff_len +=3D batadv_tt_len(atomic_read(&bat_priv->tt.local_change=
s));
> > +	tt_diff_len =3D batadv_tt_len(atomic_read(&bat_priv->tt.local_changes=
));
> >=20
> >  	/* if we have too many changes for one packet don't send any
> >  	 * and wait for the tt table request which will be fragmented
> > @@ -484,13 +691,16 @@ static void batadv_tt_tvlv_container_update(struct
> > batadv_priv *bat_priv) if (tt_diff_len > bat_priv->soft_iface->mtu)
> >  		tt_diff_len =3D 0;
> >=20
> > -	tt_data =3D kzalloc(sizeof(*tt_data) + tt_diff_len, GFP_ATOMIC);
> > -	if (!tt_data)
> > +	tt_len =3D batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
> > +						   tt_diff_len);
> > +	if (!tt_len)
> >  		return;
> >=20
> >  	tt_data->flags =3D BATADV_TT_OGM_DIFF;
> > -	tt_data->ttvn =3D atomic_read(&bat_priv->tt.vn);
> > -	tt_data->crc =3D htonl(bat_priv->tt.local_crc);
>=20
> If you avoided this removal you could have one function instead of=20
> batadv_tt_prepare_tvlv_local_data() and batadv_tt_prepare_tvlv_global_dat=
a()=20
> doing basically the same thing.

uhm, i did not get this. we have several CRCs now, that is why I deleted th=
is
line and why I provided the prepare* functions. Doing it in a generic way (=
for
both local and global node) would probably be not easy..

Thanks:)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR3EbtAAoJEADl0hg6qKeOnrkQAJECgxNlCvRdDYtc9ZvXtwDS
YMMZPPIiAZOTTihUniqxsgdEGXXNFqqydkq61/Qe2cPj8XyEgxMweIyPVFxuRhgb
E7rxOqVfJhNblQFKdAKwQViqVlCm0iPTzScfV87E79TlWm6eW4XlT4RwTzllRbYv
cgQpp4WhPtig85veoOljO/da2YEIhZJsSTOnbfgp+Zi5pHpj4cMF+idib/7os7fl
hrgZo+aMhVXuUjAVOnvbohZxR/UsVWW8lFsnkV/0TFMt1F1As+Kvcl/X+DgcsD4v
05mkPyPOtLT4g0Pau5x825CJTbJc2y9oY3u+X94xhl69W1N77h68hU9UR86l3PWA
QlLtv9HKqXGZ9zu0uEbY7nldbp6YwSpb4Nf4hN5YukiqHCACCyYCiaqXWX2mhDU3
6xYCbs4Dst0hen0LjTHmco6CR4nOkeBcVtC5mCKHofHVSwCSQQvBv8bvaO/Mca2M
oBJ1gBA7sKr1QdGI5EKghegq4f2wMJuo+XvnKUhspXnwFboTQ3YNBiOD3K8FLJcs
eGxbQfessqaL/5z+pve7Ik3iOwwjT28xuvzdJMKLG+7u4Z9rgVk+u1+D3z48KU97
mlXSTQZvorpptTTBP07FR+7d0qV9boMceT0KXymLGAk8iTwLotl5JPWMNehT/xmv
inalR167EaxZPgLTJTbN
=ZKK5
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
