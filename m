Return-Path: <sven@open-mesh.com>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue,  3 Nov 2015 10:05:44 +0100
Message-Id: <1446541544-7647-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Fix invalid stack access in
	batadv_dat_select_candidates
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
Cc: Sven Eckelmann <sven@open-mesh.com>

batadv_dat_select_candidates provides an u32 to batadv_hash_dat but it
needs a batadv_dat_entry with at least ip and vid filled in.

Fixes: 3e26722bc9f2 ("batman-adv: make the Distributed ARP Table vlan aware")
Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
Acked-by: Antonio Quartulli <antonio@meshcoding.com>
---
v2: Send with @open-mesh.com address for correct sponsor attribution

 net/batman-adv/distributed-arp-table.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 7d75e67..79b9993 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -566,6 +566,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	int select;
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
 	struct batadv_dat_candidate *res;
+	struct batadv_dat_entry dat;
 
 	if (!bat_priv->orig_hash)
 		return NULL;
@@ -575,7 +576,9 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	if (!res)
 		return NULL;
 
-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
+	dat.ip = ip_dst;
+	dat.vid = 0;
+	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&dat,
 						    BATADV_DAT_ADDR_MAX);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
-- 
2.6.2

