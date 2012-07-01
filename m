Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  2 Jul 2012 01:43:43 +0200
Message-Id: <1341186226-10549-14-git-send-email-ordex@autistici.org>
In-Reply-To: <1341186226-10549-1-git-send-email-ordex@autistici.org>
References: <1341186226-10549-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 13/16] batman-adv: Remove space before
	semicolon
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/hash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 0759c70..15a849c 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -25,7 +25,7 @@ static void batadv_hash_init(struct batadv_hashtable *hash)
 {
 	uint32_t i;
 
-	for (i = 0 ; i < hash->size; i++) {
+	for (i = 0; i < hash->size; i++) {
 		INIT_HLIST_HEAD(&hash->table[i]);
 		spin_lock_init(&hash->list_locks[i]);
 	}
-- 
1.7.9.4

