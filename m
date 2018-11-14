Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 15:08:01 +0100
Message-Id: <20181114140804.18381-14-sw@simonwunderlich.de>
In-Reply-To: <20181114140804.18381-1-sw@simonwunderlich.de>
References: <20181114140804.18381-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 13/16] batman-adv: Add inconsistent local TT
 netlink dump detection
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The netlink dump functionality transfers a large number of entries from the
kernel to userspace. It is rather likely that the transfer has to
interrupted and later continued. During that time, it can happen that
either new entries are added or removed. The userspace could than either
receive some entries multiple times or miss entries.

Commit 670dc2833d14 ("netlink: advertise incomplete dumps") introduced a
mechanism to inform userspace about this problem. Userspace can then decide
whether it is necessary or not to retry dumping the information again.

The netlink dump functions have to be switched to exclusive locks to avoid
changes while the current message is prepared. The already existing
generation sequence counter from the hash helper can be used for this
simple hash.

Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 41 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d21624c44665..8dcd4968cde7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1145,14 +1145,15 @@ int batadv_tt_local_seq_print_text(struct seq_file *seq, void *offset)
  * batadv_tt_local_dump_entry() - Dump one TT local entry into a message
  * @msg :Netlink message to dump into
  * @portid: Port making netlink request
- * @seq: Sequence number of netlink message
+ * @cb: Control block containing additional options
  * @bat_priv: The bat priv with all the soft interface information
  * @common: tt local & tt global common data
  *
  * Return: Error code, or 0 on success
  */
 static int
-batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid,
+			   struct netlink_callback *cb,
 			   struct batadv_priv *bat_priv,
 			   struct batadv_tt_common_entry *common)
 {
@@ -1173,12 +1174,14 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 
 	batadv_softif_vlan_put(vlan);
 
-	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
-			  NLM_F_MULTI,
+	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
+			  &batadv_netlink_family,  NLM_F_MULTI,
 			  BATADV_CMD_GET_TRANSTABLE_LOCAL);
 	if (!hdr)
 		return -ENOBUFS;
 
+	genl_dump_check_consistent(cb, hdr);
+
 	if (nla_put(msg, BATADV_ATTR_TT_ADDRESS, ETH_ALEN, common->addr) ||
 	    nla_put_u32(msg, BATADV_ATTR_TT_CRC32, crc) ||
 	    nla_put_u16(msg, BATADV_ATTR_TT_VID, common->vid) ||
@@ -1201,34 +1204,39 @@ batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
  * batadv_tt_local_dump_bucket() - Dump one TT local bucket into a message
  * @msg: Netlink message to dump into
  * @portid: Port making netlink request
- * @seq: Sequence number of netlink message
+ * @cb: Control block containing additional options
  * @bat_priv: The bat priv with all the soft interface information
- * @head: Pointer to the list containing the local tt entries
+ * @hash: hash to dump
+ * @bucket: bucket index to dump
  * @idx_s: Number of entries to skip
  *
  * Return: Error code, or 0 on success
  */
 static int
-batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
+batadv_tt_local_dump_bucket(struct sk_buff *msg, u32 portid,
+			    struct netlink_callback *cb,
 			    struct batadv_priv *bat_priv,
-			    struct hlist_head *head, int *idx_s)
+			    struct batadv_hashtable *hash, unsigned int bucket,
+			    int *idx_s)
 {
 	struct batadv_tt_common_entry *common;
 	int idx = 0;
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(common, head, hash_entry) {
+	spin_lock_bh(&hash->list_locks[bucket]);
+	cb->seq = atomic_read(&hash->generation) << 1 | 1;
+
+	hlist_for_each_entry(common, &hash->table[bucket], hash_entry) {
 		if (idx++ < *idx_s)
 			continue;
 
-		if (batadv_tt_local_dump_entry(msg, portid, seq, bat_priv,
+		if (batadv_tt_local_dump_entry(msg, portid, cb, bat_priv,
 					       common)) {
-			rcu_read_unlock();
+			spin_unlock_bh(&hash->list_locks[bucket]);
 			*idx_s = idx - 1;
 			return -EMSGSIZE;
 		}
 	}
-	rcu_read_unlock();
+	spin_unlock_bh(&hash->list_locks[bucket]);
 
 	*idx_s = 0;
 	return 0;
@@ -1248,7 +1256,6 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	struct batadv_priv *bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_hashtable *hash;
-	struct hlist_head *head;
 	int ret;
 	int ifindex;
 	int bucket = cb->args[0];
@@ -1276,10 +1283,8 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	hash = bat_priv->tt.local_hash;
 
 	while (bucket < hash->size) {
-		head = &hash->table[bucket];
-
-		if (batadv_tt_local_dump_bucket(msg, portid, cb->nlh->nlmsg_seq,
-						bat_priv, head, &idx))
+		if (batadv_tt_local_dump_bucket(msg, portid, cb, bat_priv,
+						hash, bucket, &idx))
 			break;
 
 		bucket++;
-- 
2.11.0

