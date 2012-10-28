Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 28 Oct 2012 12:17:13 +0100
Message-Id: <1351423037-5292-13-git-send-email-ordex@autistici.org>
In-Reply-To: <1351423037-5292-1-git-send-email-ordex@autistici.org>
References: <1351423037-5292-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 12/16] batman-adv: print packets re-routing
	on DBG_TT and ratelimit it
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

To simplify TranslationTable debugging it is better to print the packet
rerouting message on the DBG_TT log level. In this way a developer interested in
packets rerouting doesn't need to filter it out of the whole ROUTES log.

Moreover, since this message will appear for each rerouted message, it is now
"ratelimited".

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/routing.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 1ac072d..456a0a9 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -965,10 +965,10 @@ static int batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 			batadv_orig_node_free_ref(orig_node);
 		}
 
-		batadv_dbg(BATADV_DBG_ROUTES, bat_priv,
-			   "TTVN mismatch (old_ttvn %u new_ttvn %u)! Rerouting unicast packet (for %pM) to %pM\n",
-			   unicast_packet->ttvn, curr_ttvn, ethhdr->h_dest,
-			   unicast_packet->dest);
+		net_ratelimited_function(batadv_dbg, BATADV_DBG_TT, bat_priv,
+					 "TTVN mismatch (old_ttvn %u new_ttvn %u)! Rerouting unicast packet (for %pM) to %pM\n",
+					 unicast_packet->ttvn, curr_ttvn,
+					 ethhdr->h_dest, unicast_packet->dest);
 
 		unicast_packet->ttvn = curr_ttvn;
 	}
-- 
1.7.12.4

