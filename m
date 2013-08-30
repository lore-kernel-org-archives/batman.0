Return-Path: <ordex@autistici.org>
Date: Fri, 30 Aug 2013 23:28:11 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130830212811.GQ2896@ritirata.org>
References: <1377723291-3335-1-git-send-email-ordex@autistici.org>
 <1377723291-3335-2-git-send-email-ordex@autistici.org>
 <201308301220.01356.lindner_marek@yahoo.de>
 <20130830212234.GP2896@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ugCSa1rMkiCAmd9S"
Content-Disposition: inline
In-Reply-To: <20130830212234.GP2896@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 1/9] batman-adv: make struct
 batadv_neigh_node algorithm agnostic
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


--ugCSa1rMkiCAmd9S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2013 at 11:22:34PM +0200, Antonio Quartulli wrote:
> On Fri, Aug 30, 2013 at 12:20:01PM +0800, Marek Lindner wrote:
> > On Thursday, August 29, 2013 04:54:43 Antonio Quartulli wrote:
> > > -	INIT_HLIST_NODE(&neigh_node->list);
> > > -
> > >  	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
> > > -	spin_lock_init(&neigh_node->lq_update_lock);
> > > +	neigh_node->if_incoming =3D hard_iface;
> > > +	neigh_node->orig_node =3D orig_node;
> > > +
> > > +	spin_lock_bh(&orig_node->neigh_list_lock);
> > > +	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
> > > +	spin_unlock_bh(&orig_node->neigh_list_lock);
> > > +
> > > +	INIT_LIST_HEAD(&neigh_node->bonding_list);
> > >=20
> > >  	/* extra reference for return */
> > >  	atomic_set(&neigh_node->refcount, 2);
> > >=20
> > > -	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > > -		   "Creating new neighbor %pM on interface %s\n", neigh_addr,
> > > -		   hard_iface->net_dev->name);
> > > -
> >=20
> > The init problem remains unresolved ?
>=20
> Could you be more specific and tell me which fields are not properly
> initialised?

maybe you were taking about neigh_node->list ? actually that may be missing=
 and
we don't know if this neigh_noe is going to be immediately added to a list.=
=2Eso
better to initialise it.



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--ugCSa1rMkiCAmd9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSIQ5rAAoJEADl0hg6qKeOMLcP/iu5HA9e1NyFDKhvquLPrcfB
LvIDsEtQudASIQr071E1cO40b66aduOizaQrmlBa9Rk+tFOJLfGsZECCvBRUSjaN
3fyJbtT0k/LGTlQPERHWf3NxhTcopdlaayyeOE4EVkJn8EKJau9cI+4nVhxhc2ns
h6YARuO3I6j/QUEtwhcbJTYZc2LB2hn72wNSKyQqv+cJ1Yf59vQ+NWjrb/lg8Ifi
5/ToDKqR0wwApuW8h7a9aYoq6cL92n4g7qG9ejoMhncevVwA6r0/R7TEbEBnSJtH
0snm9iyLXkr2C4hpAaVwR5CFCFk4yJwPhTsjNoHIjm1UNoAxfnjc2owtC4rOBNo4
HuqsmBI3n/OHNxz0siO5pbLL/U6lnf9RWGDcSvotJs9fOhng0vVZJCnLsU6C8+pG
pqlHJ4VNs0KJaXanRFnzHmYf2ggssywfXk3Qq+H7pd7cp2uN6qShqidfvsCPvHud
ZgTn+mIzkP5BztshvCVHDFzulXGOKc6esbceCM+qqr7KZs9Z6yWzl8lQ3cUZL1r3
Qtavo8bfYIUNO7dpRniE8NgndUsLCH59zHspLImcXvKFX0vyTTMFWBvsqENrTv6G
C/jfGlXjuBziL0yqTbxMbECjWn0cRzPyP3a4KaK6dbK0So4/hpms6EtaO4viyfsz
Jef+t+MZqR8u+VBImxEH
=5uJV
-----END PGP SIGNATURE-----

--ugCSa1rMkiCAmd9S--
