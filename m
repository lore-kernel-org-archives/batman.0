Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 26 Oct 2013 23:04:15 +0800
Message-ID: <3111337.oe84KPE3B1@diderot>
In-Reply-To: <1381323938-26931-4-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1381323938-26931-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1381323938-26931-4-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11722564.Hk5gydIcWW";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/7] batman-adv: split out router from
	orig_node
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


--nextPart11722564.Hk5gydIcWW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 09 October 2013 15:05:34 Simon Wunderlich wrote:
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index 2cdcb8b..a7aa7b9 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -918,6 +918,7 @@ static void batadv_iv_ogm_schedule(struct
> batadv_hard_iface *hard_iface) static void
>  batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
>  			  struct batadv_orig_node *orig_node,
> +			  struct batadv_orig_node_ifinfo *orig_node_ifinfo,
>  			  const struct ethhdr *ethhdr,
>  			  const struct batadv_ogm_packet *batadv_ogm_packet,
>  			  struct batadv_hard_iface *if_incoming,

Kernel doc ?


> +
> +/**
> + * batadv_iv_ogm_process_per_outif - process a batman iv OGM for an
> outgoing if + * @ethhdr: the original ethernet header of the sender
> + * @orig_node: the orig node for the originator of this packet
> + * @batadv_ogm_packet: pointer to the ogm packet
> + * @tt_buff: pointer to the tt buffer
> + * @if_incoming: the interface where this packet was receved
> + * @if_outgoing: the interface for which the packet should be considered
> + */
> +static void
> +batadv_iv_ogm_process_per_outif(const struct ethhdr *ethhdr,
> +				struct batadv_orig_node *orig_node,
> +				struct batadv_ogm_packet *batadv_ogm_packet,
> +				const unsigned char *tt_buff,
> +				struct batadv_hard_iface *if_incoming,
> +				struct batadv_hard_iface *if_outgoing)
>  {
>  	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
> -	struct batadv_hard_iface *hard_iface;
> -	struct batadv_orig_node *orig_neigh_node, *orig_node, *orig_node_tmp;
>  	struct batadv_neigh_node *router = NULL, *router_router = NULL;
> +	struct batadv_orig_node *orig_neigh_node, *orig_node_tmp;
> +	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
>  	struct batadv_neigh_node *orig_neigh_router = NULL;
>  	struct batadv_neigh_node_ifinfo *router_ifinfo = NULL;
> -	int has_directlink_flag;
> -	int is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
> -	int is_bidirect;
> -	bool is_single_hop_neigh = false;
> -	bool is_from_best_next_hop = false;
> -	int sameseq, similar_ttl;
> +	struct batadv_ogm_packet ogm_packet_backup;
> +	uint8_t *prev_sender, last_ttl, packet_ttl;
> +	uint32_t last_seqno, packet_seqno;
>  	enum batadv_dup_status dup_status;
> +	bool is_from_best_next_hop = false;
> +	bool is_single_hop_neigh = false;
> +	int is_bidirect;
> +
> +	/* some functions change tq value and/or flags. backup the ogm packet
> +	 * and restore it at the end to allow other interfaces to access the
> +	 * original data.
> +	 */
> +
> +	memcpy(&ogm_packet_backup, batadv_ogm_packet,
> +	       sizeof(ogm_packet_backup));
> +
> +	dup_status = batadv_iv_ogm_update_seqnos(ethhdr, batadv_ogm_packet,
> +						 if_incoming, if_outgoing);
> +	if (batadv_compare_eth(ethhdr->h_source, batadv_ogm_packet->orig))
> +		is_single_hop_neigh = true;
> +
> +	if (dup_status == BATADV_PROTECTED) {
> +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> +			   "Drop packet: packet within seqno protection time (sender: 
%pM)\n",
> +			   ethhdr->h_source);
> +		goto out;
> +	}
> +
> +	if (batadv_ogm_packet->tq == 0) {
> +		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
> +			   "Drop packet: originator packet with tq equal 0\n");
> +		goto out;
> +	}
> +
> +	rcu_read_lock();
> +	router = batadv_orig_node_get_router(orig_node, if_outgoing);
> +	if (router) {
> +		orig_node_tmp = orig_node_tmp;
> +		router_router = batadv_orig_node_get_router(router->orig_node,
> +							    if_outgoing);
> +		router_ifinfo = batadv_neigh_node_get_ifinfo(router,
> +							     if_outgoing);
> +	}
> +
> +       if ((router_ifinfo && router_ifinfo->bat_iv.tq_avg != 0) &&
> +           (batadv_compare_eth(router->addr, ethhdr->h_source)))
> +               is_from_best_next_hop = true;
> +       rcu_read_unlock();

orig_node_tmp = orig_node_tmp ??

What are we protecting against with the rcu_read_lock ? router_ifinfo ? How 
about using refcounting instead ? Every function calling 
batadv_neigh_node_get_ifinfo() would have to have rcu_read_lock() because an 
unprotected struct neigh_ifinfo is returned.


> +	last_seqno = orig_node_ifinfo->last_real_seqno;
> +	last_ttl = orig_node_ifinfo->last_ttl;
> +	packet_seqno = ntohl(batadv_ogm_packet->seqno);
> +	packet_ttl = batadv_ogm_packet->header.ttl;
> +	if (is_bidirect && ((dup_status == BATADV_NO_DUP) ||
> +			    ((last_seqno == packet_seqno) &&
> +			     (last_ttl - 3) <= packet_ttl)))
> +		batadv_iv_ogm_orig_update(bat_priv, orig_node,
> +					  orig_node_ifinfo, ethhdr,
> +					  batadv_ogm_packet, if_incoming,
> +					  if_outgoing, tt_buff, dup_status);

