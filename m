Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 29 Jul 2013 16:10:42 +0800
References: <1373977500-2665-1-git-send-email-ordex@autistici.org>
 <1373977500-2665-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1373977500-2665-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201307291610.43135.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv7 2/2] batman-adv: make the TT CRC logic
	VLAN specific
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


> +/**
> + * batadv_orig_node_vlan_get - get an orig_node_vlan object
> + * @orig_node: the originator servin the VLAN

servin => serving


> + * @vid: the VLAN identifier
> + *
> + * Returns the vlan object identified by vid and belonging to orig_node or
> NULL + * if it does not exist
> + */

Full stop missing.


> +/**
> + * batadv_orig_node_vlan_new - search and possibly create an
> orig_node_vlan + *  object
> + * @orig_node: the originator serving the VLAN
> + * @vid: the VLAN identifier
> + *
> + * Returns NULL in case of failure or the vlan object identified by vid
> and + * belonging to orig_node otherwise. The object is created and added
> to the list + * if it does not exist.
> + *
> + * The object is returned with refcounter increased by 1

Full stop missing.


> +/**
> + * struct batadv_tvlv_tt_vlan_data - vlan specific tt data propagated
> through + *  the tt vlv container

vlv => tvlv


> +/**
>   * batadv_tt_tvlv_container_update - update the translation table tvlv
> container *  after local tt changes have been committed
>   * @bat_priv: the bat priv with all the soft interface information
> @@ -473,10 +683,12 @@ static void batadv_tt_tvlv_container_update(struct
> batadv_priv *bat_priv) struct batadv_tt_change_node *entry, *safe;
>  	struct batadv_tvlv_tt_data *tt_data;
>  	struct batadv_tvlv_tt_change *tt_change;
> -	int tt_diff_len = 0, tt_change_len = 0;
> +	int tt_diff_len, tt_change_len = 0;
>  	int tt_diff_entries_num = 0, tt_diff_entries_count = 0;
> +	uint16_t tt_len, change_offset;
> +	uint8_t *tt_change_ptr;
> 
> -	tt_diff_len += batadv_tt_len(atomic_read(&bat_priv->tt.local_changes));
> +	tt_diff_len = batadv_tt_len(atomic_read(&bat_priv->tt.local_changes));
> 
>  	/* if we have too many changes for one packet don't send any
>  	 * and wait for the tt table request which will be fragmented
> @@ -484,13 +696,16 @@ static void batadv_tt_tvlv_container_update(struct
> batadv_priv *bat_priv) if (tt_diff_len > bat_priv->soft_iface->mtu)
>  		tt_diff_len = 0;
> 
> -	tt_data = kzalloc(sizeof(*tt_data) + tt_diff_len, GFP_ATOMIC);
> -	if (!tt_data)
> +	tt_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
> +						   tt_diff_len);
> +	if (!tt_len)
>  		return;
> 
>  	tt_data->flags = BATADV_TT_OGM_DIFF;
> -	tt_data->ttvn = atomic_read(&bat_priv->tt.vn);
> -	tt_data->crc = htonl(bat_priv->tt.local_crc);
> +
> +	change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
> +	change_offset *= ntohs(tt_data->num_vlan);
> +	change_offset += sizeof(*tt_data);

I think it would be better if you let batadv_tt_prepare_tvlv_local_data() 
return the offset instead of calculating it outside of the function which does 
all the magic ...



> @@ -1899,9 +2257,11 @@ static bool batadv_send_other_tt_response(struct
> batadv_priv *bat_priv, {
>  	struct batadv_orig_node *req_dst_orig_node;
>  	struct batadv_orig_node *res_dst_orig_node = NULL;
> +	struct batadv_tvlv_tt_change *tt_change;
>  	struct batadv_tvlv_tt_data *tvlv_tt_data = NULL;
> -	uint8_t orig_ttvn, req_ttvn;
> -	uint16_t tt_len;
> +	struct batadv_tvlv_tt_vlan_data *tt_vlan;
> +	uint16_t change_offset, tt_len;
> +	uint8_t orig_ttvn, req_ttvn, *tvlv_ptr;
>  	bool ret = false, full_table;
> 
>  	batadv_dbg(BATADV_DBG_TT, bat_priv,
> @@ -1921,9 +2281,11 @@ static bool batadv_send_other_tt_response(struct
> batadv_priv *bat_priv, orig_ttvn =
> (uint8_t)atomic_read(&req_dst_orig_node->last_ttvn); req_ttvn =
> tt_data->ttvn;
> 
> +	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
>  	/* this node doesn't have the requested data */
>  	if (orig_ttvn != req_ttvn ||
> -	    tt_data->crc != htonl(req_dst_orig_node->tt_crc))
> +	    !batadv_tt_global_check_crc(req_dst_orig_node, tt_vlan,
> +					ntohs(tt_data->num_vlan)))
>  		goto out;
> 
>  	/* If the full table has been explicitly requested */
> @@ -1940,26 +2302,42 @@ static bool batadv_send_other_tt_response(struct
> batadv_priv *bat_priv, spin_lock_bh(&req_dst_orig_node->tt_buff_lock);
>  		tt_len = req_dst_orig_node->tt_buff_len;
> 
> -		tvlv_tt_data = kzalloc(sizeof(*tvlv_tt_data) + tt_len,
> -				       GFP_ATOMIC);
> -		if (!tvlv_tt_data)
> +		tt_len = batadv_tt_prepare_tvlv_global_data(req_dst_orig_node,
> +							    &tvlv_tt_data,
> +							    tt_len);
> +		if (!tt_len)
>  			goto unlock;
> 
> +		change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
> +		change_offset *= ntohs(tvlv_tt_data->num_vlan);
> +		change_offset += sizeof(*tvlv_tt_data);

Same here.


> +		tvlv_ptr = (uint8_t *)tvlv_tt_data + change_offset;
> +		tt_change = (struct batadv_tvlv_tt_change *)tvlv_ptr;
>  		/* Copy the last orig_node's OGM buffer */
> -		memcpy(tvlv_tt_data + 1, req_dst_orig_node->tt_buff,
> +		memcpy(tt_change, req_dst_orig_node->tt_buff,
>  		       req_dst_orig_node->tt_buff_len);
>  		spin_unlock_bh(&req_dst_orig_node->tt_buff_lock);
>  	} else {
> -		tt_len = (uint16_t)atomic_read(&req_dst_orig_node->tt_size);
> -		tt_len = batadv_tt_len(tt_len);
> -
> -		tvlv_tt_data = batadv_tt_tvlv_generate(bat_priv,
> -						       bat_priv->tt.global_hash,
> -						       tt_len,
> -						       batadv_tt_global_valid,
> -						       req_dst_orig_node);
> -		if (!tvlv_tt_data)
> +		/* allocate the tvlv, put the tt_data and all the tt_vlan_data
> +		 * in the initial part
> +		 */
> +		tt_len = batadv_tt_prepare_tvlv_global_data(req_dst_orig_node,
> +							    &tvlv_tt_data, -1);
> +		if (!tt_len)
>  			goto out;
> +
> +		change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
> +		change_offset *= ntohs(tvlv_tt_data->num_vlan);
> +		change_offset += sizeof(*tvlv_tt_data);

Again ..


> @@ -2046,29 +2425,45 @@ static bool batadv_send_my_tt_response(struct
> batadv_priv *bat_priv, */
>  	if (!full_table) {
>  		spin_lock_bh(&bat_priv->tt.last_changeset_lock);
> -		tt_len = bat_priv->tt.last_changeset_len;
> 
> -		tvlv_tt_data = kzalloc(sizeof(*tvlv_tt_data) + tt_len,
> -				       GFP_ATOMIC);
> -		if (!tvlv_tt_data)
> +		tt_len = bat_priv->tt.last_changeset_len;
> +		tt_len = batadv_tt_prepare_tvlv_local_data(bat_priv,
> +							   &tvlv_tt_data,
> +							   tt_len);
> +		if (!tt_len)
>  			goto unlock;
> 
> +		change_offset = sizeof(struct batadv_tvlv_tt_vlan_data);
> +		change_offset *= ntohs(tvlv_tt_data->num_vlan);
> +		change_offset += sizeof(*tvlv_tt_data);

Do you see what I mean ?


>  /**
> @@ -406,8 +433,6 @@ struct batadv_priv_tt {
>  	spinlock_t changes_list_lock; /* protects changes */
>  	spinlock_t req_list_lock; /* protects req_list */
>  	spinlock_t roam_list_lock; /* protects roam_list */
> -	atomic_t local_entry_num;
> -	uint32_t local_crc;
>  	unsigned char *last_changeset;
>  	int16_t last_changeset_len;
>  	/* protects last_changeset & last_changeset_len */

Wasn't there some kernel doc you wanted to remove ?  :)

Cheers,
Marek

