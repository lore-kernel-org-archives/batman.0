Return-Path: <ordex@autistici.org>
Date: Fri, 16 Aug 2013 08:27:29 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130816062729.GV849@ritirata.org>
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <1376376232-2178-2-git-send-email-ordex@autistici.org>
 <201308161146.41467.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9lPOKfY2vCV97ybw"
Content-Disposition: inline
In-Reply-To: <201308161146.41467.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/9] batman-adv: make struct
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


--9lPOKfY2vCV97ybw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2013 at 11:46:41AM +0800, Marek Lindner wrote:
> On Tuesday, August 13, 2013 14:43:44 Antonio Quartulli wrote:
> > @@ -1011,13 +1011,13 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr
> > *ethhdr, }
> >=20
> >  		/* if the window moved, set the update flag. */
> > -		need_update |=3D batadv_bit_get_packet(bat_priv,
> > -						     tmp_neigh_node->real_bits,
> > +		bitmap =3D tmp_neigh_node->bat_iv.real_bits;
> > +		need_update |=3D batadv_bit_get_packet(bat_priv, bitmap,
> >  						     seq_diff, set_mark);
> >=20
> > -		packet_count =3D bitmap_weight(tmp_neigh_node->real_bits,
> > +		packet_count =3D bitmap_weight(tmp_neigh_node->bat_iv.real_bits,
> >  					     BATADV_TQ_LOCAL_WINDOW_SIZE);
> > -		tmp_neigh_node->real_packet_count =3D packet_count;
> > +		tmp_neigh_node->bat_iv.real_packet_count =3D packet_count;
> >  	}
>=20
> You can't make assumptions about the size of bitmap because it is platfor=
m=20
> specific which is why the variable declaration is a macro in the first pl=
ace.

where do I make such assumption? Variable bitmap is a just storing the addr=
ess
of the bitmap.

>=20
>=20
> > @@ -174,27 +174,28 @@ batadv_orig_node_get_router(struct batadv_orig_no=
de
> > *orig_node)
> >=20
> >  struct batadv_neigh_node *
> >  batadv_neigh_node_new(struct batadv_hard_iface *hard_iface,
> > -		      const uint8_t *neigh_addr)
> > +		      const uint8_t *neigh_addr,
> > +		      struct batadv_orig_node *orig_node)
> >  {
>=20
> That merits some kernel doc!  :)
>=20

yap

>=20
> > -	struct batadv_priv *bat_priv =3D netdev_priv(hard_iface->soft_iface);
> >  	struct batadv_neigh_node *neigh_node;
> >=20
> >  	neigh_node =3D kzalloc(sizeof(*neigh_node), GFP_ATOMIC);
> >  	if (!neigh_node)
> >  		goto out;
> >=20
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
> >  out:
> >  	return neigh_node;
> >  }
>=20
> All variables should be initialized before we add the new entry to the an=
y=20
> list.
>=20

object is allocated with kzalloc: everything is zero. I thought we use kzal=
loc
for this purpose: avoid initialisation of every field..no?

>=20
> > @@ -436,7 +437,8 @@ batadv_purge_orig_neighbors(struct batadv_priv
> > *bat_priv, batadv_neigh_node_free_ref(neigh_node);
> >  		} else {
> >  			if ((!*best_neigh_node) ||
> > -			    (neigh_node->tq_avg > (*best_neigh_node)->tq_avg))
> > +			    (neigh_node->bat_iv.tq_avg >
> > +			     (*best_neigh_node)->bat_iv.tq_avg))
> >  				*best_neigh_node =3D neigh_node;
> >  		}
> >  	}
>=20
> Do you think David will accept that ?=20

yes and no :) maybe I should use some more variables..

