Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 10 Aug 2013 12:57:27 +0200
Message-Id: <1376132247-687-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: properly print the VID in DAT
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
Cc: Antonio Quartulli <ordex@autistici.org>

Make the DAT code use the PRINT_VID macro to print the VIDs.

Introduced by 3e26722bc9f248ec4316749fc1957365c0fa5e4b
("batman-adv: make the Distributed ARP Table vlan aware")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 081c1af..df65f8c 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -282,8 +282,9 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
 		dat_entry->last_update = jiffies;
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
-			   "Entry updated: %pI4 %pM (vid: %u)\n",
-			   &dat_entry->ip, dat_entry->mac_addr, vid);
+			   "Entry updated: %pI4 %pM (vid: %d)\n",
+			   &dat_entry->ip, dat_entry->mac_addr,
+			   BATADV_PRINT_VID(vid));
 		goto out;
 	}
 
@@ -307,8 +308,8 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 		goto out;
 	}
 
-	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %u)\n",
-		   &dat_entry->ip, dat_entry->mac_addr, vid);
+	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %d)\n",
+		   &dat_entry->ip, dat_entry->mac_addr, BATADV_PRINT_VID(vid));
 
 out:
 	if (dat_entry)
-- 
1.8.1.5

