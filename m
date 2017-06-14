Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
Date: Wed, 14 Jun 2017 02:33:52 -0700
Message-Id: <c3693cdd478c68f078f105f55972a4406b333e69.1497432565.git.joe@perches.com>
In-Reply-To: <5300874.nPgxNW8UST@bentobox>
References: <5300874.nPgxNW8UST@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove unnecessary length
 qualifier in %14pM
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>
Cc: Sven Eckelmann <sven@narfation.org>, "David S. Miller" <davem@davemloft.net>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

It's misleading and unnecessary.

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 6930d6b50f99..b6cfa78e9381 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -834,7 +834,7 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 			last_seen_msecs = last_seen_msecs % 60000;
 			last_seen_secs = last_seen_msecs / 1000;
 
-			seq_printf(seq, " * %15pI4 %14pM %4i %6i:%02i\n",
+			seq_printf(seq, " * %15pI4 %pM %4i %6i:%02i\n",
 				   &dat_entry->ip, dat_entry->mac_addr,
 				   batadv_print_vid(dat_entry->vid),
 				   last_seen_mins, last_seen_secs);
-- 
2.10.0.rc2.1.g053435c

