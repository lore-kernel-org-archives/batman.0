Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 30 Oct 2018 22:01:27 +0100
Message-Id: <20181030210130.18152-7-sven@narfation.org>
In-Reply-To: <20181030210130.18152-1-sven@narfation.org>
References: <20181030210130.18152-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 6/9] batman-adv: Add inconsistent claim
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
 net/batman-adv/bridge_loop_avoidance.c | 41 +++++++++++++++-----------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 9f374734..5fdde294 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2094,14 +2094,15 @@ int batadv_bla_claim_table_seq_print_text(struct seq_file *seq, void *offset)
  * to a netlink socket
  * @msg: buffer for the message
  * @portid: netlink port
- * @seq: Sequence number of netlink message
+ * @cb: Control block containing additional options
  * @primary_if: primary interface
  * @claim: entry to dump
  *
  * Return: 0 or error code.
  */
 static int
-batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
+			    struct netlink_callback *cb,
 			    struct batadv_hard_iface *primary_if,
 			    struct batadv_bla_claim *claim)
 {
@@ -2111,13 +2112,16 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
 	void *hdr;
 	int ret = -EINVAL;
 
-	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
-			  NLM_F_MULTI, BATADV_CMD_GET_BLA_CLAIM);
+	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
+			  &batadv_netlink_family, NLM_F_MULTI,
+			  BATADV_CMD_GET_BLA_CLAIM);
 	if (!hdr) {
 		ret = -ENOBUFS;
 		goto out;
 	}
 
+	genl_dump_check_consistent(cb, hdr);
+
 	is_own = batadv_compare_eth(claim->backbone_gw->orig,
 				    primary_addr);
 
@@ -2153,28 +2157,33 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
  * to a netlink socket
  * @msg: buffer for the message
  * @portid: netlink port
- * @seq: Sequence number of netlink message
+ * @cb: Control block containing additional options
  * @primary_if: primary interface
- * @head: bucket to dump
+ * @hash: hash to dump
+ * @bucket: bucket index to dump
  * @idx_skip: How many entries to skip
  *
  * Return: always 0.
  */
 static int
-batadv_bla_claim_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
+batadv_bla_claim_dump_bucket(struct sk_buff *msg, u32 portid,
+			     struct netlink_callback *cb,
 			     struct batadv_hard_iface *primary_if,
-			     struct hlist_head *head, int *idx_skip)
+			     struct batadv_hashtable *hash, unsigned int bucket,
+			     int *idx_skip)
 {
 	struct batadv_bla_claim *claim;
 	int idx = 0;
 	int ret = 0;
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(claim, head, hash_entry) {
+	spin_lock_bh(&hash->list_locks[bucket]);
+	cb->seq = atomic_read(&hash->generation) << 1 | 1;
+
+	hlist_for_each_entry(claim, &hash->table[bucket], hash_entry) {
 		if (idx++ < *idx_skip)
 			continue;
 
-		ret = batadv_bla_claim_dump_entry(msg, portid, seq,
+		ret = batadv_bla_claim_dump_entry(msg, portid, cb,
 						  primary_if, claim);
 		if (ret) {
 			*idx_skip = idx - 1;
@@ -2184,7 +2193,7 @@ batadv_bla_claim_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 
 	*idx_skip = 0;
 unlock:
-	rcu_read_unlock();
+	spin_unlock_bh(&hash->list_locks[bucket]);
 	return ret;
 }
 
@@ -2204,7 +2213,6 @@ int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	struct batadv_hashtable *hash;
 	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
-	struct hlist_head *head;
 	int idx = cb->args[1];
 	int ifindex;
 	int ret = 0;
@@ -2230,11 +2238,8 @@ int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	}
 
 	while (bucket < hash->size) {
-		head = &hash->table[bucket];
-
-		if (batadv_bla_claim_dump_bucket(msg, portid,
-						 cb->nlh->nlmsg_seq,
-						 primary_if, head, &idx))
+		if (batadv_bla_claim_dump_bucket(msg, portid, cb, primary_if,
+						 hash, bucket, &idx))
 			break;
 		bucket++;
 	}
-- 
2.19.1

