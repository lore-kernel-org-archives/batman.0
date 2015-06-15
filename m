Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 15 Jun 2015 08:22:25 +0200
Message-Id: <1434349345-12854-3-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1434349345-12854-1-git-send-email-linus.luessing@c0d3.blue>
References: <1434349345-12854-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: Fix potential
 synchronization issues in mcast tvlv handler
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

So far the mcast tvlv handler did not anticipate the processing of
multiple incoming OGMs from the same originator at the same time. This
can lead to various issues:

* Broken refcounting: For instance two mcast handlers might both assume
  that an originator just got multicast capabilities and will together
  wrongly decrease mcast.num_disabled by two, potentially leading to
  an integer underflow.

* Potential kernel panic on hlist_del_rcu(): Two mcast handlers might
  one after another try to do an
  hlist_del_rcu(&orig->mcast_want_all_*_node). The second one will
  cause memory corruption / crashes.
  (Reported by: Sven Eckelmann <sven@narfation.org>)

Right in the beginning the code path makes assumptions about the current
multicast related state of an originator and bases all updates on that. The
easiest and least error prune way to fix the issues in this case is to
serialize multiple mcast handler invocations with a spinlock.

Fixes: 77ec494490d6 ("batman-adv: Announce new capability via multicast TVLV")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 multicast.c  |    2 ++
 originator.c |    1 +
 types.h      |    2 ++
 3 files changed, 5 insertions(+)

diff --git a/multicast.c b/multicast.c
index 00612bf..e6db978 100644
--- a/multicast.c
+++ b/multicast.c
@@ -674,6 +674,7 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	uint8_t mcast_flags = BATADV_NO_FLAGS;
 	bool orig_initialized;
 
+	spin_lock_bh(&orig->mcast_handler_lock);
 	orig_initialized = orig->capa_initialized & BATADV_ORIG_CAPA_HAS_MCAST;
 
 	/* If mcast support is turned on decrease the disabled mcast node
@@ -707,6 +708,7 @@ static void batadv_mcast_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	batadv_mcast_want_ipv6_update(bat_priv, orig, mcast_flags);
 
 	orig->mcast_flags = mcast_flags;
+	spin_unlock_bh(&orig->mcast_handler_lock);
 }
 
 /**
diff --git a/originator.c b/originator.c
index e3900e4..78c027d 100644
--- a/originator.c
+++ b/originator.c
@@ -663,6 +663,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	spin_lock_init(&orig_node->tt_buff_lock);
 	spin_lock_init(&orig_node->tt_lock);
 	spin_lock_init(&orig_node->vlan_list_lock);
+	spin_lock_init(&orig_node->mcast_handler_lock);
 
 	batadv_nc_init_orig(orig_node);
 
diff --git a/types.h b/types.h
index c6ec558..1d800c5 100644
--- a/types.h
+++ b/types.h
@@ -251,6 +251,8 @@ struct batadv_orig_node {
 	unsigned long last_seen;
 	unsigned long bcast_seqno_reset;
 #ifdef CONFIG_BATMAN_ADV_MCAST
+	/* synchronizes mcast tvlv specific orig changes */
+	spinlock_t mcast_handler_lock;
 	uint8_t mcast_flags;
 	struct hlist_node mcast_want_all_unsnoopables_node;
 	struct hlist_node mcast_want_all_ipv4_node;
-- 
1.7.10.4

