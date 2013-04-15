Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Apr 2013 17:10:40 +0800
References: <1364895668-15046-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1364895668-15046-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304151710.40934.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move
	batadv_slide_own_bcast_window to bat_iv_ogm.c
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

On Tuesday, April 02, 2013 17:41:08 Antonio Quartulli wrote:
> +static void
> +batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
> +{
> +       struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
> +       struct batadv_hashtable *hash = bat_priv->orig_hash;
> +       struct hlist_head *head;
> +       struct batadv_orig_node *orig_node;
> +       unsigned long *word;
> +       uint32_t i;
> +       size_t word_index;
> +       uint8_t *w;
> +
> +       for (i = 0; i < hash->size; i++) {
> +               head = &hash->table[i];
> +
> +               rcu_read_lock();
> +               hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
> +                       spin_lock_bh(&orig_node->ogm_cnt_lock);
> +                       word_index = hard_iface->if_num * BATADV_NUM_WORDS;
> +                       word = &(orig_node->bcast_own[word_index]);
> +
> +                       batadv_bit_get_packet(bat_priv, word, 1, 0);
> +                       w = &orig_node->bcast_own_sum[hard_iface->if_num];
> +                       *w = bitmap_weight(word,
> BATADV_TQ_LOCAL_WINDOW_SIZE);
> +                       spin_unlock_bh(&orig_node->ogm_cnt_lock);
> +               }
> +               rcu_read_unlock();
> +       }
> +}

Kernel doc ?

Cheers,
Marek
