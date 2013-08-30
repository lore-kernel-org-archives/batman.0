Return-Path: <ordex@autistici.org>
Date: Fri, 30 Aug 2013 23:22:34 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130830212234.GP2896@ritirata.org>
References: <1377723291-3335-1-git-send-email-ordex@autistici.org>
 <1377723291-3335-2-git-send-email-ordex@autistici.org>
 <201308301220.01356.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GOzekVbrLdOLv44p"
Content-Disposition: inline
In-Reply-To: <201308301220.01356.lindner_marek@yahoo.de>
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


--GOzekVbrLdOLv44p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2013 at 12:20:01PM +0800, Marek Lindner wrote:
> On Thursday, August 29, 2013 04:54:43 Antonio Quartulli wrote:
> > -	INIT_HLIST_NODE(&neigh_node->list);
> > -
> >  	memcpy(neigh_node->addr, neigh_addr, ETH_ALEN);
> > -	spin_lock_init(&neigh_node->lq_update_lock);
> > +	neigh_node->if_incoming =3D hard_iface;
> > +	neigh_node->orig_node =3D orig_node;
> > +
> > +	spin_lock_bh(&orig_node->neigh_list_lock);
> > +	hlist_add_head_rcu(&neigh_node->list, &orig_node->neigh_list);
> > +	spin_unlock_bh(&orig_node->neigh_list_lock);
> > +
> > +	INIT_LIST_HEAD(&neigh_node->bonding_list);
> >=20
> >  	/* extra reference for return */
> >  	atomic_set(&neigh_node->refcount, 2);
> >=20
> > -	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> > -		   "Creating new neighbor %pM on interface %s\n", neigh_addr,
> > -		   hard_iface->net_dev->name);
> > -
>=20
> The init problem remains unresolved ?

Could you be more specific and tell me which fields are not properly
initialised?


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--GOzekVbrLdOLv44p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSIQ0aAAoJEADl0hg6qKeOAFQQAK6aV/OQ0hEC1w8rvP5BpKJM
R6GZ+u8vLABiiok/nmKL0QFC6YfCcJxIByRTLEfMdVGG3/E4cvB0w8tzdaSBmTyk
A3f7kjZ6SzTslBMqnVk4MV4NlpSrvN4DkWgQZkNgjgYZ81jX7EWsFzrtvzCqw8Sm
Pzoj3PeFvXqtb357nJpdRztujTZbzjZGgYWSYrmtRCzudYBKH36L222lRuBGK5ya
2hBon1GhygD5Uvi13wgWw58lB8XMB60YSwfYSnUvmk+XDqOkvhlr7QmrFj1TBJgJ
XiCVdL73ZsAdwU9Mhw4RVAHrNF9teblBBlJM/WUUfazz4OOg0GOSxcJnUSHtDd1E
xwwWedRYSyLwD9Oix8Aqu7V+nKhxBkC0y4a7Ej0e22Jc7az1TG+/WyBViyBZCEZh
7sWIxLKSHJt++n3zUGaU/I5CM7JtAmqrh3kh+2WAb6M1ExRfqOT5VdOKOrOMDQRW
Ge+7zKwuxMxT1xt+gfUE9ei1ofPMwbSqV0+dIgQQZt5gaDw368A4TeU6V6UyQSG+
XlH9QUy0SeTHqK2JSE9STp0mvtA/KKmXU4ZfIKLlx/L61tKtUcT+QET2a0MZxQ/0
KSzVyKOT9lMNdkGDwAnr8HfBFhxpF62MDNtGECRX+e++Vb14LAnQ/H9BSCZMMUHX
YJwcsNalOEj9dR21vqDj
=485E
-----END PGP SIGNATURE-----

--GOzekVbrLdOLv44p--
