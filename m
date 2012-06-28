Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Jun 2012 11:34:20 +0200
Message-Id: <1340876067-28333-12-git-send-email-ordex@autistici.org>
In-Reply-To: <1340876067-28333-1-git-send-email-ordex@autistici.org>
References: <1340876067-28333-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 11/18] batman-adv: Prefix
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bridge_loop_avoidance.c |    4 ++--
 net/batman-adv/bridge_loop_avoidance.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 0592d2b..42b8a20 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
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
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 9818b1e..58563f0 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -36,7 +36,7 @@ void batadv_bla_update_orig_address(struct bat_priv *bat_priv,
 int batadv_bla_init(struct bat_priv *bat_priv);
 void batadv_bla_free(struct bat_priv *bat_priv);
 
-#define BLA_CRC_INIT	0
+#define BATADV_BLA_CRC_INIT	0
 #else /* ifdef CONFIG_BATMAN_ADV_BLA */
 
 static inline int batadv_bla_rx(struct bat_priv *bat_priv, struct sk_buff *skb,
-- 
1.7.9.4

