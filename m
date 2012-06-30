Return-Path: <ordex@autistici.org>
Date: Sat, 30 Jun 2012 14:08:42 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120630120842.GA2161@ritirata.org>
References: <1340785387-3821-1-git-send-email-ordex@autistici.org>
	<1340785387-3821-2-git-send-email-ordex@autistici.org>
	<201206301155.25761.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <201206301155.25761.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: add reference counting
 for type batadv_tt_orig_list_entry
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


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 30, 2012 at 11:55:25AM +0200, Marek Lindner wrote:
> On Wednesday, June 27, 2012 10:23:04 Antonio Quartulli wrote:
> > @@ -639,12 +641,17 @@ batadv_tt_global_entry_has_orig(const struct
> > batadv_tt_global_entry *entry, rcu_read_lock();
> >  	head =3D &entry->orig_list;
> >  	hlist_for_each_entry_rcu(tmp_orig_entry, node, head, list) {
> > -		if (tmp_orig_entry->orig_node =3D=3D orig_node) {
> > -			found =3D true;
> > -			break;
> > -		}
> > +		if (tmp_orig_entry->orig_node !=3D orig_node)
> > +			continue;
> > +		if (!atomic_inc_not_zero(&tmp_orig_entry->refcount))
> > +			continue;
> > +
> > +		found =3D true;
> > +		batadv_tt_orig_list_entry_free_ref(tmp_orig_entry);
>=20
> Instead of having this weird increment and immediate decrement this patch=
=20
> should add a general "orig_entry_get" / "orig_entry_find" function like w=
e do=20
> everywhere else. Check the following functions to get an idea:
>  * batadv_primary_if_get_selected()
>  * batadv_orig_node_get_router()
>  * batadv_tt_hash_find()
>=20

Well, actually that is what I implemented in patch 2/4 (ok, I'll fix the
function names to reflect what we already have). In this patch I simply tri=
ed to
implement refcounting without changing too much code.

By the way, I will introduce a get function with this patch directly.

>=20
> > @@ -663,6 +670,7 @@ batadv_tt_global_add_orig_entry(struct
> > batadv_tt_global_entry *tt_global_entry, atomic_inc(&orig_node->tt_size=
);
> >  	orig_entry->orig_node =3D orig_node;
> >  	orig_entry->ttvn =3D ttvn;
> > +	atomic_set(&orig_entry->refcount, 0);
>=20
> This looks extremely broken. We init with 0, never increase the counter a=
nd=20
> when we should free, we decrease first before checking if it is 0 ?
>=20

definitely broken. Will fix it!


Thank you,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/u7EoACgkQpGgxIkP9cwfdJgCeKbVVttTKPMVZur4NUrTH93xZ
EKAAn1bBN4xNEVSYju1TyWUCmAmDkOIs
=92ql
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
