Return-Path: <ordex@autistici.org>
Date: Sat, 31 Aug 2013 20:38:29 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130831183829.GT2896@ritirata.org>
References: <1377790385-24720-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mjrw6G9AoRBv8oQK"
Content-Disposition: inline
In-Reply-To: <1377790385-24720-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: limit local translation
 table max size
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--mjrw6G9AoRBv8oQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2013 at 11:33:05PM +0800, Marek Lindner wrote:
> The local translation table size is limited by what can be
> transferred from one node to another via a full table request.
>=20
> The number of entries fitting into a full table request depend
> on whether the fragmentation is enabled or not. Therefore this
> patch introduces a max table size check and refuses to add
> more local clients when that size is reached. Moreover, if the
> max full table packet size changes (MTU change or fragmentation
> is disabled) the local table is downsized instantaneously.
>=20
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  hard-interface.c    |   41 +++++++++-----
>  soft-interface.c    |   12 ++--
>  translation-table.c |  154 ++++++++++++++++++++++++++++++++++++++++++++-=
------
>  translation-table.h |    3 +-
>  types.h             |    3 +
>  5 files changed, 172 insertions(+), 41 deletions(-)
>=20
> diff --git a/hard-interface.c b/hard-interface.c
> index c5f871f..c60d3ed 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -266,16 +266,9 @@ static void batadv_check_known_mac_addr(const struct=
 net_device *net_dev)