>=20
>=20
> > @@ -133,7 +133,8 @@ void batadv_bonding_candidate_add(struct
> > batadv_orig_node *orig_node, goto candidate_del;
> >=20
> >  	/* ... and is good enough to be considered */
> > -	if (neigh_node->tq_avg < router->tq_avg - BATADV_BONDING_TQ_THRESHOLD)
> > +	if (neigh_node->bat_iv.tq_avg <
> > +	    router->bat_iv.tq_avg - BATADV_BONDING_TQ_THRESHOLD)
> >  		goto candidate_del;
> >=20
> >  	/* check if we have another candidate with the same mac address or
>=20
> Same here. I suggest to calculate router->bat_iv.tq_avg -=20
> BATADV_BONDING_TQ_THRESHOLD in advance and store it in a variable.

ok

>=20
>=20
> > @@ -470,8 +471,7 @@ batadv_find_bond_router(struct batadv_orig_node
> > *primary_orig, * does not exist as rcu version
> >  	 */
> >  	list_del_rcu(&primary_orig->bond_list);
> > -	list_add_rcu(&primary_orig->bond_list,
> > -		     &router->bonding_list);
> > +	list_add_rcu(&primary_orig->bond_list, &router->bonding_list);
> >  	spin_unlock_bh(&primary_orig->neigh_list_lock);
>=20
> Looks unrelated to the topic of this patch ?

yeah, simon spotted a couple of these things already. I think they were
introduced before and then I failed to reverse all them back.

>=20
>=20
> >  /**
> > - * struct batadv_neigh_node - structure for single hop neighbors
> > - * @list: list node for batadv_orig_node::neigh_list
> > - * @addr: mac address of neigh node
> > + * struct batadv_neigh_bat_iv - structure for single hop neighbors
> >   * @tq_recv: ring buffer of received TQ values from this neigh node
> >   * @tq_index: ring buffer index
> >   * @tq_avg: averaged tq of all tq values in the ring buffer (tq_recv)
> > - * @last_ttl: last received ttl from this neigh node
> > - * @bonding_list: list node for batadv_orig_node::bond_list
> > - * @last_seen: when last packet via this neighbor was received
> >   * @real_bits: bitfield containing the number of OGMs received from th=
is
> > neigh *  node (relative to orig_node->last_real_seqno)
> >   * @real_packet_count: counted result of real_bits
> > - * @orig_node: pointer to corresponding orig_node
> > - * @if_incoming: pointer to incoming hard interface
> >   * @lq_update_lock: lock protecting tq_recv & tq_index
> >   * @refcount: number of contexts the object is used
> > - * @rcu: struct used for freeing in an RCU-safe manner
> >   */
> > -struct batadv_neigh_node {
> > -	struct hlist_node list;
> > -	uint8_t addr[ETH_ALEN];
> > +struct batadv_neigh_bat_iv {
> >  	uint8_t tq_recv[BATADV_TQ_GLOBAL_WINDOW_SIZE];
> >  	uint8_t tq_index;
> >  	uint8_t tq_avg;
> > -	uint8_t last_ttl;
> > -	struct list_head bonding_list;
> > -	unsigned long last_seen;
> >  	DECLARE_BITMAP(real_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
> >  	uint8_t real_packet_count;
> > +	spinlock_t lq_update_lock; /* protects tq_recv & tq_index */
> > +};
>=20
> @refcount ?

:)

>=20
>=20
> > +/**
> > + * struct batadv_neigh_node - structure for single hops neighbors
> > + * @list: list node for batadv_orig_node::neigh_list
> > + * @orig_node: pointer to corresponding orig_node
> > + * @addr: the MAC address of the neighboring interface
> > + * @if_incoming: pointer to incoming hard interface
> > + * @last_seen: when last packet via this neighbor was received
> > + * @last_ttl: last received ttl from this neigh node
> > + * @bonding_list: list node for batadv_orig_node::bond_list
> > + * @rcu: struct used for freeing in an RCU-safe manner
> > + * @priv: pointer to the routing algorithm private data
> > + */
> > +struct batadv_neigh_node {
> > +	struct hlist_node list;
> >  	struct batadv_orig_node *orig_node;
> > +	uint8_t addr[ETH_ALEN];
> >  	struct batadv_hard_iface *if_incoming;
> > -	spinlock_t lq_update_lock; /* protects tq_recv & tq_index */
> > +	unsigned long last_seen;
> > +	uint8_t last_ttl;
> > +	struct list_head bonding_list;
> >  	atomic_t refcount;
> >  	struct rcu_head rcu;
> > +	struct batadv_neigh_bat_iv bat_iv;
> >  };
>=20
> @priv ??? Copy and paste bug I presume ?
>=20

of course!

> Cheers,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--9lPOKfY2vCV97ybw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSDcZRAAoJEADl0hg6qKeOOX4QAJ9S5p8LM4woAm8hrVsMSr3T
cNdbhrljZM3ZocOFxFp6zHvXskfFq4qk90TTglJt/vl+1UpjAsGsLrtuOTZZ4C+8
sxM/FBTVPDMZSjXdbz2IKZ5Fljsw3EXbCT10VW17I1WERO8lraFuvqdYfneYl1op
0PStnBYZXdBapKlFmzsTOYjb/qJSVTagU8DUTzvlPPBV9bw1HkJgMBcG5zNFx/Zg
oOQH6gWzGv8DbgpB9EBOt+2Xz2tdST9T0atYIcFueemaw0aHXG9k9ADkeJmZXs4w
uyZHgVLx2/kdPoyMH3NcsAqXohIyWO6g4xjSvwuZao4Nbi8nfKdlAUjfYJzSQmrn
9vGwFdSfI4o9YobbYetqfkkNb4uW+OFBJieK/JiMrQ0+n3/V6FADwcaHvHwpWQcs
5+6jj01rvnwGrzGNWJp75QKKsX5YkL76GtVLSTScGCx2/ZKaCVgjXApOytOpTSMt
T3MdPmJ13/azlEUJRT/MklaA4O4cbmLAoiGQK6pcIPCOAAIt7F0W3yT7UhijX1jh
hnnfUEvkr4nDMLDmCEiwuhqe0+N6aF2K77T3NA/AcLk+tWOXBiTcFJTeNzPFhYci
G7O+GRhV2MJJe2nJn14BlW4VNRPZbXx9GmgjT9J2K7dX3sk2r2ybSRto4fBi3U9E
DHRmTM/B+06QCZZhagHO
=OaOK
-----END PGP SIGNATURE-----

--9lPOKfY2vCV97ybw--
