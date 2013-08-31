Return-Path: <ordex@autistici.org>
Date: Sat, 31 Aug 2013 20:18:22 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130831181822.GS2896@ritirata.org>
References: <1377723291-3335-1-git-send-email-ordex@autistici.org>
 <1377723291-3335-2-git-send-email-ordex@autistici.org>
 <201308301220.01356.lindner_marek@yahoo.de>
 <20130830212234.GP2896@ritirata.org>
 <20130830212811.GQ2896@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H2kTGx6mr3R59oXC"
Content-Disposition: inline
In-Reply-To: <20130830212811.GQ2896@ritirata.org>
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


--H2kTGx6mr3R59oXC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2013 at 11:28:11PM +0200, Antonio Quartulli wrote:
> On Fri, Aug 30, 2013 at 11:22:34PM +0200, Antonio Quartulli wrote:
> > On Fri, Aug 30, 2013 at 12:20:01PM +0800, Marek Lindner wrote:
> > > On Thursday, August 29, 2013 04:54:43 Antonio Quartulli wrote:
> > > > -	INIT_HLIST_NODE(&neigh_node->list);
> > > > -
> > > >  	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
> > > > -	spin_lock_init(&neigh_node->lq_update_lock);
> > > > +	neigh_node->if_incoming =3D hard_iface;
> > > > +	neigh_node->orig_node =3D orig_node;
> > > > +
> > > > +	spin_lock_bh(&orig_node->neigh_list_lock);
> > > > +	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
> > > > +	spin_unlock_bh(&orig_node->neigh_list_lock);
> > > > +
> > > > +	INIT_LIST_HEAD(&neigh_node->bonding_list);
> > > >=20
> > > >  	/* extra reference for return */
> > > >  	atomic_set(&neigh_node->refcount, 2);
> > > >=20
> > > > -	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > > > -		   "Creating new neighbor %pM on interface %s\n", neigh_addr,
> > > > -		   hard_iface->net_dev->name);
> > > > -
> > >=20
> > > The init problem remains unresolved ?
> >=20
> > Could you be more specific and tell me which fields are not properly
> > initialised?
>=20
> maybe you were taking about neigh_node->list ? actually that may be missi=
ng and
> we don't know if this neigh_noe is going to be immediately added to a lis=
t..so
> better to initialise it.

Ok, finally I got you were trying to tell me since the last patchset!!! :-)
I'm moving hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
directly at the end of batadv_iv_ogm_neigh_new().

Each protocol will be in charge of adding the neigh_node item to the list.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--H2kTGx6mr3R59oXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSIjNuAAoJEADl0hg6qKeOxJMP/AlJmGYn7ZGkqI9ZwJWDyVyx
p+BcgQnfnIQtSSSTKjoMLS0PxLa4olHoikdTTCgvnvplYZx0+slmugG3cCpvsMfe
nYCasUo7UmyHYkJ00IYWVquSp8hg27wahFZWaDAu1ZPW0hjEcJA0NHmB8l1BUog1
odt45AKAtvNrf7E2esRgiOhAWeHzSTTbQ5B3qMM3zlKw8Z7Kd7r5ESHpqxEE601K
FMDqWLadVEPWBLUwip0UgzJqplu5fgxDEefdX2BxL4wNj79VMxAEJMZ63X2OP5cW
xaWPN3w5BUNF58Hdb8rxjN39kV3CF9jIVTGed9O9vk6fmwBMgmke7BI66I7hHOMV
iyVx5YsAr0wv/xJGg3m3MYvA9xzpEI2HP79Rnb7q9RqUAgPv3lFx6OZcPnn/UBIG
dulOlVXgfzLJVVBXXH82HA3a6X+8tC1Fn8x0eA62k0RShkBmNDVgedHbs33WCFFC
RoXbK5E+glHMSqqu/clnCvuLzioFmPJH7eguGRxHISv+Fa63I147xpn/NsHzuzQH
4SjxbI1a9BdAdnmpHWdh8BHWUrTDdupgz4pwKcyxSExrIceT2tGCZYYl7nYZo4Pi
43GLGXPxvJWIwjszxdGbBcHzqXFkiazQOQ+L0G7z8uKnXO3En1Xk3t/1jck1GwKE
HXT+yrYwrt0Yl0WJsTbn
=zwre
-----END PGP SIGNATURE-----

--H2kTGx6mr3R59oXC--
