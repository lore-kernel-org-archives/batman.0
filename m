Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 27 Jun 2011 01:14:54 +0200
Message-Id: <1309130094-12861-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: TT_RESPONSE with full table must
	contain only announced clients
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

In case of TT_RESPONSE containing a full table, only clients already
announced can be sent. Therefore, clients added after the last OGM
sending must not be sent.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   12 +++++++++++-
 types.h             |    1 +
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 4208dc7..6382955 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -211,6 +211,7 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 
 	memcpy(tt_local_entry->addr, addr, ETH_ALEN);
 	tt_local_entry->last_seen = jiffies;
+	tt_local_entry->ttvn = (uint8_t)(atomic_read(&bat_priv->ttvn) + 1);
 	tt_local_entry->flags = NO_FLAGS;
 	atomic_set(&tt_local_entry->refcount, 2);
 
@@ -936,6 +937,14 @@ unlock:
 	return tt_req_node;
 }
 
+static int tt_local_valid_entry(const void *entry_ptr, const void *data_ptr)
+{
+	const struct tt_local_entry *tt_local_entry = entry_ptr;
+	const struct bat_priv *bat_priv = data_ptr;
+
+	return (tt_local_entry->ttvn <= (uint8_t)atomic_read(&bat_priv->ttvn));
+}
+
 static int tt_global_valid_entry(const void *entry_ptr, const void *data_ptr)
 {
 	const struct tt_global_entry *tt_global_entry = entry_ptr;
@@ -1276,7 +1285,8 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 
 		skb = tt_response_fill_table(tt_len, ttvn,
 					     bat_priv->tt_local_hash,
-					     primary_if, NULL, NULL);
+					     primary_if, tt_local_valid_entry,
+					     bat_priv);
 		if (!skb)
 			goto out;
 
diff --git a/types.h b/types.h
index 582283a..b470c67 100644
--- a/types.h
+++ b/types.h
@@ -224,6 +224,7 @@ struct socket_packet {
 struct tt_local_entry {
 	uint8_t addr[ETH_ALEN];
 	unsigned long last_seen;
+	uint8_t ttvn;
 	uint8_t flags;
 	atomic_t refcount;
 	struct rcu_head rcu;
-- 
1.7.3.4

