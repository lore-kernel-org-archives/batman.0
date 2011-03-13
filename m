Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 13 Mar 2011 20:52:22 +0100
Message-Id: <1300045945-28734-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1300045945-28734-1-git-send-email-linus.luessing@web.de>
References: <1300045945-28734-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Make gateway_get_selected
	type safe
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

Make the return value explicit instead of (void *).

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 gateway_client.c |    2 +-
 gateway_client.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 3cc4355..27b87ad 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -42,7 +42,7 @@ static void gw_node_free_ref(struct gw_node *gw_node)
 		call_rcu(&gw_node->rcu, gw_node_free_rcu);
 }
 
-void *gw_get_selected(struct bat_priv *bat_priv)
+struct orig_node *gw_get_selected(struct bat_priv *bat_priv)
 {
 	struct gw_node *curr_gateway_tmp;
 	struct orig_node *orig_node = NULL;
diff --git a/batman-adv/gateway_client.h b/batman-adv/gateway_client.h
index 2aa4391..97c31d1 100644
--- a/batman-adv/gateway_client.h
+++ b/batman-adv/gateway_client.h
@@ -24,7 +24,7 @@
 
 void gw_deselect(struct bat_priv *bat_priv);
 void gw_election(struct bat_priv *bat_priv);
-void *gw_get_selected(struct bat_priv *bat_priv);
+struct orig_node *gw_get_selected(struct bat_priv *bat_priv);
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node);
 void gw_node_update(struct bat_priv *bat_priv,
 		    struct orig_node *orig_node, uint8_t new_gwflags);
-- 
1.7.4.1

