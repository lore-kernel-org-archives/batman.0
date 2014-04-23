Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 23 Apr 2014 18:50:59 +0200
Message-ID: <6135724.irU0LlAv5Q@sven-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [B.A.T.M.A.N.] batman-adv: Multiple NULL derefence bugs (+ 1 bonus)
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
To: b.a.t.m.a.n@lists.open-mesh.org

All taken from batman-adv master (b08dc3d9452d28944e7db09c2005c633b63f55e9)


1. multicast.c (dereference of NULL orig_node on at least the first round):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

orig_node = NULL before the first entry in hlist_for_each_entry_rcu. NULL
dereferenced in atomic_inc_not_zero(...) to get the refcount

Was introduced with 45dab5f5509023946793fc9d1d0566c12ca8bb52
("batman-adv: fix more code style")

Code section:
============

static struct batadv_orig_node *
batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
{
	struct batadv_orig_node *tmp_orig_node, *orig_node = NULL;

	rcu_read_lock();
	hlist_for_each_entry_rcu(tmp_orig_node,
				 &bat_priv->mcast.want_all_unsnoopables_list,
				 mcast_want_all_unsnoopables_node) {
		if (!atomic_inc_not_zero(&orig_node->refcount))
			continue;

		orig_node = tmp_orig_node;
		break;
	}
	rcu_read_unlock();

	return orig_node;
}

Solution:
========

Change atomic_inc_not_zero from orig_node to tmp_orig_node

2. multicast.c (dereference of NULL orig_node on at least the first round):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

orig_node = NULL before the first entry in hlist_for_each_entry_rcu. NULL
dereferenced in atomic_inc_not_zero(...) to get the refcount

Was introduced with 45dab5f5509023946793fc9d1d0566c12ca8bb52
("batman-adv: fix more code style")

Code section:
============

static struct batadv_orig_node *
batadv_mcast_forw_ipv6_node_get(struct batadv_priv *bat_priv)
{
	struct batadv_orig_node *tmp_orig_node, *orig_node = NULL;

	rcu_read_lock();
	hlist_for_each_entry_rcu(tmp_orig_node,
				 &bat_priv->mcast.want_all_ipv6_list,
				 mcast_want_all_ipv6_node) {
		if (!atomic_inc_not_zero(&orig_node->refcount))
			continue;

		orig_node = tmp_orig_node;
		break;
	}
	rcu_read_unlock();

	return orig_node;
}

Solution:
========

Change atomic_inc_not_zero from orig_node to tmp_orig_node

3. multicast.c (dereference of NULL orig_node on at least the first round):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

orig_node = NULL before the first entry in hlist_for_each_entry_rcu. NULL
dereferenced in atomic_inc_not_zero(...) to get the refcount

Was introduced with 45dab5f5509023946793fc9d1d0566c12ca8bb52
("batman-adv: fix more code style")

Code section:
============

static struct batadv_orig_node *
batadv_mcast_forw_ipv4_node_get(struct batadv_priv *bat_priv)
{
	struct batadv_orig_node *tmp_orig_node, *orig_node = NULL;

	rcu_read_lock();
	hlist_for_each_entry_rcu(tmp_orig_node,
				 &bat_priv->mcast.want_all_ipv4_list,
				 mcast_want_all_ipv4_node) {
		if (!atomic_inc_not_zero(&orig_node->refcount))
			continue;

		orig_node = tmp_orig_node;
		break;
	}
	rcu_read_unlock();

	return orig_node;
}

Solution:
========

Change atomic_inc_not_zero from orig_node to tmp_orig_node

4. originator.c (Indirect hard_iface NULL dereference):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

hard_iface is NULL and goto out is made. batadv_hardif_free_ref doesn't
check for NULL before dereferencing it to get to refcount.

Introduced in f13f960797fd1969b3c0470cc97435ddfb6aecb4
("batman-adv: add debugfs support to view multiif tables").

Code section:
============

int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
{
	struct net_device *net_dev = (struct net_device *)seq->private;
	struct batadv_hard_iface *hard_iface;
	struct batadv_priv *bat_priv;

	hard_iface = batadv_hardif_get_by_netdev(net_dev);

	if (!hard_iface || !hard_iface->soft_iface) {
		seq_puts(seq, "Interface not known to B.A.T.M.A.N.\n");
		goto out;
	}

[...]

out:
	batadv_hardif_free_ref(hard_iface);
	return 0;
}

Solution:
========

	if (hard_iface)
		batadv_hardif_free_ref(hard_iface);

Related code section:
====================

static inline void
batadv_hardif_free_ref_now(struct batadv_hard_iface *hard_iface)
{
	if (atomic_dec_and_test(&hard_iface->refcount))
		batadv_hardif_free_rcu(&hard_iface->rcu);
}


5. BONUS: fragmentation.c (Impossible code section marked likely):
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

frag_entry_curr is iterator used for list chain->head. This loop is
only stopped when the list ends and frag_entry_curr is NULL. The next
section following the loop says that it is likely that frag_entry_curr
is NOT NULL. This is a contradiction.

Introduced in 9b3eab61754d74a93c9840c296013fe3b4a1b606
("batman-adv: Receive fragmented packets and merge")

Code section:
============

static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
				      struct sk_buff *skb,
				      struct hlist_head *chain_out)
{
[...]

	/* Find the position for the new fragment. */
	hlist_for_each_entry(frag_entry_curr, &chain->head, list) {
		/* Drop packet if fragment already exists. */
		if (frag_entry_curr->no == frag_entry_new->no)
			goto err_unlock;

		/* Order fragments from highest to lowest. */
		if (frag_entry_curr->no < frag_entry_new->no) {
			hlist_add_before(&frag_entry_new->list,
					 &frag_entry_curr->list);
			chain->size += skb->len - hdr_size;
			chain->timestamp = jiffies;
			ret = true;
			goto out;
		}
	}

	/* Reached the end of the list, so insert after 'frag_entry_curr'. */
	if (likely(frag_entry_curr)) {
		hlist_add_after(&frag_entry_curr->list, &frag_entry_new->list);
		chain->size += skb->len - hdr_size;
		chain->timestamp = jiffies;
		ret = true;
	}

[...]
}

Solution:
========

Rewrite this part to track the last seen batadv_frag_list_entry and add it
after that. The empty list should already handled earlier in the scope
starting with
	if (batadv_frag_init_chain(chain, seqno)) {

Related code section:
====================

#define hlist_for_each_entry(pos, head, member)                         \
        for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
             pos;                                                       \
             pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), 
member))
