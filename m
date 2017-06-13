Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 13 Jun 2017 13:36:53 +0200
Message-Id: <20170613113700.31220-4-sw@simonwunderlich.de>
In-Reply-To: <20170613113700.31220-1-sw@simonwunderlich.de>
References: <20170613113700.31220-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 03/10] batman-adv: Replace a seq_puts() call
 by seq_putc() in two functions
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Markus Elfring <elfring@users.sourceforge.net>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Markus Elfring <elfring@users.sourceforge.net>

Two single characters (line breaks) should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 2 +-
 net/batman-adv/bat_v.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 495ba7cdcb04..1f80392ab37c 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1944,7 +1944,7 @@ static void batadv_iv_ogm_orig_print(struct batadv_priv *bat_priv,
 
 			batadv_iv_ogm_orig_print_neigh(orig_node, if_outgoing,
 						       seq);
-			seq_puts(seq, "\n");
+			seq_putc(seq, '\n');
 			batman_count++;
 
 next:
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index a36c8e7291d6..4e2724c5b33d 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -400,7 +400,7 @@ static void batadv_v_orig_print(struct batadv_priv *bat_priv,
 				   neigh_node->if_incoming->net_dev->name);
 
 			batadv_v_orig_print_neigh(orig_node, if_outgoing, seq);
-			seq_puts(seq, "\n");
+			seq_putc(seq, '\n');
 			batman_count++;
 
 next:
-- 
2.11.0

