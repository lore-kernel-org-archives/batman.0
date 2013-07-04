Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 4 Jul 2013 17:07:05 +0800
References: <1372869216-2514-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1372869216-2514-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201307041707.05262.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5] batman-adv: make the TT CRC logic VLAN
	specific
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

On Thursday, July 04, 2013 00:33:36 Antonio Quartulli wrote:
> --- a/originator.c
> +++ b/originator.c
> @@ -44,6 +44,95 @@ static int batadv_compare_orig(const struct hlist_node
> *node, const void *data2) return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1
> : 0);
>  }
> 
> +/**
> + * batadv_orig_node_vlan_get - get an orig_node_vlan object
> + * @orig_node: the originator servin the VLAN
> + * @vid: the VLAN identifier
> + *
> + * Returns the vlan object identified by vid and belonging to orig_node or
> NULL + * if it does not exist
> + */
> +struct batadv_orig_node_vlan *
> +batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
> +			  unsigned short vid)
> +{
> +	struct batadv_orig_node_vlan *vlan;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
> +		if (!atomic_inc_not_zero(&vlan->refcount))
> +			continue;
> +
> +		if (vlan->vid != vid)
> +			continue;
> +
> +		rcu_read_unlock();
> +
> +		return vlan;
> +	}
> +	rcu_read_unlock();
> +
> +	return NULL;
> +}

Big memory leak here. First check the validity of the list item before 
increasing its refcounter. Please also keep the return variable style similar 
to other functions in the batman-adv code.


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
> + */
> +struct batadv_orig_node_vlan *
> +batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
> +			  unsigned short vid)
> +{
> +	struct batadv_orig_node_vlan *vlan;
> +
> +	spin_lock_bh(&orig_node->vlan_list_lock);
> +
> +	/* first look if an object for this vid already exists */
> +	list_for_each_entry(vlan, &orig_node->vlan_list, list) {
> +		if (!atomic_inc_not_zero(&vlan->refcount))
> +			continue;
> +
> +		if (vlan->vid != vid)
> +			continue;
> +
> +		/* there is already an entry for this vid: return it */
> +		goto out;
> +	}

Same bug as above. Instead of duplicating the code, simply call 
batadv_orig_node_vlan_get().


> +/**
> + * struct batadv_tvlv_tt_vlan_data - vlan specific tt data propagated
> through + *  the tt vlv container
> + * @crc: crc32 checksum of the entries belonging to this vlan
> + * @vid: vlan identifier
> + * @reserved: unused, useful for alignment purposes
> + */
> +struct batadv_tvlv_tt_vlan_data {
> +	__be32	crc;
> +	__be16	vid;
>  	uint16_t reserved;
> -	__be32  crc;
>  };

How about turning the reserved field into "__be16" as well ?


>  /**
> + * batadv_tt_prepare_tvlv_global_data - prepare the TVLV TT header to send
> + *  within a TT Response directed to another node
> + * @orig_node: originator for which the TT data has to be prepared
> + * @tt_data: uninitialised pointer to the address of the TVLV buffer
> + * @tt_len: space to reserve for the TT entries. If negative, this
> function will + *  allocate as much space is needed for the full table
> + *
> + * Allocate the needed amount of memory for the entire TT TVLV and write
> its + * header made up by one tvlv_tt_data object and a series of
> tvlv_tt_vlan_data + * objects, one per active VLAN served by the
> originator node.
> + *
> + * Return the size of the allocated buffer or 0 in case of failure.
> + */
> +static uint16_t
> +batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
> +				   struct batadv_tvlv_tt_data **tt_data,
> +				   int32_t tt_len)
> +{
> +	struct batadv_tvlv_tt_vlan_data *tt_vlan;
> +	struct batadv_orig_node_vlan *vlan;
> +	uint16_t num_vlan = 0, num_entries = 0;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
> +		num_vlan++;
> +		num_entries += atomic_read(&vlan->tt.num_entries);
> +	}
> +
> +	/* if tt_len is negative, allocate the space needed by the full table */
> +	if (tt_len < 0)
> +		tt_len = batadv_tt_len(num_entries);
> +
> +	tt_len += sizeof(**tt_data);
> +	tt_len += sizeof(*tt_vlan) * num_vlan;
> +
> +	*tt_data = kmalloc(tt_len, GFP_ATOMIC);
> +	if (!*tt_data) {
> +		tt_len = 0;
> +		goto out;
> +	}
> +
> +	(*tt_data)->flags = BATADV_NO_FLAGS;
> +	(*tt_data)->ttvn = atomic_read(&orig_node->last_ttvn);
> +	(*tt_data)->num_vlan = htons(num_vlan);
> +
> +	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
> +	list_for_each_entry_rcu(vlan, &orig_node->vlan_list, list) {
> +		tt_vlan->vid = htons(vlan->vid);
> +		tt_vlan->crc = htonl(vlan->tt.crc);
> +
> +		tt_vlan++;
> +	}
> +out:
> +	rcu_read_unlock();
> +	return tt_len;
> +}

Are you certain this is race condition free ? What if local or global node is 
added while this function is running ?


