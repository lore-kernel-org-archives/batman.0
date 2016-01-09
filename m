Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sat,  9 Jan 2016 21:20:13 +0800
Message-Id: <1452345621-15908-9-git-send-email-a@unstable.cc>
In-Reply-To: <1452345621-15908-1-git-send-email-a@unstable.cc>
References: <1452345621-15908-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 08/16] batman-adv: Delete unnecessary checks
	before the function call "kfree_skb"
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Markus Elfring <elfring@users.sourceforge.net>, Marek Lindner <mareklindner@neomailbox.ch>

From: Markus Elfring <elfring@users.sourceforge.net>

The kfree_skb() function tests whether its argument is NULL and then
returns immediately. Thus the test around the calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/main.c           | 2 +-
 net/batman-adv/network-coding.c | 4 +---
 net/batman-adv/send.c           | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 95fd418e9567..5b678f3471fc 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1184,7 +1184,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, u8 *src,
 		ret = true;
 
 out:
-	if (skb && !ret)
+	if (!ret)
 		kfree_skb(skb);
 	if (orig_node)
 		batadv_orig_node_free_ref(orig_node);
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index f5276be2c77c..c98b0ab85449 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -244,9 +244,7 @@ static void batadv_nc_path_free_ref(struct batadv_nc_path *nc_path)
  */
 static void batadv_nc_packet_free(struct batadv_nc_packet *nc_packet)
 {
-	if (nc_packet->skb)
-		kfree_skb(nc_packet->skb);
-
+	kfree_skb(nc_packet->skb);
 	batadv_nc_path_free_ref(nc_packet->nc_path);
 	kfree(nc_packet);
 }
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index f664324805eb..782fa33ec296 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -407,8 +407,7 @@ void batadv_schedule_bat_ogm(struct batadv_hard_iface *hard_iface)
 
 static void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet)
 {
-	if (forw_packet->skb)
-		kfree_skb(forw_packet->skb);
+	kfree_skb(forw_packet->skb);
 	if (forw_packet->if_incoming)
 		batadv_hardif_free_ref(forw_packet->if_incoming);
 	if (forw_packet->if_outgoing)
-- 
2.7.0

