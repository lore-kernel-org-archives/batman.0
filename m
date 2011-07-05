Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  5 Jul 2011 17:23:03 +0200
Message-Id: <1309879385-21224-5-git-send-email-ordex@autistici.org>
In-Reply-To: <1309879385-21224-1-git-send-email-ordex@autistici.org>
References: <1309879385-21224-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: mark local entry as PENDING
	in case of deletion
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

In case of deletion of a local entry, it has to be merked as "pending to
be removed" but has to be kept in the table in order to send it within a
full table response issued before the next ttvn increment.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 packet.h            |    3 ++-
 translation-table.c |   13 +++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/packet.h b/packet.h
index 590e4a6..87b371d 100644
--- a/packet.h
+++ b/packet.h
@@ -84,7 +84,8 @@ enum tt_query_flags {
 enum tt_client_flags {
 	TT_CLIENT_DEL     = 1 << 0,
 	TT_CLIENT_ROAM    = 1 << 1,
-	TT_CLIENT_NOPURGE = 1 << 8
+	TT_CLIENT_NOPURGE = 1 << 8,
+	TT_CLIENT_PENDING = 1 << 9
 };
 
 struct batman_packet {
diff --git a/translation-table.c b/translation-table.c
index 5570e58..cf26ee3 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -386,10 +386,11 @@ void tt_local_remove(struct bat_priv *bat_priv, const uint8_t *addr,
 	tt_local_event(bat_priv, tt_local_entry->addr,
 		       tt_local_entry->flags | TT_CLIENT_DEL |
 		       (roaming ? TT_CLIENT_ROAM : NO_FLAGS));
-	tt_local_del(bat_priv, tt_local_entry, message);
-out:
-	if (tt_local_entry)
-		tt_local_entry_free_ref(tt_local_entry);
+
+	/* The local client has to be merked as "pending to be removed" but has
+	 * to be kept in the table in order to send it in an full tables
+	 * response issued before the net ttvn increment (consistency check) */
+	tt_local_entry->flags |= TT_CLIENT_PENDING;
 }
 
 static void tt_local_purge(struct bat_priv *bat_priv)
@@ -1411,6 +1412,10 @@ bool is_my_client(struct bat_priv *bat_priv, const uint8_t *addr)
 	tt_local_entry = tt_local_hash_find(bat_priv, addr);
 	if (!tt_local_entry)
 		goto out;
+	/* Check if the client has been logically deleted (but is kept for
+	 * consistency purpose) */
+	if (tt_local_entry->flags & TT_CLIENT_PENDING)
+		goto out;
 	ret = true;
 out:
 	if (tt_local_entry)
-- 
1.7.3.4

