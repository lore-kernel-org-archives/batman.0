Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  7 Nov 2013 08:02:07 +0100
Message-Id: <1383807727-662-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: remove parenthesis from
	return statements
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Remove parenthesis around return expression as suggested by
checkpatch.

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 distributed-arp-table.c | 2 +-
 main.h                  | 2 +-
 originator.c            | 2 +-
 translation-table.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 6c8c393..1ef2f79 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -141,7 +141,7 @@ static int batadv_compare_dat(const struct hlist_node *node, const void *data2)
 	const void *data1 = container_of(node, struct batadv_dat_entry,
 					 hash_entry);
 
-	return (memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0);
+	return memcmp(data1, data2, sizeof(__be32)) == 0 ? 1 : 0;
 }
 
 /**
diff --git a/main.h b/main.h
index c5d6eb2..1403f52 100644
--- a/main.h
+++ b/main.h
@@ -267,7 +267,7 @@ static inline void batadv_dbg(int type __always_unused,
  */
 static inline int batadv_compare_eth(const void *data1, const void *data2)
 {
-	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
+	return memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0;
 }
 
 /**
diff --git a/originator.c b/originator.c
index 8ab1434..8c1de1b 100644
--- a/originator.c
+++ b/originator.c
@@ -41,7 +41,7 @@ int batadv_compare_orig(const struct hlist_node *node, const void *data2)
 	const void *data1 = container_of(node, struct batadv_orig_node,
 					 hash_entry);
 
-	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
+	return memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0;
 }
 
 /**
diff --git a/translation-table.c b/translation-table.c
index 4add57d..4be5ee1 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -51,7 +51,7 @@ static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
 	const void *data1 = container_of(node, struct batadv_tt_common_entry,
 					 hash_entry);
 
-	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
+	return memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0;
 }
 
 /**
-- 
1.8.4.2

