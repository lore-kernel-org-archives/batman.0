Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 2 Nov 2011 20:23:37 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111102192337.GA14901@pandem0nium>
References: <1320226969-6117-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<20111102101354.GA5599@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20111102101354.GA5599@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: check return value for
 hash_add()
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 02, 2011 at 11:13:57AM +0100, Antonio Quartulli wrote:
> Hello Simon,
>=20
> On Wed, Nov 02, 2011 at 10:42:49 +0100, Simon Wunderlich wrote:
> > if hash_add() fails, we should remove the structure to avoid memory
> > leaks.
> >=20
> > Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> > ---
> > As this was the last unchecked occurence, this should close bug #136
> > in the open-mesh.org redmine bugtracker.
> > ---
> >  translation-table.c |   22 ++++++++++++++++++----
> >  1 files changed, 18 insertions(+), 4 deletions(-)
> >=20
> > @@ -217,16 +218,22 @@ void tt_local_add(struct net_device *soft_iface, =
const uint8_t *addr,
> > -	hash_add(bat_priv->tt_local_hash, compare_tt, choose_orig,
> > +	hash_added =3D hash_add(bat_priv->tt_local_hash, compare_tt, choose_o=
rig,
> >  		 &tt_local_entry->common, &tt_local_entry->common.hash_entry);
>=20
> In my opinion you should indent this invocation a bit better :-P
>=20

OK

> > =20
> > +	if (unlikely(!hash_added)) {
> > +		/* remove the reference for the hash */
> > +		tt_local_entry_free_ref(tt_local_entry);
> > +		goto out;
> > +	}
> > +
> > +	tt_local_event(bat_priv, addr, tt_local_entry->common.flags);
> > +
>=20
> Here you are invoking tt_local_event() _after_ setting the TT_CLIENT_NEW.=
 This
> means that this flag is going to be copied in the tt_change structure and=
 later
> it will be sent out within the next OGM. This has to not happen. Therefor=
e I would
> move the or-assignment of the TT_CLIENT_NEW flag _after_ the invocation of
> tt_local_event().
>=20
>=20

OK, i will move it.
> >  	/* remove address from global hash if present */
> >  	tt_global_entry =3D tt_global_hash_find(bat_priv, addr);
> > =20
> > @@ -499,6 +506,7 @@ int tt_global_add(struct bat_priv *bat_priv, struct=
 orig_node *orig_node,
> >  	struct tt_global_entry *tt_global_entry;
> >  	struct orig_node *orig_node_tmp;
> >  	int ret =3D 0;
> > +	int hash_added;
> > =20
> >  	tt_global_entry =3D tt_global_hash_find(bat_priv, tt_addr);
> > =20
> > @@ -518,9 +526,15 @@ int tt_global_add(struct bat_priv *bat_priv, struc=
t orig_node *orig_node,
> >  		tt_global_entry->ttvn =3D ttvn;
> >  		tt_global_entry->roam_at =3D 0;
> > =20
> > -		hash_add(bat_priv->tt_global_hash, compare_tt,
> > +		hash_added =3D hash_add(bat_priv->tt_global_hash, compare_tt,
> >  			 choose_orig, &tt_global_entry->common,
> >  			 &tt_global_entry->common.hash_entry);
> > +
> > +		if (unlikely(!hash_added)) {
> > +			/* remove the reference for the hash */
> > +			tt_global_entry_free_ref(tt_global_entry);
> > +			goto out;
> > +		}
>=20
> In this case the global client could be a roaming one....what about invok=
ing
> tt_local_remove() first? Otherwise we would still have a local client whi=
ch is
> actually not one of ours..What do you think? Moreover it would free some =
space

Sure, we can do that.

I'll send a v2 patch in a minute ...

thanks
	Simon

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6xmLkACgkQrzg/fFk7axZKqQCfY7IuyOjH9441k3RSzvujnrQ6
bacAn3ZKwYQnEq9x6xbhOK7D4CnLy/M1
=sFBO
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
