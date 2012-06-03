Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jun 2012 22:19:10 +0200
Message-Id: <1338754762-28424-4-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-1-git-send-email-sven@narfation.org>
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 04/16] batman-adv: Prefix
	bridge_loop_avoidance defines with BATADV_
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
To: b.a.t.m.a.n@lists.open-mesh.org

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |    4 ++--
 bridge_loop_avoidance.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 0592d2b..42b8a20 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -237,7 +237,7 @@ static void batadv_bla_del_backbone_claims(struct backbone_gw *backbone_gw)
 	}
 
 	/* all claims gone, intialize CRC */
-	backbone_gw->crc = BLA_CRC_INIT;
+	backbone_gw->crc = BATADV_BLA_CRC_INIT;
 }
 
 /* @bat_priv: the bat priv with all the soft interface information
@@ -375,7 +375,7 @@ static struct backbone_gw *batadv_bla_get_backbone_gw(struct bat_priv *bat_priv,
 
 	entry->vid = vid;
 	entry->lasttime = jiffies;
-	entry->crc = BLA_CRC_INIT;
+	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
 	atomic_set(&entry->request_sent, 0);
 	memcpy(entry->orig, orig, ETH_ALEN);
diff --git a/bridge_loop_avoidance.h b/bridge_loop_avoidance.h
index 9818b1e..58563f0 100644
--- a/bridge_loop_avoidance.h
+++ b/bridge_loop_avoidance.h
@@ -36,7 +36,7 @@ void batadv_bla_update_orig_address(struct bat_priv *bat_priv,
 int batadv_bla_init(struct bat_priv *bat_priv);
 void batadv_bla_free(struct bat_priv *bat_priv);
 
-#define BLA_CRC_INIT	0
+#define BATADV_BLA_CRC_INIT	0
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
 
 static inline int batadv_bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb,
-- 
1.7.10

