Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  8 Aug 2015 02:37:01 +0200
Message-Id: <1438994221-3746-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark batadv_iv_neigh_print as
	static
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

batadv_iv_neigh_print is not used outside of bat_iv_ogm.c and should thus
be marked as static.

Fixes: 2e1133841c44 ("batman-adv: export single hop neighbor list via debugfs")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 154e36a6f486..3738a2f0a03d 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1895,7 +1895,8 @@ batadv_iv_hardif_neigh_print(struct seq_file *seq,
  * @bat_priv: the bat priv with all the soft interface information
  * @seq: neighbour table seq_file struct
  */
-void batadv_iv_neigh_print(struct batadv_priv *bat_priv, struct seq_file *seq)
+static void batadv_iv_neigh_print(struct batadv_priv *bat_priv,
+				  struct seq_file *seq)
 {
 	struct net_device *net_dev = (struct net_device *)seq->private;
 	struct batadv_hardif_neigh_node *hardif_neigh;
-- 
2.5.0

