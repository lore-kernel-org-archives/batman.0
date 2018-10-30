Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 30 Oct 2018 22:01:30 +0100
Message-Id: <20181030210130.18152-10-sven@narfation.org>
In-Reply-To: <20181030210130.18152-1-sven@narfation.org>
References: <20181030210130.18152-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 9/9] batman-adv: Add inconsistent multicast
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
To: b.a.t.m.a.n@lists.open-mesh.org

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
---
 net/batman-adv/multicast.c | 51 +++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 86725d79..69244e45 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1365,22 +1365,26 @@ int batadv_mcast_mesh_info_put(struct sk_buff *msg,
  *  to a netlink socket
  * @msg: buffer for the message
  * @portid: netlink port
- * @seq: Sequence number of netlink message
+ * @cb: Control block containing additional options
  * @orig_node: originator to dump the multicast flags of
  *
  * Return: 0 or error code.
  */
 static int
-batadv_mcast_flags_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+batadv_mcast_flags_dump_entry(struct sk_buff *msg, u32 portid,
+			      struct netlink_callback *cb,
 			      struct batadv_orig_node *orig_node)
 {
 	void *hdr;
 
-	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
-			  NLM_F_MULTI, BATADV_CMD_GET_MCAST_FLAGS);
+	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
+			  &batadv_netlink_family, NLM_F_MULTI,
+			  BATADV_CMD_GET_MCAST_FLAGS);
 	if (!hdr)
 		return -ENOBUFS;
 
+	genl_dump_check_consistent(cb, hdr);
+
 	if (nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN,
 		    orig_node->orig)) {
 		genlmsg_cancel(msg, hdr);
@@ -1405,21 +1409,26 @@ batadv_mcast_flags_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
  *  table to a netlink socket
  * @msg: buffer for the message
  * @portid: netlink port
- * @seq: Sequence number of netlink message
- * @head: bucket to dump
+ * @cb: Control block containing additional options
+ * @hash: hash to dump
+ * @bucket: bucket index to dump
  * @idx_skip: How many entries to skip
  *
  * Return: 0 or error code.
  */
 static int
-batadv_mcast_flags_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
-			       struct hlist_head *head, long *idx_skip)
+batadv_mcast_flags_dump_bucket(struct sk_buff *msg, u32 portid,
+			       struct netlink_callback *cb,
+			       struct batadv_hashtable *hash,
+			       unsigned int bucket, long *idx_skip)
 {
 	struct batadv_orig_node *orig_node;
 	long idx = 0;
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
+	spin_lock_bh(&hash->list_locks[bucket]);
+	cb->seq = atomic_read(&hash->generation) << 1 | 1;
+
+	hlist_for_each_entry(orig_node, &hash->table[bucket], hash_entry) {
 		if (!test_bit(BATADV_ORIG_CAPA_HAS_MCAST,
 			      &orig_node->capa_initialized))
 			continue;
@@ -1427,9 +1436,8 @@ batadv_mcast_flags_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 		if (idx < *idx_skip)
 			goto skip;
 
-		if (batadv_mcast_flags_dump_entry(msg, portid, seq,
-						  orig_node)) {
-			rcu_read_unlock();
+		if (batadv_mcast_flags_dump_entry(msg, portid, cb, orig_node)) {
+			spin_unlock_bh(&hash->list_locks[bucket]);
 			*idx_skip = idx;
 
 			return -EMSGSIZE;
@@ -1438,7 +1446,7 @@ batadv_mcast_flags_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 skip:
 		idx++;
 	}
-	rcu_read_unlock();
+	spin_unlock_bh(&hash->list_locks[bucket]);
 
 	return 0;
 }
@@ -1447,7 +1455,7 @@ batadv_mcast_flags_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
  * __batadv_mcast_flags_dump() - dump multicast flags table to a netlink socket
  * @msg: buffer for the message
  * @portid: netlink port
- * @seq: Sequence number of netlink message
+ * @cb: Control block containing additional options
  * @bat_priv: the bat priv with all the soft interface information
  * @bucket: current bucket to dump
  * @idx: index in current bucket to the next entry to dump
@@ -1455,19 +1463,17 @@ batadv_mcast_flags_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
  * Return: 0 or error code.
  */
 static int
-__batadv_mcast_flags_dump(struct sk_buff *msg, u32 portid, u32 seq,
+__batadv_mcast_flags_dump(struct sk_buff *msg, u32 portid,
+			  struct netlink_callback *cb,
 			  struct batadv_priv *bat_priv, long *bucket, long *idx)
 {
 	struct batadv_hashtable *hash = bat_priv->orig_hash;
 	long bucket_tmp = *bucket;
-	struct hlist_head *head;
 	long idx_tmp = *idx;
 
 	while (bucket_tmp < hash->size) {
-		head = &hash->table[bucket_tmp];
-
-		if (batadv_mcast_flags_dump_bucket(msg, portid, seq, head,
-						   &idx_tmp))
+		if (batadv_mcast_flags_dump_bucket(msg, portid, cb, hash,
+						   *bucket, &idx_tmp))
 			break;
 
 		bucket_tmp++;
@@ -1550,8 +1556,7 @@ int batadv_mcast_flags_dump(struct sk_buff *msg, struct netlink_callback *cb)
 		return ret;
 
 	bat_priv = netdev_priv(primary_if->soft_iface);
-	ret = __batadv_mcast_flags_dump(msg, portid, cb->nlh->nlmsg_seq,
-					bat_priv, bucket, idx);
+	ret = __batadv_mcast_flags_dump(msg, portid, cb, bat_priv, bucket, idx);
 
 	batadv_hardif_put(primary_if);
 	return ret;
-- 
2.19.1

