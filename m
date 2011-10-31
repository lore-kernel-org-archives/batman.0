Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 31 Oct 2011 01:08:42 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111031000841.GD10726@pandem0nium>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
	<1319964962-5092-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <1319964962-5092-4-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: Distributed ARP Table -
 create the DHT helper functions
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sun, Oct 30, 2011 at 09:55:59AM +0100, Antonio Quartulli wrote:
> [...]
> +		for (i = 0; i < hash->size; i++) {
> +			head = &hash->table[i];
> +
> +			rcu_read_lock();
> +			hlist_for_each_entry_rcu(orig_node, node, head,
> +						 hash_entry) {
> +				if (orig_node->dht_hash > ip_key)
> +					tmp_max = USHRT_MAX -
> +						orig_node->dht_hash + ip_key;
> +				else
> +					tmp_max = ip_key - orig_node->dht_hash;
> +
> +				/* this is closest! */
> +				if (tmp_max <= max)
> +					continue;
> +
> +				/* this has already been selected */
> +				if (tmp_max > last_max)
> +					continue;
> +
> +				if (!atomic_inc_not_zero(&orig_node->refcount))
> +					continue;
> +
> +				/* In case of hash collision we can select two
> +				 * nodes with the same hash, but we have ensure
> +				 * they are different */
> +				if (tmp_max == last_max) {
> +					for (j = 0; j < select; j++)
> +						if (res[j].orig_node ==
> +						    orig_node)
> +							break;
> +					if (j < select)
> +						continue;
> +				}
> +
> +				if (!atomic_inc_not_zero(&orig_node->refcount))
> +					continue;

Why do you increase the refcount two times? If it is really required, please
add a comment.

> +
> +				max = tmp_max;
> +				if (max_orig_node)
> +					orig_node_free_ref(max_orig_node);
> +				max_orig_node = orig_node;
> +			}
> +			rcu_read_unlock();
> +		}
> +		last_max = max;
> +		if (max_orig_node) {
> +			res[select].type = DHT_CANDIDATE_ORIG;
> +			res[select].orig_node = max_orig_node;
> +			bat_dbg(DBG_ARP, bat_priv, "DHT_SEL_CAND %d: %pM %u\n",
> +				select, max_orig_node->orig, max);
> +		}
> +		if (res[select].type == DHT_CANDIDATE_ME) {
> +			chosen_me = true;
> +			bat_dbg(DBG_ARP, bat_priv, "DHT_SEL_CAND %d: ME %u\n",
> +				select, bat_priv->dht_hash);
> +		}
> +
> +		max_orig_node = NULL;
> +	}
> +
> +	return res;
> +}
> +
> +/*
> + * Sends the skb payload passed as argument to the candidates selected for
> + * 'ip'. The skb is copied by means of pskb_copy() and is sent as unicast packet
> + * to each of the selected candidate. */
> +static bool dht_send_data(struct bat_priv *bat_priv, struct sk_buff *skb,
> +			  uint32_t ip)
> +{
> +	int i;
> +	bool ret = false;
> +	struct neigh_node *neigh_node = NULL;
> +	struct sk_buff *tmp_skb;
> +	struct dht_candidate *cand = dht_select_candidates(bat_priv, ip);
> +
> +	if (!cand)
> +		goto out;
> +
> +	bat_dbg(DBG_ARP, bat_priv, "DHT_SEND for %pI4\n", &ip);
> +
> +	for (i = 0; i < DHT_CANDIDATES_NUM; i++) {
> +		if (cand[i].type == DHT_CANDIDATE_ME ||
> +		    cand[i].type == DHT_CANDIDATE_NULL) {
> +			continue;
> +		}

no braces are required here.

> +
> +		neigh_node = orig_node_get_router(cand[i].orig_node);
> +		if (!neigh_node)
> +			goto free_orig;
> +
> +		tmp_skb = pskb_copy(skb, GFP_ATOMIC);
> +		tmp_skb = prepare_unicast_packet(tmp_skb, cand[i].orig_node);
> +		if (tmp_skb)
> +			send_skb_packet(tmp_skb, neigh_node->if_incoming,
> +					neigh_node->addr);
> +		/* set ret to true only if we send at least one request */
> +		ret = true;
> +		neigh_node_free_ref(neigh_node);
> +free_orig:
> +		orig_node_free_ref(cand[i].orig_node);
> +	}
> +
> +out:
> +	kfree(cand);
> +	return ret;
> +}

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6t5wkACgkQrzg/fFk7axYtkwCgi+MQRIGGaCbw9uLTefkqf4jZ
CIMAn3M9hXGa3qpgBnXE1B/Kud8pvVUT
=bXpg
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
