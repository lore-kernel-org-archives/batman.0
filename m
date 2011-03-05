Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  5 Mar 2011 13:28:33 +0100
Message-Id: <1299328122-21468-20-git-send-email-sven@narfation.org>
In-Reply-To: <1299328122-21468-1-git-send-email-sven@narfation.org>
References: <1299328122-21468-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 19/28] batman-adv: Fix possible buffer
	overflow in softif neigh list output
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

From: Linus Lüssing <linus.luessing@ascom.ch>

When printing the soft interface table the number of entries in the
softif neigh list are first being counted and a fitting buffer
allocated. After that the softif neigh list gets locked again and
the buffer printed - which has the following two issues:

For one thing, the softif neigh list might have grown when reacquiring
the rcu lock, which results in writing outside of the allocated buffer.
Furthermore 31 Bytes are not enough for printing an entry with a vid
of more than 2 digits.

The manual buffering is unnecessary, we can safely print to the seq
directly during the rcu_read_lock().

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/soft-interface.c |   22 +---------------------
 1 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 152beaa..c30ccd6 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -171,8 +171,6 @@ int softif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 	struct bat_priv *bat_priv = netdev_priv(net_dev);
 	struct softif_neigh *softif_neigh;
 	struct hlist_node *node;
-	size_t buf_size, pos;
-	char *buff;
 
 	if (!bat_priv->primary_if) {
 		return seq_printf(seq, "BATMAN mesh %s disabled - "
@@ -182,33 +180,15 @@ int softif_neigh_seq_print_text(struct seq_file *seq, void *offset)
 
 	seq_printf(seq, "Softif neighbor list (%s)\n", net_dev->name);
 
-	buf_size = 1;
-	/* Estimate length for: "   xx:xx:xx:xx:xx:xx\n" */
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(softif_neigh, node,
 				 &bat_priv->softif_neigh_list, list)
-		buf_size += 30;
-	rcu_read_unlock();
-
-	buff = kmalloc(buf_size, GFP_ATOMIC);
-	if (!buff)
-		return -ENOMEM;
-
-	buff[0] = '\0';
-	pos = 0;
-
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(softif_neigh, node,
-				 &bat_priv->softif_neigh_list, list) {
-		pos += snprintf(buff + pos, 31, "%s %pM (vid: %d)\n",
+		seq_printf(seq, "%s %pM (vid: %d)\n",
 				bat_priv->softif_neigh == softif_neigh
 				? "=>" : "  ", softif_neigh->addr,
 				softif_neigh->vid);
-	}
 	rcu_read_unlock();
 
-	seq_printf(seq, "%s", buff);
-	kfree(buff);
 	return 0;
 }
 
-- 
1.7.2.3

