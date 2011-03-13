Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 13 Mar 2011 20:52:23 +0100
Message-Id: <1300045945-28734-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1300045945-28734-1-git-send-email-linus.luessing@web.de>
References: <1300045945-28734-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Simplify gw_check_election(),
	use gw_get_selected()
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

gw_get_selected() can get us the desired orig_node directly, therefore
reusing that function in gw_check_election().

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 gateway_client.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/batman-adv/gateway_client.c b/batman-adv/gateway_client.c
index 27b87ad..879ac15 100644
--- a/batman-adv/gateway_client.c
+++ b/batman-adv/gateway_client.c
@@ -23,6 +23,7 @@
 #include "gateway_client.h"
 #include "gateway_common.h"
 #include "hard-interface.h"
+#include "originator.h"
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/udp.h>
@@ -203,28 +204,25 @@ void gw_election(struct bat_priv *bat_priv)
 
 void gw_check_election(struct bat_priv *bat_priv, struct orig_node *orig_node)
 {
-	struct gw_node *curr_gateway_tmp;
+	struct orig_node *curr_gw_orig;
 	uint8_t gw_tq_avg, orig_tq_avg;
 
+	curr_gw_orig = gw_get_selected(bat_priv);
+	if (!curr_gw_orig)
+		goto deselect;
+
 	rcu_read_lock();
-	curr_gateway_tmp = rcu_dereference(bat_priv->curr_gw);
-	if (!curr_gateway_tmp)
-		goto out_rcu;
-
-	if (!curr_gateway_tmp->orig_node)
-		goto deselect_rcu;
-
-	if (!curr_gateway_tmp->orig_node->router)
+	if (!curr_gw_orig->router)
 		goto deselect_rcu;
 
 	/* this node already is the gateway */
-	if (curr_gateway_tmp->orig_node == orig_node)
+	if (curr_gw_orig == orig_node)
 		goto out_rcu;
 
 	if (!orig_node->router)
 		goto out_rcu;
 
-	gw_tq_avg = curr_gateway_tmp->orig_node->router->tq_avg;
+	gw_tq_avg = curr_gw_orig->router->tq_avg;
 	rcu_read_unlock();
 
 	orig_tq_avg = orig_node->router->tq_avg;
@@ -255,6 +253,9 @@ deselect_rcu:
 deselect:
 	gw_deselect(bat_priv);
 out:
+	if (curr_gw_orig)
+		orig_node_free_ref(curr_gw_orig);
+
 	return;
 }
 
-- 
1.7.4.1

