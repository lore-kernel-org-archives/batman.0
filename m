Return-Path: <ordex@autistici.org>
Date: Sun, 9 Sep 2012 10:43:04 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120909084304.GC5857@ritirata.org>
References: <1346339064-4348-1-git-send-email-ordex@autistici.org>
 <201209091629.58178.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <201209091629.58178.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: roaming re-routing mechanism
 redesign
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


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 09, 2012 at 04:29:57PM +0800, Marek Lindner wrote:
> On Thursday, August 30, 2012 23:04:24 Antonio Quartulli wrote:
> > The roaming re-routing procedure has been slightly revised in order to =
get
> > rid of the tt_poss_change variable that was not clearly representing the
> > node/client states. Now the code directly relies on the TT_CLIENT_ROAM
> > flag that can be set on the involved local/global clients.
>=20
> This seems to explain what another patch is doing ?

uhm, after having dived the two patches I probably forgot to change this. N=
oted.

>=20
>=20
> > - This patch is based on top of:
> >   "batman-adv: substitute tt_poss_change with a per-tt_entry flag"
>=20
> Where is that patch ? I am unable to find it.

yep, was in my queue but I never sent it. done a few minutes ago.

>=20
>=20
> > +static void
> > +batadv_tt_global_del_struct(struct batadv_priv *bat_priv,
> > +			    struct batadv_tt_global_entry *tt_global_entry,
> > +			    const char *message)
>=20
> Can we come up with a better name than batadv_tt_global_del_struct ? "str=
uct"=20
> is a rather generic term.


well, this function is already in the code. I just moved it.
But ok, I'll try to come up with a better idea and send a patch to rename i=
t.

>=20
>=20
> >  void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t
> > *addr, int ifindex)
> >  {
> >  	struct batadv_priv *bat_priv =3D netdev_priv(soft_iface);
> > -	struct batadv_tt_local_entry *tt_local_entry =3D NULL;
> > -	struct batadv_tt_global_entry *tt_global_entry =3D NULL;
> > +	struct batadv_tt_local_entry *tt_local =3D NULL;
> > +	struct batadv_tt_global_entry *tt_global =3D NULL;
>=20
> Please don't mix code changes with renames. That makes it hard to spot ch=
anges=20
> in the behavior. Split these changes.

this was needed because the code change introduced a long line and I had to
shorten the variables name in order to make it checkpatch clean.
I will send a patch to shorten the names first and then resend this patch.

>=20
>=20
> > +		if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
> > +			/* if this client is marked as pending it means that it
> > +			 * was purged out before.
> > +			 */
>=20
> Scratch "out".

ops, thanks.

>=20
>=20
> > +			batadv_dbg(BATADV_DBG_TT, bat_priv,
> > +				   "Readding pending client %pM\n", addr);
>=20
> Can you change it to "Re-adding" ?

sure.

>=20
>=20
> > +		/* if the entry is marked as NEW, it means that the node is not
> > +		 * the original owner of this client (in this orig-interval),
> > +		 * therefore it does need to  eventually send a roaming
> > +		 * advertisement
> > +		 */
> > +		/*if (tt_local->common.flags & BATADV_TT_CLIENT_NEW)
> > +			goto out;*/
>=20
> Dead code ?

yes. I left it there, but I forgot to remote it after the tests.


I will fix all these things and send v2 together with the renaming patches.

Thank you very much.
Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlBMVpgACgkQpGgxIkP9cwf9CgCdHvCujaAdNSvX77p3NYeYDBBV
BL0AnRxTW2IfwtRiJqJUA+QMW8xHpEVC
=LFwZ
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
