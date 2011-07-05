Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  5 Jul 2011 17:23:02 +0200
Message-Id: <1309879385-21224-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1309879385-21224-1-git-send-email-ordex@autistici.org>
References: <1309879385-21224-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: full table response must not
	contain not yet announced clients
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

To keep transtable consistency among all the nodes, an originator must
not send not yet announced clients within a full table tt_response.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 0f5219e..5570e58 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -210,6 +210,11 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr)
 
 	tt_local_event(bat_priv, addr, tt_local_entry->flags);
 
+	/* The local entry has to be marked as ROAMING to avoid to send it in
+	 * a full table response going out before the next ttvn increment
+	 * (consistency check) */
+	tt_local_entry->flags |= TT_CLIENT_ROAM;
+
 	hash_add(bat_priv->tt_local_hash, compare_ltt, choose_orig,
 		 tt_local_entry, &tt_local_entry->hash_entry);
 
@@ -930,6 +935,16 @@ unlock:
 	return tt_req_node;
 }
 
+/* data_ptr is useless here, but has to be kept to respect the prototype */
+static int tt_local_valid_entry(const void *entry_ptr, const void *data_ptr)
+{
+	const struct tt_local_entry *tt_local_entry = entry_ptr;
+
+	if (tt_local_entry->flags & TT_CLIENT_ROAM)
+		return 0;
+	return 1;
+}
+
 static int tt_global_valid_entry(const void *entry_ptr, const void *data_ptr)
 {
 	const struct tt_global_entry *tt_global_entry = entry_ptr;
@@ -1270,7 +1285,8 @@ static bool send_my_tt_response(struct bat_priv *bat_priv,
 
 		skb = tt_response_fill_table(tt_len, ttvn,
 					     bat_priv->tt_local_hash,
-					     primary_if, NULL, NULL);
+					     primary_if, tt_local_valid_entry,
+					     NULL);
 		if (!skb)
 			goto out;
 
-- 
1.7.3.4

