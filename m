Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 11 Dec 2012 20:29:22 +0100
Message-Id: <1355254162-6123-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix typo in debug message
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

in bat_iv_ogm.c a debug message should print "tq" instead of "td"

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 2efc50f..55857c2 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1050,7 +1050,7 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		is_single_hop_neigh = true;
 
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-		   "Received BATMAN packet via NB: %pM, IF: %s [%pM] (from OG: %pM, via prev OG: %pM, seqno %u, ttvn %u, crc %#.4x, changes %u, td %d, TTL %d, V %d, IDF %d)\n",
+		   "Received BATMAN packet via NB: %pM, IF: %s [%pM] (from OG: %pM, via prev OG: %pM, seqno %u, ttvn %u, crc %#.4x, changes %u, tq %d, TTL %d, V %d, IDF %d)\n",
 		   ethhdr->h_source, if_incoming->net_dev->name,
 		   if_incoming->net_dev->dev_addr, batadv_ogm_packet->orig,
 		   batadv_ogm_packet->prev_sender,
-- 
1.8.0

