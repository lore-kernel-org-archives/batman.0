Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 17 Oct 2012 14:53:05 +0200
Message-Id: <1350478385-676-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1350478385-676-1-git-send-email-linus.luessing@web.de>
References: <1350478385-676-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Fix potential broadcast
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
To: b.a.t.m.a.n@lists.open-mesh.org

Threads in the bottom half of batadv_bla_check_bcast_duplist() might
otherwise for instance overwrite variables which other threads might
be using/reading at the same time in the top half, potentially
leading to messing up the bcast_duplist, possibly resulting in false
bridge loop avoidance duplicate check decisions.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
Note: I didn't observe such issues yet, probably because of the 
usually quite low broadcast data throughput - and on high broadcast
throughput, then packet loss is usually caused by the limited capacity
for broadcast packets on 802.11 media anyway.

 bridge_loop_avoidance.c |   16 +++++++++++-----
 main.c                  |    1 +
 types.h                 |    2 ++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index b828875..c6c1c59 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1263,7 +1263,7 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				   struct batadv_bcast_packet *bcast_packet,
 				   int bcast_packet_len)
 {
-	int i, length, curr;
+	int i, length, curr, ret = 0;
 	uint8_t *content;
 	uint16_t crc;
 	struct batadv_bcast_duplist_entry *entry;
@@ -1275,6 +1275,8 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 	/* calculate the crc ... */
 	crc = crc16(0, content, length);
 
+	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
+
 	for (i = 0; i < BATADV_DUPLIST_SIZE; i++) {
 		curr = (bat_priv->bla.bcast_duplist_curr + i);
 		curr %= BATADV_DUPLIST_SIZE;
@@ -1296,9 +1298,11 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 		/* this entry seems to match: same crc, not too old,
 		 * and from another gw. therefore return 1 to forbid it.
 		 */
-		return 1;
+		ret = 1;
+		goto out;
 	}
-	/* not found, add a new entry (overwrite the oldest entry) */
+	/* not found, add a new entry (overwrite the oldest entry)
+	 * and allow it, its the first occurence. */
 	curr = (bat_priv->bla.bcast_duplist_curr + BATADV_DUPLIST_SIZE - 1);
 	curr %= BATADV_DUPLIST_SIZE;
 	entry = &bat_priv->bla.bcast_duplist[curr];
@@ -1307,8 +1311,10 @@ int batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 	memcpy(entry->orig, bcast_packet->orig, ETH_ALEN);
 	bat_priv->bla.bcast_duplist_curr = curr;
 
-	/* allow it, its the first occurence. */
-	return 0;
+out:
+	spin_unlock_bh(&bat_priv->bla.bcast_duplist_lock);
+
+	return ret;
 }
 
 
diff --git a/main.c b/main.c
index 70797de..f54efe9 100644
--- a/main.c
+++ b/main.c
@@ -102,6 +102,7 @@ int batadv_mesh_init(struct net_device *soft_iface)
 	spin_lock_init(&bat_priv->gw.list_lock);
 	spin_lock_init(&bat_priv->vis.hash_lock);
 	spin_lock_init(&bat_priv->vis.list_lock);
+	spin_lock_init(&bat_priv->bla.bcast_duplist_lock);
 
 	INIT_HLIST_HEAD(&bat_priv->forw_bat_list);
 	INIT_HLIST_HEAD(&bat_priv->forw_bcast_list);
diff --git a/types.h b/types.h
index 8a5d84c..7b3d0d7 100644
--- a/types.h
+++ b/types.h
@@ -228,6 +228,8 @@ struct batadv_priv_bla {
 	struct batadv_hashtable *backbone_hash;
 	struct batadv_bcast_duplist_entry bcast_duplist[BATADV_DUPLIST_SIZE];
 	int bcast_duplist_curr;
+	/* protects bcast_duplist and bcast_duplist_curr */
+	spinlock_t bcast_duplist_lock;
 	struct batadv_bla_claim_dst claim_dest;
 	struct delayed_work work;
 };
-- 
1.7.10.4

