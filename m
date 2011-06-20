Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Jun 2011 12:17:04 +0200
Message-Id: <1308565025-21293-12-git-send-email-sven@narfation.org>
In-Reply-To: <1308565025-21293-1-git-send-email-sven@narfation.org>
References: <1308565025-21293-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 11/12] batman-adv: throw uevent in userspace
	on gateway add/change/del event
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Antonio Quartulli <ordex@autistici.org>

In case of new default gw, changing the default gw or deleting the default gw a
uevent is triggered with type=gw, action=add/change/del and
data={GW_ORIG_ADDRESS} (if any).

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_client.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 0350c0c..6381864 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -179,6 +179,7 @@ void gw_election(struct bat_priv *bat_priv)
 {
 	struct gw_node *curr_gw = NULL, *next_gw = NULL;
 	struct neigh_node *router = NULL;
+	char gw_addr[18] = { '\0' };
 
 	/**
 	 * The batman daemon checks here if we already passed a full originator
@@ -200,6 +201,8 @@ void gw_election(struct bat_priv *bat_priv)
 		goto out;
 
 	if (next_gw) {
+		sprintf(gw_addr, "%pM", next_gw->orig_node->orig);
+
 		router = orig_node_get_router(next_gw->orig_node);
 		if (!router) {
 			gw_deselect(bat_priv);
@@ -210,12 +213,14 @@ void gw_election(struct bat_priv *bat_priv)
 	if ((curr_gw) && (!next_gw)) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Removing selected gateway - no gateway in range\n");
+		throw_uevent(bat_priv, UEV_GW, UEV_DEL, NULL);
 	} else if ((!curr_gw) && (next_gw)) {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Adding route to gateway %pM (gw_flags: %i, tq: %i)\n",
 			next_gw->orig_node->orig,
 			next_gw->orig_node->gw_flags,
 			router->tq_avg);
+		throw_uevent(bat_priv, UEV_GW, UEV_ADD, gw_addr);
 	} else {
 		bat_dbg(DBG_BATMAN, bat_priv,
 			"Changing route to gateway %pM "
@@ -223,6 +228,7 @@ void gw_election(struct bat_priv *bat_priv)
 			next_gw->orig_node->orig,
 			next_gw->orig_node->gw_flags,
 			router->tq_avg);
+		throw_uevent(bat_priv, UEV_GW, UEV_CHANGE, gw_addr);
 	}
 
 	gw_select(bat_priv, next_gw);
-- 
1.7.5.3

