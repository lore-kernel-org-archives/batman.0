Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 22 Aug 2013 09:21:11 +0200
Message-Id: <1377156073-556-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: print the VID in the
	dat_cache output
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

Now that DAT is vlan aware, it should also print the VID
along with the MAC address of each cached entry.

Introduced by: 3e26722bc9f248ec4316749fc1957365c0fa5e4b
("batman-adv: make the Distributed ARP Table vlan aware")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index df65f8c..c825d76 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -761,8 +761,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	seq_printf(seq, "Distributed ARP Table (%s):\n", net_dev->name);
-	seq_printf(seq, "          %-7s          %-13s %5s\n", "IPv4", "MAC",
-		   "last-seen");
+	seq_printf(seq, "          %-7s          %-9s %4s %11s\n", "IPv4",
+		   "MAC", "VID", "last-seen");
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
@@ -775,8 +775,9 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 			last_seen_msecs = last_seen_msecs % 60000;
 			last_seen_secs = last_seen_msecs / 1000;
 
-			seq_printf(seq, " * %15pI4 %14pM %6i:%02i\n",
+			seq_printf(seq, " * %15pI4 %14pM %4i %6i:%02i\n",
 				   &dat_entry->ip, dat_entry->mac_addr,
+				   BATADV_PRINT_VID(dat_entry->vid),
 				   last_seen_mins, last_seen_secs);
 		}
 		rcu_read_unlock();
-- 
1.8.1.5

