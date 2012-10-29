Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 29 Oct 2012 16:35:29 +0100
Message-Id: <1351524929-21921-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: don't free resource when DAT
	is disabled
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

Freeing all the resources when DAT is disabled need a much more complicated
locking system to prevent concurrent enable/disable operations to destroy the
internal state of the component. For now it is safe to avoid such freeing
operation when DAT is disabled.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

v2:
 - removed declaration of batadv_dat_switch() in distributed-arp-table.h

 distributed-arp-table.c | 10 ----------
 distributed-arp-table.h |  1 -
 sysfs.c                 |  3 +--
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index c933615..7921030 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -1061,13 +1061,3 @@ out:
 		batadv_dat_entry_free_ref(dat_entry);
 	return ret;
 }
-
-void batadv_dat_switch(struct net_device *net_dev)
-{
-	struct batadv_priv *bat_priv = netdev_priv(net_dev);
-
-	if (atomic_read(&bat_priv->distributed_arp_table))
-		batadv_dat_init(bat_priv);
-	else
-		batadv_dat_free(bat_priv);
-}
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 63a13a5..d060c03 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -73,7 +73,6 @@ batadv_dat_init_own_addr(struct batadv_priv *bat_priv,
 int batadv_dat_init(struct batadv_priv *bat_priv);
 void batadv_dat_free(struct batadv_priv *bat_priv);
 int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset);
-void batadv_dat_switch(struct net_device *net_dev);
 
 /**
  * batadv_dat_inc_counter - increment the correct DAT packet counter
diff --git a/sysfs.c b/sysfs.c
index 9dc58b5..84a55cb 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -422,8 +422,7 @@ BATADV_ATTR_SIF_BOOL(bonding, S_IRUGO | S_IWUSR, NULL);
 BATADV_ATTR_SIF_BOOL(bridge_loop_avoidance, S_IRUGO | S_IWUSR, NULL);
 #endif
 #ifdef CONFIG_BATMAN_ADV_DAT
-BATADV_ATTR_SIF_BOOL(distributed_arp_table, S_IRUGO | S_IWUSR,
-		     batadv_dat_switch);
+BATADV_ATTR_SIF_BOOL(distributed_arp_table, S_IRUGO | S_IWUSR, NULL);
 #endif
 BATADV_ATTR_SIF_BOOL(fragmentation, S_IRUGO | S_IWUSR, batadv_update_min_mtu);
 BATADV_ATTR_SIF_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
-- 
1.7.12.4

