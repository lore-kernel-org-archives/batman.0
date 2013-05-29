Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 29 May 2013 16:09:51 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130529140950.GA23657@pandem0nium>
References: <1369779649-2537-1-git-send-email-ordex@autistici.org>
 <1369779649-2537-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <1369779649-2537-3-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFC 02/10] batman-adv: make struct
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


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 12:20:41AM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> some of the struct batadv_orig_node members are B.A.T.M.A.N. IV
> specific and therefore they are moved in a algorithm specific
> substruct in order to make batadv_orig_node routing algorithm
> agnostic
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bat_iv_ogm.c | 108 ++++++++++++++++++++++++++++++++++++++++-------------=
------
>  originator.c |  83 +++++++++++++++++----------------------------
>  originator.h |   2 +-
>  routing.c    |  10 ++++--
>  types.h      |  50 +++++++++++++++------------
>  5 files changed, 142 insertions(+), 111 deletions(-)
>=20
> diff --git a/originator.c b/originator.c
> index 3d312de..0225ae2 100644
> --- a/originator.c
> +++ b/originator.c
> @@ -297,18 +297,13 @@ void batadv_originator_free(struct batadv_priv *bat=
_priv)
>  /* this function finds or creates an originator entry for the given
>   * address if it does not exits
>   */
> -struct batadv_orig_node *batadv_get_orig_node(struct batadv_priv *bat_pr=
iv,
> +struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_pr=
iv,
>  					      const uint8_t *addr)
>  {
>  	struct batadv_orig_node *orig_node;
>  	struct batadv_orig_node_vlan *vlan;
> -	int size, i;
> -	int hash_added;
>  	unsigned long reset_time;
> -
> -	orig_node =3D batadv_orig_hash_find(bat_priv, addr);
> -	if (orig_node)
> -		return orig_node;
> +	int i, hash_added;
> =20
>  	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
>  		   "Creating new originator: %pM\n", addr);
> @@ -320,8 +315,6 @@ struct batadv_orig_node *batadv_get_orig_node(struct =
batadv_priv *bat_priv,
>  	INIT_HLIST_HEAD(&orig_node->neigh_list);
>  	INIT_LIST_HEAD(&orig_node->bond_list);
>  	INIT_LIST_HEAD(&orig_node->vlan_list);
> -	spin_lock_init(&orig_node->ogm_cnt_lock);
> -	spin_lock_init(&orig_node->bcast_seqno_lock);
>  	spin_lock_init(&orig_node->neigh_list_lock);
>  	spin_lock_init(&orig_node->tt_buff_lock);
>  	spin_lock_init(&orig_node->vlan_list_lock);
> @@ -339,11 +332,6 @@ struct batadv_orig_node *batadv_get_orig_node(struct=
 batadv_priv *bat_priv,
>  	atomic_set(&orig_node->last_ttvn, 0);
>  	orig_node->tt_buff =3D NULL;
>  	orig_node->tt_buff_len =3D 0;
> -	reset_time =3D jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_M=
S);
> -	orig_node->bcast_seqno_reset =3D reset_time;
> -	orig_node->batman_seqno_reset =3D reset_time;
> -
> -	atomic_set(&orig_node->bond_candidates, 0);
> =20
>  	/* create a vlan object for the "untagged" LAN */
>  	vlan =3D batadv_orig_node_vlan_new(orig_node, BATADV_NO_FLAGS);
> @@ -352,14 +340,7 @@ struct batadv_orig_node *batadv_get_orig_node(struct=
 batadv_priv *bat_priv,
>  	/* there is nothing else to do with the vlan.. */
>  	batadv_orig_node_vlan_free_ref(vlan);
> =20
> -	size =3D bat_priv->num_ifaces * sizeof(unsigned long) * BATADV_NUM_WORD=
S;
> -
> -	orig_node->bcast_own =3D kzalloc(size, GFP_ATOMIC);
> -	if (!orig_node->bcast_own)
> -		goto free_vlan;
> -
> -	size =3D bat_priv->num_ifaces * sizeof(uint8_t);
> -	orig_node->bcast_own_sum =3D kzalloc(size, GFP_ATOMIC);
> +	atomic_set(&orig_node->bond_candidates, 0);
> =20
>  	for (i =3D 0; i < BATADV_FRAG_BUFFER_COUNT; i++) {
>  		INIT_HLIST_HEAD(&orig_node->fragments[i].head);
> @@ -367,22 +348,20 @@ struct batadv_orig_node *batadv_get_orig_node(struc=
t batadv_priv *bat_priv,
>  		orig_node->fragments[i].size =3D 0;
>  	}
> =20
> -	if (!orig_node->bcast_own_sum)
> -		goto free_bcast_own;
> +	spin_lock_init(&orig_node->bcast_seqno_lock);
> +	reset_time =3D jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_M=
S);
> +	orig_node->bcast_seqno_reset =3D reset_time;
> +	orig_node->batman_seqno_reset =3D reset_time;

Why are you moving this stuff around in the function? I don't see the purpo=
se ... reset_time
or bcast_seqno_lock are just moved, but not changed.
> =20
>  	hash_added =3D batadv_hash_add(bat_priv->orig_hash, batadv_compare_orig,
>  				     batadv_choose_orig, orig_node,
>  				     &orig_node->hash_entry);
> -	if (hash_added !=3D 0)
> -		goto free_bcast_own_sum;
> +	if (hash_added !=3D 0) {
> +		kfree(orig_node);
> +		return NULL;
> +	}
> =20
>  	return orig_node;
> -free_bcast_own_sum:
> -	kfree(orig_node->bcast_own_sum);
> -free_bcast_own:
> -	kfree(orig_node->bcast_own);
> -free_vlan:
> -	batadv_orig_node_vlan_free_ref(vlan);
>  free_orig_node:
>  	kfree(orig_node);
>  	return NULL;
> diff --git a/types.h b/types.h
> index c7d5fa1..fde4d68 100644
> --- a/types.h
> +++ b/types.h
> @@ -133,18 +133,29 @@ struct batadv_orig_node_vlan {
>  };
> =20
>  /**
> + * struct batadv_orig_bat_iv - B.A.T.M.A.N. IV private orig_node members
> + * @bcast_own: bitfield containing the number of our OGMs this orig_node
> + *  rebroadcasted "back" to us (relative to last_real_seqno)
> + * @bcast_own_sum: counted result of bcast_own
> + * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
> + *  neigh_node->real_bits & neigh_node->real_packet_count
> + */
> +struct batadv_orig_bat_iv {
> +	unsigned long *bcast_own;
> +	uint8_t *bcast_own_sum;
> +	spinlock_t ogm_cnt_lock;
> +};
> +
> +/**
>   * struct batadv_orig_node - structure for orig_list maintaining nodes o=
f mesh
>   * @orig: originator ethernet address
>   * @primary_addr: hosts primary interface address
>   * @router: router that should be used to reach this originator
> - * @batadv_dat_addr_t:  address of the orig node in the distributed hash
> - * @bcast_own: bitfield containing the number of our OGMs this orig_node
> - *  rebroadcasted "back" to us (relative to last_real_seqno)
> - * @bcast_own_sum: counted result of bcast_own
>   * @last_seen: time when last packet from this node was received
> - * @bcast_seqno_reset: time when the broadcast seqno window was reset
> - * @batman_seqno_reset: time when the batman seqno window was reset
> + * @last_ttl: ttl of last received packet
> + * @batadv_dat_addr_t:  address of the orig node in the distributed hash
>   * @capabilities: announced capabilities of this originator
> + * @last_real_seqno: last and best known sequence number
>   * @last_ttvn: last seen translation table version number
>   * @tt_buff: last tt changeset this node received from the orig node
>   * @tt_buff_len: length of the last tt changeset this node received from=
 the
> @@ -152,19 +163,17 @@ struct batadv_orig_node_vlan {
>   * @tt_buff_lock: lock that protects tt_buff and tt_buff_len
>   * @tt_initialised: bool keeping track of whether or not this node have =
received
>   *  any translation table information from the orig node yet
> - * @last_real_seqno: last and best known sequence number
> - * @last_ttl: ttl of last received packet
>   * @bcast_bits: bitfield containing the info which payload broadcast ori=
ginated
>   *  from this orig node this host already has seen (relative to
>   *  last_bcast_seqno)
>   * @last_bcast_seqno: last broadcast sequence number received by this ho=
st
> + * @bcast_seqno_lock: lock protecting bcast_bits & last_bcast_seqno
> + * @bcast_seqno_reset: time when the broadcast seqno window was reset
> + * @batman_seqno_reset: time when the batman seqno window was reset
>   * @neigh_list: list of potential next hop neighbor towards this orig no=
de
>   * @neigh_list_lock: lock protecting neigh_list, router and bonding_list
>   * @hash_entry: hlist node for batadv_priv::orig_hash
>   * @bat_priv: pointer to soft_iface this orig node belongs to
> - * @ogm_cnt_lock: lock protecting bcast_own, bcast_own_sum,
> - *  neigh_node->real_bits & neigh_node->real_packet_count
> - * @bcast_seqno_lock: lock protecting bcast_bits & last_bcast_seqno
>   * @bond_candidates: how many candidates are available
>   * @bond_list: list of bonding candidates
>   * @refcount: number of contexts the object is used
> @@ -177,29 +186,30 @@ struct batadv_orig_node_vlan {
>   * @vlan_list: a list of orig_node_vlan structs, one per VLAN served by =
the
>   *  originator represented by this object
>   * @vlan_list_lock: lock protecting vlan_list
> + * @bat_iv: B.A.T.M.A.N. IV private structure
>   */
>  struct batadv_orig_node {
>  	uint8_t orig[ETH_ALEN];
>  	uint8_t primary_addr[ETH_ALEN];
>  	struct batadv_neigh_node __rcu *router; /* rcu protected pointer */
> +	unsigned long last_seen;
> +	uint8_t last_ttl;
>  #ifdef CONFIG_BATMAN_ADV_DAT
>  	batadv_dat_addr_t dat_addr;
>  #endif
> -	unsigned long *bcast_own;
> -	uint8_t *bcast_own_sum;
> -	unsigned long last_seen;
> -	unsigned long bcast_seqno_reset;
> -	unsigned long batman_seqno_reset;
>  	uint8_t capabilities;
> +	uint32_t last_real_seqno;
>  	atomic_t last_ttvn;
>  	unsigned char *tt_buff;
>  	int16_t tt_buff_len;
>  	spinlock_t tt_buff_lock; /* protects tt_buff & tt_buff_len */
>  	bool tt_initialised;
> -	uint32_t last_real_seqno;
> -	uint8_t last_ttl;
>  	DECLARE_BITMAP(bcast_bits, BATADV_TQ_LOCAL_WINDOW_SIZE);
>  	uint32_t last_bcast_seqno;
> +	/* bcast_seqno_lock protects: bcast_bits & last_bcast_seqno */
> +	spinlock_t bcast_seqno_lock;
> +	unsigned long bcast_seqno_reset;
> +	unsigned long batman_seqno_reset;
>  	struct hlist_head neigh_list;
>  	/* neigh_list_lock protects: neigh_list, router & bonding_list */
>  	spinlock_t neigh_list_lock;
> @@ -208,9 +218,6 @@ struct batadv_orig_node {
>  	/* ogm_cnt_lock protects: bcast_own, bcast_own_sum,
>  	 * neigh_node->real_bits & neigh_node->real_packet_count
>  	 */
> -	spinlock_t ogm_cnt_lock;
> -	/* bcast_seqno_lock protects: bcast_bits & last_bcast_seqno */
> -	spinlock_t bcast_seqno_lock;
>  	atomic_t bond_candidates;
>  	struct list_head bond_list;
>  	atomic_t refcount;
> @@ -224,6 +231,7 @@ struct batadv_orig_node {
>  	struct batadv_frag_table_entry fragments[BATADV_FRAG_BUFFER_COUNT];
>  	struct list_head vlan_list;
>  	spinlock_t vlan_list_lock; /* protects vlan_list */
> +	struct batadv_orig_bat_iv bat_iv;
>  };

Same here: there are various fields which are just moved around for no obvi=
ous
reason (bcast_seqno_lock, batman_seqno_reset, bcast_seqno_reset, last_seen,=
 last_ttl,
=2E..)


> =20
>  /**
> --=20
> 1.8.1.5
>=20

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGmDC4ACgkQrzg/fFk7axYLcgCgzksjqqftAZeKrK5mBKUsNDWD
d4AAoKyA09s0Z1b1tHBFAqmw+pX3e4Zd
=F1qN
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