> =20
>  int batadv_hardif_min_mtu(struct net_device *soft_iface)
>  {
> -	const struct batadv_priv *bat_priv =3D netdev_priv(soft_iface);
> +	struct batadv_priv *bat_priv =3D netdev_priv(soft_iface);

Why are you removing the const qualifier?


>  	const struct batadv_hard_iface *hard_iface;
> -	/* allow big frames if all devices are capable to do so
> -	 * (have MTU > 1500 + batadv_max_header_len())
> -	 */
>  	int min_mtu =3D ETH_DATA_LEN;
> -	int max_header_len =3D batadv_max_header_len();
> -
> -	if (atomic_read(&bat_priv->fragmentation))
> -		goto out;
> =20
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
> @@ -286,22 +279,40 @@ int batadv_hardif_min_mtu(struct net_device *soft_i=
face)
>  		if (hard_iface->soft_iface !=3D soft_iface)
>  			continue;
> =20
> -		min_mtu =3D min_t(int, hard_iface->net_dev->mtu - max_header_len,
> -				min_mtu);
> +		min_mtu =3D min_t(int, hard_iface->net_dev->mtu, min_mtu);
>  	}
>  	rcu_read_unlock();
> +
> +	atomic_set(&bat_priv->packet_size_max, min_mtu);
> +
> +	if (atomic_read(&bat_priv->fragmentation) =3D=3D 0)
> +		goto out;
> +
> +	/* with fragmentation enabled the maximum size of internally generated
> +	 * packets such as translation table exchanges or tvlv containers, etc
> +	 * has to be calculated
> +	 */
> +	min_mtu =3D min_t(int, min_mtu, BATADV_FRAG_MAX_FRAG_SIZE);
> +	min_mtu -=3D sizeof(struct batadv_frag_packet);
> +	min_mtu *=3D BATADV_FRAG_MAX_FRAGMENTS;
> +	atomic_set(&bat_priv->packet_size_max, min_mtu);
> +
> +	/* with fragmentation enabled we can fragment external packets easily */
> +	min_mtu =3D min_t(int, min_mtu, ETH_DATA_LEN);
> +
>  out:
> -	return min_mtu;
> +	return min_mtu - batadv_max_header_len();
>  }
> =20
>  /* adjusts the MTU if a new interface with a smaller MTU appeared. */
>  void batadv_update_min_mtu(struct net_device *soft_iface)
>  {
> -	int min_mtu;
> +	soft_iface->mtu =3D batadv_hardif_min_mtu(soft_iface);
> =20
> -	min_mtu =3D batadv_hardif_min_mtu(soft_iface);
> -	if (soft_iface->mtu !=3D min_mtu)
> -		soft_iface->mtu =3D min_mtu;
> +	/* Check if the local translate table should be cleaned up to match a
> +	 * new (and smaller) MTU.
> +	 */
> +	batadv_tt_local_resize_to_mtu(soft_iface);
>  }
> =20
>  static void
> diff --git a/soft-interface.c b/soft-interface.c
> index bafc811..a1f00e8 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -166,7 +166,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
>  	unsigned int header_len =3D 0;
>  	int data_len =3D skb->len, ret;
>  	unsigned long brd_delay =3D 1;
> -	bool do_bcast =3D false;
> +	bool do_bcast =3D false, client_added;
>  	unsigned short vid;
>  	uint32_t seqno;
> =20
> @@ -196,9 +196,12 @@ static int batadv_interface_tx(struct sk_buff *skb,
>  	ethhdr =3D (struct ethhdr *)skb->data;
> =20
>  	/* Register the client MAC in the transtable */
> -	if (!is_multicast_ether_addr(ethhdr->h_source))
> -		batadv_tt_local_add(soft_iface, ethhdr->h_source, vid,
> -				    skb->skb_iif);
> +	if (!is_multicast_ether_addr(ethhdr->h_source)) {
> +		client_added =3D batadv_tt_local_add(soft_iface, ethhdr->h_source,
> +						   vid, skb->skb_iif);

Isn't this assignment as ugly as the following if condition?

		if (!batadv_tt_local_add(soft_iface, ethhdr->h_source, vid,
					 skb->skb_iif))

client_added looks useless to me.


> +			goto dropped;
> +	}
> =20
>  	/* don't accept stp packets. STP does not help in meshes.
>  	 * better use the bridge loop avoidance ...
> @@ -674,6 +677,7 @@ static int batadv_softif_init_late(struct net_device =
*dev)
>  	atomic_set(&bat_priv->log_level, 0);
>  #endif
>  	atomic_set(&bat_priv->fragmentation, 1);
> +	atomic_set(&bat_priv->packet_size_max, ETH_DATA_LEN);
>  	atomic_set(&bat_priv->bcast_queue_left, BATADV_BCAST_QUEUE_LEN);
>  	atomic_set(&bat_priv->batman_queue_left, BATADV_BATMAN_QUEUE_LEN);
> =20
> diff --git a/translation-table.c b/translation-table.c
> index 2b4d9ed..6a69510 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -401,6 +401,35 @@ static uint16_t batadv_tt_entries(uint16_t tt_len)
>  	return tt_len / batadv_tt_len(1);
>  }
> =20
> +/**
> + * batadv_tt_local_table_transmit_size - calculates the local translatio=
n table
> + *  size when transmitted over the air
> + * @bat_priv: the bat priv with all the soft interface information
> + *
> + * Returns local translation table size in bytes.
> + */
> +static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_p=
riv)
> +{
> +	struct batadv_softif_vlan *vlan;
> +	uint16_t num_vlan =3D 0, tt_local_entries =3D 0;
> +	int hdr_size;

David always asks to sort variable declaration lines from the longest to the
shorter.
IMHO it is not really important (in particular in this case) but since you =
are
creating the function now, please follow that indication.

> +
> +	rcu_read_lock();
> +	hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
> +		num_vlan++;
> +		tt_local_entries +=3D atomic_read(&vlan->tt.num_entries);
> +	}
> +	rcu_read_unlock();
> +
> +	/* header size of tvlv encapsulated tt response payload */
> +	hdr_size =3D sizeof(struct batadv_unicast_tvlv_packet);
> +	hdr_size +=3D sizeof(struct batadv_tvlv_hdr);
> +	hdr_size +=3D sizeof(struct batadv_tvlv_tt_data);
> +	hdr_size +=3D num_vlan * sizeof(struct batadv_tvlv_tt_vlan_data);
> +
> +	return hdr_size + batadv_tt_len(tt_local_entries);
> +}
> +
>  static int batadv_tt_local_init(struct batadv_priv *bat_priv)
>  {
>  	if (bat_priv->tt.local_hash)
> @@ -439,8 +468,10 @@ static void batadv_tt_global_free(struct batadv_priv=
 *bat_priv,
>   * @vid: VLAN identifier
>   * @ifindex: index of the interface where the client is connected to (us=
eful to
>   *  identify wireless clients)
> + *
> + * Returns true if the client was successfully added, false otherwise.
>   */
> -void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *a=
ddr,
> +bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *a=
ddr,
>  			 unsigned short vid, int ifindex)
>  {
>  	struct batadv_priv *bat_priv =3D netdev_priv(soft_iface);
> @@ -448,8 +479,8 @@ void batadv_tt_local_add(struct net_device *soft_ifac=
e, const uint8_t *addr,
>  	struct batadv_tt_global_entry *tt_global;
>  	struct hlist_head *head;
>  	struct batadv_tt_orig_list_entry *orig_entry;
> -	int hash_added;
> -	bool roamed_back =3D false;
> +	int hash_added, table_size, packet_size_max;
> +	bool ret =3D false, roamed_back =3D false;
> =20
>  	tt_local =3D batadv_tt_local_hash_find(bat_priv, addr, vid);
>  	tt_global =3D batadv_tt_global_hash_find(bat_priv, addr, vid);
> @@ -484,6 +515,17 @@ void batadv_tt_local_add(struct net_device *soft_ifa=
ce, const uint8_t *addr,
>  		goto check_roaming;
>  	}
> =20
> +	/* Ignore the client if we cannot send it in a full table response. */
> +	table_size =3D batadv_tt_local_table_transmit_size(bat_priv);
> +	table_size +=3D batadv_tt_len(1);
> +	packet_size_max =3D atomic_read(&bat_priv->packet_size_max);
> +	if (table_size > packet_size_max) {
> +		net_ratelimited_function(batadv_info, soft_iface,
> +					 "Local translation table size (%i) exceeds maximum packet size (%i=
); Ignoring new local tt entry: %pM\n",
> +					 table_size, packet_size_max, addr);
> +		goto out;
> +	}
> +
>  	tt_local =3D kmalloc(sizeof(*tt_local), GFP_ATOMIC);
>  	if (!tt_local)
>  		goto out;
> @@ -550,11 +592,14 @@ check_roaming:
>  		}
>  	}
> =20
> +	ret =3D true;
> +
>  out:
>  	if (tt_local)
>  		batadv_tt_local_entry_free_ref(tt_local);
>  	if (tt_global)
>  		batadv_tt_global_entry_free_ref(tt_global);
> +	return ret;
>  }
> =20
>  /**
> @@ -717,12 +762,6 @@ static void batadv_tt_tvlv_container_update(struct b=
atadv_priv *bat_priv)
>  	tt_diff_entries_num =3D atomic_read(&bat_priv->tt.local_changes);
>  	tt_diff_len =3D batadv_tt_len(tt_diff_entries_num);
> =20
> -	/* if we have too many changes for one packet don't send any
> -	 * and wait for the tt table request which will be fragmented
> -	 */
> -	if (tt_diff_len > bat_priv->soft_iface->mtu)
> -		tt_diff_len =3D 0;
> -

