Return-Path: <mihail.costea2005@gmail.com>
From: Mihail <mihail.costea2005@gmail.com>
Date: Wed, 24 Apr 2013 08:16:39 +0300
Message-Id: <1366780600-5030-1-git-send-email-mihail.costea2005@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH 0/1] Added type field to dat_entry in order
	to generalize the DAT
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

Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

---

This change is needed in order to make DAT support any type of data, like IPv6 too.
Types are going to be added to batadv_dat_types enum. 

 distributed-arp-table.c |    1 +
 types.h                 |   11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 3a3e1d8..2cb5ebb 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -290,6 +290,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 
 	dat_entry->ip = ip;
+	dat_entry->type = BATADV_DAT_IPV4;
 	memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 	dat_entry->last_update = jiffies;
 	atomic_set(&dat_entry->refcount, 2);
diff --git a/types.h b/types.h
index b2c94e1..0807ef9 100644
--- a/types.h
+++ b/types.h
@@ -964,6 +964,7 @@ struct batadv_algo_ops {
  * struct batadv_dat_entry - it is a single entry of batman-adv ARP backend. It
  * is used to stored ARP entries needed for the global DAT cache
  * @ip: the IPv4 corresponding to this DAT/ARP entry
+ * @type: the type corresponding to this DAT entry
  * @mac_addr: the MAC address associated to the stored IPv4
  * @last_update: time in jiffies when this entry was refreshed last time
  * @hash_entry: hlist node for batadv_priv_dat::hash
@@ -972,6 +973,7 @@ struct batadv_algo_ops {
  */
 struct batadv_dat_entry {
 	__be32 ip;
+	uint8_t type;
 	uint8_t mac_addr[ETH_ALEN];
 	unsigned long last_update;
 	struct hlist_node hash_entry;
@@ -980,6 +982,15 @@ struct batadv_dat_entry {
 };
 
 /**
+ * batadv_dat_types - types used in batadv_dat_entry for IP
+ * @BATADV_DAT_IPv4: IPv4 address type
+ * @BATADV_DAT_IPv6: IPv6 address type
+ */
+enum batadv_dat_types {
+	BATADV_DAT_IPV4 = 0,
+};
+
+/**
  * struct batadv_dat_candidate - candidate destination for DAT operations
  * @type: the type of the selected candidate. It can one of the following:
  *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
-- 
1.7.10.4

