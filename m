Return-Path: <elfring@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <512d2e7c-0967-9303-2b68-6c9ef53d6ed2@users.sourceforge.net>
Message-ID: <671cea53-ed6c-162f-e6c0-77f6da073b49@users.sourceforge.net>
Date: Sat, 6 May 2017 18:14:14 +0200
MIME-Version: 1.0
In-Reply-To: <512d2e7c-0967-9303-2b68-6c9ef53d6ed2@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Replace a seq_puts() call by
 seq_putc() in two functions
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 6 May 2017 17:50:13 +0200

Two single characters (line breaks) should be put into a sequence.
Thus use the corresponding function "seq_putc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
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
2.12.2