Why are you removing this? We are not going to fragment OGMs and in this
function we are preparing the TVLV to send within one of those.


>  	tvlv_len =3D batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
>  						     &tt_change, &tt_diff_len);
>  	if (!tvlv_len)
> @@ -926,8 +965,16 @@ out:
>  	return curr_flags;
>  }
> =20
> +/**
> + * batadv_tt_local_purge_list - purge inactive tt local entries
> + * @bat_priv: the bat priv with all the soft interface information
> + * @head: pointer to the list containing the local tt entries
> + * @timeout: parameter deciding whether a given tt local entry is consid=
ered
> + *  inactive or not
> + */
>  static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
> -				       struct hlist_head *head)
> +				       struct hlist_head *head,
> +				       int timeout)
>  {
>  	struct batadv_tt_local_entry *tt_local_entry;
>  	struct batadv_tt_common_entry *tt_common_entry;
> @@ -945,8 +992,7 @@ static void batadv_tt_local_purge_list(struct batadv_=
priv *bat_priv,
>  		if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING)
>  			continue;
> =20
> -		if (!batadv_has_timed_out(tt_local_entry->last_seen,
> -					  BATADV_TT_LOCAL_TIMEOUT))
> +		if (!batadv_has_timed_out(tt_local_entry->last_seen, timeout))
>  			continue;
> =20
>  		batadv_tt_local_set_pending(bat_priv, tt_local_entry,
> @@ -954,7 +1000,14 @@ static void batadv_tt_local_purge_list(struct batad=
v_priv *bat_priv,
>  	}
>  }
> =20
> -static void batadv_tt_local_purge(struct batadv_priv *bat_priv)
> +/**
> + * batadv_tt_local_purge - purge inactive tt local entries
> + * @bat_priv: the bat priv with all the soft interface information
> + * @timeout: parameter deciding whether a given tt local entry is consid=
ered
> + *  inactive or not
> + */
> +static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
> +				  int timeout)
>  {
>  	struct batadv_hashtable *hash =3D bat_priv->tt.local_hash;
>  	struct hlist_head *head;
> @@ -966,7 +1019,7 @@ static void batadv_tt_local_purge(struct batadv_priv=
 *bat_priv)
>  		list_lock =3D &hash->list_locks[i];
> =20
>  		spin_lock_bh(list_lock);
> -		batadv_tt_local_purge_list(bat_priv, head);
> +		batadv_tt_local_purge_list(bat_priv, head, timeout);
>  		spin_unlock_bh(list_lock);
>  	}
>  }
> @@ -2370,6 +2423,15 @@ static bool batadv_send_other_tt_response(struct b=
atadv_priv *bat_priv,
>  					req_dst_orig_node);
>  	}
> =20
> +	/* Don't send the response, if larger than fragmented packet. */
> +	tt_len =3D sizeof(struct batadv_unicast_tvlv_packet) + tvlv_len;
> +	if (tt_len > atomic_read(&bat_priv->packet_size_max)) {
> +		net_ratelimited_function(batadv_info, bat_priv->soft_iface,
> +					 "Ignoring TT_REQUEST from %pM; Response size exceeds max packet si=
ze.\n",
> +					 res_dst_orig_node->orig);
> +		goto out;
> +	}
> +
>  	tvlv_tt_data->flags =3D BATADV_TT_RESPONSE;
>  	tvlv_tt_data->ttvn =3D req_ttvn;
> =20
> @@ -2846,7 +2908,7 @@ static void batadv_tt_purge(struct work_struct *wor=
k)
>  	priv_tt =3D container_of(delayed_work, struct batadv_priv_tt, work);
>  	bat_priv =3D container_of(priv_tt, struct batadv_priv, tt);
> =20
> -	batadv_tt_local_purge(bat_priv);
> +	batadv_tt_local_purge(bat_priv, BATADV_TT_LOCAL_TIMEOUT);
>  	batadv_tt_global_purge(bat_priv);
>  	batadv_tt_req_purge(bat_priv);
>  	batadv_tt_roam_purge(bat_priv);
> @@ -2959,18 +3021,18 @@ static void batadv_tt_local_purge_pending_clients=
(struct batadv_priv *bat_priv)
>  }
> =20
>  /**
> - * batadv_tt_local_commit_changes - commit all pending local tt changes =
which
> + * batadv_tt_local_commit_changes_nolock - commit all pending local tt c=
hanges which
>   *  have been queued in the time since the last commit
>   * @bat_priv: the bat priv with all the soft interface information
> + *
> + * Caller must hold tt->commit_lock.
>   */
> -void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
> +void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
>  {
> -	spin_lock_bh(&bat_priv->tt.commit_lock);
> -
>  	if (atomic_read(&bat_priv->tt.local_changes) < 1) {
>  		if (!batadv_atomic_dec_not_zero(&bat_priv->tt.ogm_append_cnt))
>  			batadv_tt_tvlv_container_update(bat_priv);
> -		goto out;
> +		return;
>  	}
> =20
>  	batadv_tt_local_set_flags(bat_priv, BATADV_TT_CLIENT_NEW, false, true);
> @@ -2987,8 +3049,17 @@ void batadv_tt_local_commit_changes(struct batadv_=
priv *bat_priv)
>  	/* reset the sending counter */
>  	atomic_set(&bat_priv->tt.ogm_append_cnt, BATADV_TT_OGM_APPEND_MAX);
>  	batadv_tt_tvlv_container_update(bat_priv);
> +}
> =20
> -out:
> +/**
> + * batadv_tt_local_commit_changes - commit all pending local tt changes =
which
> + *  have been queued in the time since the last commit
> + * @bat_priv: the bat priv with all the soft interface information
> + */
> +void batadv_tt_local_commit_changes(struct batadv_priv *bat_priv)
> +{
> +	spin_lock_bh(&bat_priv->tt.commit_lock);
> +	batadv_tt_local_commit_changes_nolock(bat_priv);
>  	spin_unlock_bh(&bat_priv->tt.commit_lock);
>  }
> =20
> @@ -3184,6 +3255,47 @@ out:
>  }
> =20
>  /**
> + * batadv_tt_local_resize_to_mtu - resize the local translation table fi=
t the
> + *  maximum packet size that can be transported through the mesh
> + * @soft_iface: netdev struct of the mesh interface
> + *
> + * Remove entries older than 'timeout' and half timeout if more entries =
need
> + * to be removed.
> + */
> +void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface)
> +{
> +	struct batadv_priv *bat_priv =3D netdev_priv(soft_iface);
> +	int packet_size_max =3D atomic_read(&bat_priv->packet_size_max);
> +	int table_size, timeout =3D BATADV_TT_LOCAL_TIMEOUT / 2;
> +	bool reduced =3D false;
> +
> +	spin_lock_bh(&bat_priv->tt.commit_lock);
> +
> +	while (true) {
> +		table_size =3D batadv_tt_local_table_transmit_size(bat_priv);
> +		if (packet_size_max >=3D table_size)
> +			break;
> +
> +		batadv_tt_local_purge(bat_priv, timeout);
> +		batadv_tt_local_purge_pending_clients(bat_priv);
> +
> +		timeout /=3D 2;
> +		reduced =3D true;
> +		net_ratelimited_function(batadv_info, soft_iface,
> +					 "Forced to purge local tt entries to fit new maximum fragment MTU =
(%i)\n",
> +					 packet_size_max);
> +	}
> +
> +	/* commit this changes immediately, to avoid synchronization problem
> +	 * with the TTVN
> +	 */
> +	if (reduced)
> +		batadv_tt_local_commit_changes_nolock(bat_priv);
> +
> +	spin_unlock_bh(&bat_priv->tt.commit_lock);
> +}
> +
> +/**
>   * batadv_tt_tvlv_ogm_handler_v1 - process incoming tt tvlv container
>   * @bat_priv: the bat priv with all the soft interface information
>   * @orig: the orig_node of the ogm
> diff --git a/translation-table.h b/translation-table.h
> index dc6db4e..026b1ff 100644
> --- a/translation-table.h
> +++ b/translation-table.h
> @@ -21,7 +21,7 @@
>  #define _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
> =20
>  int batadv_tt_init(struct batadv_priv *bat_priv);
> -void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *a=
ddr,
> +bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *a=
ddr,
>  			 unsigned short vid, int ifindex);
>  uint16_t batadv_tt_local_remove(struct batadv_priv *bat_priv,
>  				const uint8_t *addr, unsigned short vid,
> @@ -45,6 +45,7 @@ bool batadv_tt_global_client_is_roaming(struct batadv_p=
riv *bat_priv,
>  					uint8_t *addr, unsigned short vid);
>  bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
>  				       uint8_t *addr, unsigned short vid);
> +void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface);
>  bool batadv_tt_add_temporary_global_entry(struct batadv_priv *bat_priv,
>  					  struct batadv_orig_node *orig_node,
>  					  const unsigned char *addr,
> diff --git a/types.h b/types.h
> index 0f938c2..d395bb8 100644
> --- a/types.h
> +++ b/types.h
> @@ -595,6 +595,8 @@ struct batadv_softif_vlan {
>   * @aggregated_ogms: bool indicating whether OGM aggregation is enabled
>   * @bonding: bool indicating whether traffic bonding is enabled
>   * @fragmentation: bool indicating whether traffic fragmentation is enab=
led
> + * @packet_size_max: max packet size that can be transmitted via
> + *  multiple fragmented skbs or a single frame if fragmentation is disab=
led
>   * @frag_seqno: incremental counter to identify chains of egress fragmen=
ts
>   * @bridge_loop_avoidance: bool indicating whether bridge loop avoidance=
 is
>   *  enabled
> @@ -641,6 +643,7 @@ struct batadv_priv {
>  	atomic_t aggregated_ogms;
>  	atomic_t bonding;
>  	atomic_t fragmentation;
> +	atomic_t packet_size_max;
>  	atomic_t frag_seqno;
>  #ifdef CONFIG_BATMAN_ADV_BLA
>  	atomic_t bridge_loop_avoidance;
> --=20
> 1.7.10.4


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--mjrw6G9AoRBv8oQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSIjglAAoJEADl0hg6qKeO56UQAJtxj/7c3f+hdciPbQc+pz06
4cQ54GUZ0qy32XfQ8cryPQpVlqswGD5XtAF88dLxLo0qhJuQBU2q8+6GH7KLeb1a
shawSCHNkT5qs/mJxkB3+oaJsRZ3qzdL//p0qN//BONETBY0pKA18yMuLscCLDa8
ZhpzD7ta9N0/sy+YbVYDJisNNQzNUdUyOE3TG+fufnVhgY+Nsc8wZ9lovgAVfr67
WQC+/ilmqCpOmWeU3Cu8/Kf3m1JZ9X+OqAGBEtLgGkCX6KXjmnSG29tBcJlowRya
Qj7Y+2KO9neVOJoaNufP9lsPs4Yt+FciaOtXe6Fb2UNOrCulkARjiROfy6C4FgQR
3InjfQclnpHzXyZ5OMkXzTM8p1REWyKqDzF1D/xdYw+5Lrhq9E50ClQmk0SKs8db
5x4gKulPcRlfYvHtlREfakzP2F5qoDGYpqlhozILtH1xx/5/cihClKUx7HTExhUN
0UzfO0+NXavlnI4lXqe5+/h2C1cTMJzKucyJVa1J1lBwtAhr0XmDOr4d7qWI6WVj
DYNEvW3vcsHu9iD3e8ri/D6JPTYRoHxyGnum7/6MApnIRtb+LwmnahYaHTIJqE5x
67nqKviNN/61NmP4FzjMbK9m25br3AyP4ovuprZwmDOcdPiKTF5cyUPtoWmuhxJh
FQ8yBHt6Z4YQlNH10bB4
=5p75
-----END PGP SIGNATURE-----

--mjrw6G9AoRBv8oQK--
