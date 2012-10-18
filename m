Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 18 Oct 2012 21:24:55 +0200
Message-Id: <1350588295-22587-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1350588295-22587-1-git-send-email-ordex@autistici.org>
References: <1350588295-22587-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix potential broadcast
	BLA-duplicate-check race condition
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Linus Lüssing <linus.luessing@web.de>

Threads in the bottom half of batadv_bla_check_bcast_duplist() might
otherwise for instance overwrite variables which other threads might
be using/reading at the same time in the top half, potentially
leading to messing up the bcast_duplist, possibly resulting in false
bridge loop avoidance duplicate check decisions.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 19 ++++++++++++++-----
 net/batman-adv/types.h                 |  2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index eebab20..fd8d5af 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1167,6 +1167,8 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	uint16_t crc;
 	unsigned long entrytime;
 
+	spin_lock_init(&bat_priv->bla.bcast_duplist_lock);
+
 	batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla hash registering\n");
 
 	/* setting claim destination address */
@@ -1226,7 +1228,7 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				   struct batadv_bcast_packet *bcast_packet,
 				   int bcast_packet_len)
 {
-	int i, length, curr;
+	int i, length, curr, ret = 0;
 	uint8_t *content;
 	uint16_t crc;
 	struct batadv_bcast_duplist_entry *entry;
@@ -1238,6 +1240,8 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 	/* calculate the crc ... */
 	crc = crc16(0, content, length);
 
+	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
+
 	for (i = 0; i < BATADV_DUPLIST_SIZE; i++) {
 		curr = (bat_priv->bla.bcast_duplist_curr + i);
 		curr %= BATADV_DUPLIST_SIZE;
@@ -1259,9 +1263,12 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 		/* this entry seems to match: same crc, not too old,
 		 * and from another gw. therefore return 1 to forbid it.
 		 */
-		return 1;
+		ret = 1;
+		goto out;
 	}
-	/* not found, add a new entry (overwrite the oldest entry) */
+	/* not found, add a new entry (overwrite the oldest entry)
+	 * and allow it, its the first occurence.
+	 */
 	curr = (bat_priv->bla.bcast_duplist_curr + BATADV_DUPLIST_SIZE - 1);
 	curr %= BATADV_DUPLIST_SIZE;
 	entry = &bat_priv->bla.bcast_duplist[curr];
@@ -1270,8 +1277,10 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 	memcpy(entry->orig, bcast_packet->orig, ETH_ALEN);
 	bat_priv->bla.bcast_duplist_curr = curr;
 
-	/* allow it, its the first occurence. */
-	return 0;
+out:
+	spin_unlock_bh(&bat_priv->bla.bcast_duplist_lock);
+
+	return ret;
 }
 
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 2ed82ca..ac1e07a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -205,6 +205,8 @@ struct batadv_priv_bla {
 	struct batadv_hashtable *backbone_hash;
 	struct batadv_bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
 	int bcast_duplist_curr;
+	/* protects bcast_duplist and bcast_duplist_curr */
+	spinlock_t bcast_duplist_lock;
 	struct batadv_bla_claim_dst claim_dest;
 	struct delayed_work work;
 };
-- 
1.7.12.3