> +/**
>   * batadv_tt_tvlv_container_update - update the translation table tvlv
> container *  after local tt changes have been committed
>   * @bat_priv: the bat priv with all the soft interface information
> @@ -473,10 +679,11 @@ static void batadv_tt_tvlv_container_update(struct
> batadv_priv *bat_priv) struct batadv_tt_change_node *entry, *safe;
>  	struct batadv_tvlv_tt_data *tt_data;
>  	struct batadv_tvlv_tt_change *tt_change;
> -	int tt_diff_len = 0, tt_change_len = 0;
> +	int tt_diff_len, tt_change_len = 0;
>  	int tt_diff_entries_num = 0, tt_diff_entries_count = 0;
> +	uint16_t tt_len, change_offset;
> 
> -	tt_diff_len += batadv_tt_len(atomic_read(&bat_priv->tt.local_changes));
> +	tt_diff_len = batadv_tt_len(atomic_read(&bat_priv->tt.local_changes));
> 
>  	/* if we have too many changes for one packet don't send any
>  	 * and wait for the tt table request which will be fragmented
> @@ -484,13 +691,16 @@ static void batadv_tt_tvlv_container_update(struct
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

If you avoided this removal you could have one function instead of 
batadv_tt_prepare_tvlv_local_data() and batadv_tt_prepare_tvlv_global_data() 
doing basically the same thing.


> -	tt_change = (struct batadv_tvlv_tt_change *)(tt_data + 1);
> +	tt_change = (struct batadv_tvlv_tt_change *)((uint8_t *)tt_data +
> +						     change_offset);

David won't like that.


> -			seq_printf(seq, " * %pM %4i [%c%c%c%c%c] %3u.%03u\n",
> +			vlan = batadv_softif_vlan_get(bat_priv, vid);
> +			if (!vlan) {
> +				seq_printf(seq, "Cannot retrieve VLAN %d\n",
> +					   BATADV_PRINT_VID(vid));
> +				continue;
> +			}
> +
> +			seq_printf(seq,
> +				   " * %pM %4i [%c%c%c%c%c] %3u.%03u   (%#.8x)\n",
>  				   tt_common_entry->addr,
>  				   BATADV_PRINT_VID(tt_common_entry->vid),
>  				   (tt_common_entry->flags &
> @@ -597,7 +818,8 @@ int batadv_tt_local_seq_print_text(struct seq_file
> *seq, void *offset) (tt_common_entry->flags &
>  				    BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
>  				   no_purge ? 0 : last_seen_secs,
> -				   no_purge ? 0 : last_seen_msecs);
> +				   no_purge ? 0 : last_seen_msecs,
> +				   vlan->tt.crc);
>  		}
>  		rcu_read_unlock();
>  	}

My feeling tells me we are missing batadv_softif_vlan_free_ref() call ?


> @@ -1070,35 +1292,49 @@ static void
>  batadv_tt_global_print_entry(struct batadv_tt_global_entry
> *tt_global_entry, struct seq_file *seq)
>  {
> -	struct hlist_head *head;
>  	struct batadv_tt_orig_list_entry *orig_entry, *best_entry;
>  	struct batadv_tt_common_entry *tt_common_entry;
> -	uint16_t flags;
> +	struct batadv_orig_node_vlan *vlan;
> +	struct hlist_head *head;
>  	uint8_t last_ttvn;
> +	uint16_t flags;
> 
>  	tt_common_entry = &tt_global_entry->common;
>  	flags = tt_common_entry->flags;
> -

Now you try to remove empty lines ? :)


>  	best_entry = batadv_transtable_best_orig(tt_global_entry);
>  	if (best_entry) {
> +		vlan = batadv_orig_node_vlan_get(best_entry->orig_node,
> +						 tt_common_entry->vid);
> +		if (!vlan) {
> +			seq_printf(seq,
> +				   " * Cannot retrieve VLAN %d for originator %pM\n",
> +				   BATADV_PRINT_VID(tt_common_entry->vid),
> +				   best_entry->orig_node->orig);
> +			goto print_list;
> +		}
> +
>  		last_ttvn = atomic_read(&best_entry->orig_node->last_ttvn);
>  		seq_printf(seq,
>  			   " %c %pM %4i   (%3u) via %pM     (%3u)   (%#.8x) [%c%c%c]\n",
>  			   '*', tt_global_entry->common.addr,
>  			   BATADV_PRINT_VID(tt_global_entry->common.vid),
>  			   best_entry->ttvn, best_entry->orig_node->orig,
> -			   last_ttvn, best_entry->orig_node->tt_crc,
> +			   last_ttvn, vlan->tt.crc,
>  			   (flags & BATADV_TT_CLIENT_ROAM ? 'R' : '.'),
>  			   (flags & BATADV_TT_CLIENT_WIFI ? 'W' : '.'),
>  			   (flags & BATADV_TT_CLIENT_TEMP ? 'T' : '.'));
>  	}

How about a batadv_orig_node_vlan_free_ref() call ?


> +print_list:
>  	head = &tt_global_entry->orig_list;
> 
>  	hlist_for_each_entry_rcu(orig_entry, head, list) {
>  		if (best_entry == orig_entry)
>  			continue;
> 
> +		vlan = batadv_orig_node_vlan_get(orig_entry->orig_node,
> +						 tt_common_entry->vid);
> +
>  		last_ttvn = atomic_read(&orig_entry->orig_node->last_ttvn);
>  		seq_printf(seq,
>  			   " %c %pM %4d   (%3u) via %pM     (%3u)   [%c%c%c]\n",

Another one ?

Cheers,
Marek
