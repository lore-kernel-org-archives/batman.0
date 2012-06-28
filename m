Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 28 Jun 2012 11:34:26 +0200
Message-Id: <1340876067-28333-18-git-send-email-ordex@autistici.org>
In-Reply-To: <1340876067-28333-1-git-send-email-ordex@autistici.org>
References: <1340876067-28333-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 17/18] batman-adv: Prefix vis defines with
	BATADV_
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/vis.c |    2 +-
 net/batman-adv/vis.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/vis.c b/net/batman-adv/vis.c
index 596eacc..a439ed6 100644
--- a/net/batman-adv/vis.c
+++ b/net/batman-adv/vis.c
@@ -674,7 +674,7 @@ static void batadv_purge_vis_packets(struct bat_priv *bat_priv)
 				continue;
 
 			if (batadv_has_timed_out(info->first_seen,
-						 VIS_TIMEOUT)) {
+						 BATADV_VIS_TIMEOUT)) {
 				hlist_del(node);
 				batadv_send_list_del(info);
 				kref_put(&info->refcount, batadv_free_info);
diff --git a/net/batman-adv/vis.h b/net/batman-adv/vis.h
index dad5958..16a1a6b 100644
--- a/net/batman-adv/vis.h
+++ b/net/batman-adv/vis.h
@@ -21,7 +21,7 @@
 #define _NET_BATMAN_ADV_VIS_H_
 
 /* timeout of vis packets in miliseconds */
-#define VIS_TIMEOUT		200000
+#define BATADV_VIS_TIMEOUT		200000
 
 int batadv_vis_seq_print_text(struct seq_file *seq, void *offset);
 void batadv_receive_server_sync_packet(struct bat_priv *bat_priv,
-- 
1.7.9.4