I don't think this if statement will pass. The complexity has been there 
before but there was an attempt to make it readable ...


> -/* increases the refcounter of a found router */
> +/**
> + * batadv_orig_node_get_router - router to the originator depending on
> iface + * @orig_node: the orig node for the router
> + * @if_received: the interface where the packet to be transmitted was
> received + *
> + * Returns the neighbor which should be router for this orig_node/iface.
> + */
>  struct batadv_neigh_node *
> -batadv_orig_node_get_router(struct batadv_orig_node *orig_node)
> +batadv_orig_node_get_router(struct batadv_orig_node *orig_node,
> +			    const struct batadv_hard_iface *if_received)
>  {

Would you mind cleaning up the API while you are at it. We have:
 * batadv_orig_node_vlan_get()
 * batadv_orig_node_vlan_new()
 * batadv_orig_node_new()
 * batadv_iv_ogm_process()
 * etc

Therefore, I suggest renaming this function to batadv_orig_node_router_get().
The kernel doc could mention that the refcount is increased by this function 
call.


>  /**
> + * batadv_orig_node_get_ifinfo - gets the ifinfo from an orig_node
> + * @orig_node: the orig node to be queried
> + * @if_received: the interface for which the ifinfo should be acquired
> + *
> + * Returns the requested orig_node_ifinfo or NULL if not found.
> + *
> + * Note: this function must be called under rcu lock
> + */
> +struct batadv_orig_node_ifinfo *
> +batadv_orig_node_get_ifinfo(struct batadv_orig_node *orig_node,
> +			    struct batadv_hard_iface *if_received)
> +{
> +	struct batadv_orig_node_ifinfo *tmp, *orig_ifinfo = NULL;
> +	unsigned long reset_time;
> +
> +	hlist_for_each_entry_rcu(tmp, &orig_node->ifinfo_list,
> +				 list) {
> +		if (tmp->if_outgoing != if_received)
> +			continue;
> +		orig_ifinfo = tmp;
> +		break;
> +	}
> +
> +	spin_lock_bh(&orig_node->neigh_list_lock);
> +	if (!orig_ifinfo) {
> +		orig_ifinfo = kzalloc(sizeof(*orig_ifinfo), GFP_ATOMIC);
> +		if (!orig_ifinfo)
> +			goto out;
> +
> +		if (if_received &&
> +		    !atomic_inc_not_zero(&if_received->refcount)) {
> +			kfree(orig_ifinfo);
> +			orig_ifinfo = NULL;
> +			goto out;
> +		}
> +		reset_time = jiffies - 1;
> +		reset_time -= msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
> +		orig_ifinfo->batman_seqno_reset = reset_time;
> +		orig_ifinfo->if_outgoing = if_received;
> +		INIT_HLIST_NODE(&orig_ifinfo->list);
> +		hlist_add_head_rcu(&orig_ifinfo->list,
> +				   &orig_node->ifinfo_list);
> +	}
> +out:
> +	spin_unlock_bh(&orig_node->neigh_list_lock);
> +	return orig_ifinfo;
> +}

Same function name change is desirable.

Moreover, why do we require the calling functions to hold the rcu_lock ? I see 
no technical reason but it can easily be forgotten like in 
batadv_iv_ogm_update_seqnos(). Also, why is the spinlock acquired for no 
reason ? It could be moved down just around the hlist_add_head_rcu() call.


> +static void batadv_orig_node_ifinfo_free_rcu(struct rcu_head *rcu)
> +{
> +	struct batadv_orig_node_ifinfo *orig_node_ifinfo;
> +
> +	orig_node_ifinfo = container_of(rcu, struct batadv_orig_node_ifinfo,
> +					rcu);
> +
> +	/* We are in an rcu callback here, therefore we cannot use
> +	 * batadv_hardif_free_ref() and its call_rcu():
> +	 * An rcu_barrier() wouldn't wait for that to finish
> +	 */
> +	if (orig_node_ifinfo->if_outgoing)
> +		batadv_hardif_free_ref_now(orig_node_ifinfo->if_outgoing);
> +
> +	kfree(orig_node_ifinfo);
> +}

Kernel doc ?

Cheers,
Marek

--nextPart11722564.Hk5gydIcWW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSa9nzAAoJEFNVTo/uthzApdUH/1T0wEizlVshIcsYHM1JmySN
tO+sGFLDARQobtPhmseZ/yW/8CP8aZ5pKZjMuIX4zomQBLzVgHkXynntS4ur2P4H
Vxtu3HsikTDFetqdn+WJn15Kn/jat6qpOpkgL1wJROO7N4EQ9KH0eEdZsjU3Mn2W
n8bg3xQo+OHCHzDFkikulLdX48VDUhH1MrLSj81eeqFYTYFtrOOA59Bev1VXEJBd
6ix66yS8cNsKA49wwIcs7aFolmBO3lbZlHpHek0HCxysbdlGyAVj1szGgrrHn4Fu
c6YPOUdTzG/R6RJdTx0Zi0txLeO9a3+v3AIufPMWQW+7DkKfsabe2LoFtPYeQQs=
=ziqM
-----END PGP SIGNATURE-----

--nextPart11722564.Hk5gydIcWW--

