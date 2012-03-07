Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed,  7 Mar 2012 09:07:51 +0100
Message-Id: <1331107673-8986-7-git-send-email-sven@narfation.org>
In-Reply-To: <1331107673-8986-1-git-send-email-sven@narfation.org>
References: <7238641.4aX8WvziBv@sven-laptop.home.narfation.org>
	<1331107673-8986-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 7/8-master] batman-adv: Use {} braces
	consistent on the arms of a statement
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bridge_loop_avoidance.c |    3 ++-
 translation-table.c     |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index 1d6fb77..da220cf 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -1142,8 +1142,9 @@ int bla_init(struct bat_priv *bat_priv)
 			htons(crc16(0, primary_if->net_dev->dev_addr,
 				    ETH_ALEN));
 		hardif_free_ref(primary_if);
-	} else
+	} else {
 		bat_priv->claim_dest.group = 0; /* will be set later */
+	}
 
 	/* initialize the duplicate list */
 	for (i = 0; i < DUPLIST_SIZE; i++)
diff --git a/translation-table.c b/translation-table.c
index cdc7322..b889806 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1618,8 +1618,9 @@ bool send_tt_response(struct bat_priv *bat_priv,
 			return true;
 
 		return send_my_tt_response(bat_priv, tt_request);
-	} else
+	} else {
 		return send_other_tt_response(bat_priv, tt_request);
+	}
 }
 
 static void _tt_update_changes(struct bat_priv *bat_priv,
-- 
1.7.9.1

