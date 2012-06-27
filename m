Return-Path: <ordex@autistici.org>
Date: Wed, 27 Jun 2012 08:34:05 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120627063404.GE3290@ritirata.org>
References: <1340740822-4516-1-git-send-email-ordex@autistici.org>
	<1340740822-4516-5-git-send-email-ordex@autistici.org>
	<1564568.1LY5lsXFIC@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <1564568.1LY5lsXFIC@sven-laptop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/5] batman-adv: detect not yet announced
 clients
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 11:50:22PM +0200, Sven Eckelmann wrote:
> >=20
> >  	for (i =3D 0; i < hash->size; i++) {
> >  		head =3D &hash->table[i];
> >  		list_lock =3D &hash->list_locks[i];
> >=20
> >  		spin_lock_bh(list_lock);
> > -		batadv_tt_global_roam_purge_list(bat_priv, head);
> > +		hlist_for_each_entry_safe(tt_common_entry, node, node_tmp,
> > +					  head, hash_entry) {
> > +			purge =3D false;
> > +			tt_global =3D container_of(tt_common_entry,
> > +						 struct batadv_tt_global_entry,
> > +						 common);
> > +			if ((tt_global->common.flags & BATADV_TT_CLIENT_ROAM) &&
> > +			    batadv_has_timed_out(tt_global->roam_at,
> > +						 roam_timeout)) {
> > +				purge =3D true;
> > +				msg =3D "Roaming timeout\n";
> > +			}
> > +
> > +			if ((tt_global->common.flags & BATADV_TT_CLIENT_TEMP) &&
> > +			    batadv_has_timed_out(tt_global->common.added_at,
> > +						 temp_timeout)) {
> > +				purge =3D true;
> > +				msg =3D "Temporary client timeout\n";
> > +			}
> > +
> > +			if (!purge)
> > +				continue;
> > +
> > +			batadv_dbg(BATADV_DBG_TT, bat_priv,
> > +				   "Deleting global tt entry (%pM): %s\n",
> > +				   tt_global->common.addr, msg);
> > +
> > +			hlist_del_rcu(node);
> > +			batadv_tt_global_entry_free_ref(tt_global);
> > +		}
> >  		spin_unlock_bh(list_lock);
> >  	}
>=20
> Why writing this whole thing in one function? You don't get a price for t=
he=20
> highest indentation level that banged the hardest against the 80 characte=
r=20
> limit.

Mh, I like challenges :-) However, I'll add another function like:
has_to_be_purged() or similar in which i will check for the conditions and I
will use it only in the loop.


>=20
>=20
> > -	if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM)
> > +	if (tt_common_entry->flags & BATADV_TT_CLIENT_ROAM ||
> > +	    tt_common_entry->flags & BATADV_TT_CLIENT_TEMP)
> >  		return 0;
> >=20
> > +
> >  	tt_global_entry =3D container_of(tt_common_entry,
> >  				       struct batadv_tt_global_entry,
> >  				       common);
>=20
> And this new line doesn't make sense

I agree.


Thank you very much Sven.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/qqVwACgkQpGgxIkP9cwddAwCgku+VvocQuxf2Iusg+Jz13D7Z
ZDEAoJlmQ5IyRR+0wqaRfSOC5D0jlgxp
=Z3ax
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
