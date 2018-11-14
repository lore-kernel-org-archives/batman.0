Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 15:08:00 +0100
Message-Id: <20181114140804.18381-13-sw@simonwunderlich.de>
In-Reply-To: <20181114140804.18381-1-sw@simonwunderlich.de>
References: <20181114140804.18381-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 12/16] batman-adv: Add inconsistent dat
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
 net/batman-adv/distributed-arp-table.c | 42 +++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a60bacf7120b..b9ffe1826527 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -863,23 +863,27 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
  *  netlink socket
  * @msg: buffer for the message
  * @portid: netlink port
- * @seq: Sequence number of netlink message
+ * @cb: Control block containing additional options
  * @dat_entry: entry to dump
  *
  * Return: 0 or error code.
  */
 static int
-batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
+batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
+			    struct netlink_callback *cb,
 			    struct batadv_dat_entry *dat_entry)
 {
 	int msecs;
 	void *hdr;
 
-	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
-			  NLM_F_MULTI, BATADV_CMD_GET_DAT_CACHE);
+	hdr = genlmsg_put(msg, portid, cb->nlh->nlmsg_seq,
+			  &batadv_netlink_family, NLM_F_MULTI,
+			  BATADV_CMD_GET_DAT_CACHE);
 	if (!hdr)
 		return -ENOBUFS;
 
+	genl_dump_check_consistent(cb, hdr);
+
 	msecs = jiffies_to_msecs(jiffies - dat_entry->last_update);
 
 	if (nla_put_in_addr(msg, BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
@@ -901,27 +905,31 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
  *  a netlink socket
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
-batadv_dat_cache_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
-			     struct hlist_head *head, int *idx_skip)
+batadv_dat_cache_dump_bucket(struct sk_buff *msg, u32 portid,
+			     struct netlink_callback *cb,
+			     struct batadv_hashtable *hash, unsigned int bucket,
+			     int *idx_skip)
 {
 	struct batadv_dat_entry *dat_entry;
 	int idx = 0;
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
+	spin_lock_bh(&hash->list_locks[bucket]);
+	cb->seq = atomic_read(&hash->generation) << 1 | 1;
+
+	hlist_for_each_entry(dat_entry, &hash->table[bucket], hash_entry) {
 		if (idx < *idx_skip)
 			goto skip;
 
-		if (batadv_dat_cache_dump_entry(msg, portid, seq,
-						dat_entry)) {
-			rcu_read_unlock();
+		if (batadv_dat_cache_dump_entry(msg, portid, cb, dat_entry)) {
+			spin_unlock_bh(&hash->list_locks[bucket]);
 			*idx_skip = idx;
 
 			return -EMSGSIZE;
@@ -930,7 +938,7 @@ batadv_dat_cache_dump_bucket(struct sk_buff *msg, u32 portid, u32 seq,
 skip:
 		idx++;
 	}
-	rcu_read_unlock();
+	spin_unlock_bh(&hash->list_locks[bucket]);
 
 	return 0;
 }
@@ -951,7 +959,6 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	struct batadv_hashtable *hash;
 	struct batadv_priv *bat_priv;
 	int bucket = cb->args[0];
-	struct hlist_head *head;
 	int idx = cb->args[1];
 	int ifindex;
 	int ret = 0;
@@ -977,10 +984,7 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	}
 
 	while (bucket < hash->size) {
-		head = &hash->table[bucket];
-
-		if (batadv_dat_cache_dump_bucket(msg, portid,
-						 cb->nlh->nlmsg_seq, head,
+		if (batadv_dat_cache_dump_bucket(msg, portid, cb, hash, bucket,
 						 &idx))
 			break;
 
-- 
2.11.0

