Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Jun 2012 22:19:16 +0200
Message-Id: <1338754762-28424-10-git-send-email-sven@narfation.org>
In-Reply-To: <1338754762-28424-1-git-send-email-sven@narfation.org>
References: <1338754762-28424-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 10/16] batman-adv: Prefix vis defines with
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
To: b.a.t.m.a.n@lists.open-mesh.org

Reported-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 vis.c |    2 +-
 vis.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/vis.c b/vis.c
index 596eacc..a439ed6 100644
--- a/vis.c
+++ b/vis.c
@@ -674,7 +674,7 @@ static void batadv_purge_vis_packets(struct bat_priv *bat_priv)
 				continue;
 
 			if (batadv_has_timed_out(info->first_seen,
-						 VIS_TIMEOUT)) {
+						 BATADV_VIS_TIMEOUT)) {
 				hlist_del(node);
 				batadv_send_list_del(info);
 				kref_put(&info->refcount, batadv_free_info);
diff --git a/vis.h b/vis.h
index dad5958..16a1a6b 100644
--- a/vis.h
+++ b/vis.h
@@ -21,7 +21,7 @@
 #define _NET_BATMAN_ADV_VIS_H_
 
 /* timeout of vis packets in miliseconds */
-#define VIS_TIMEOUT		200000
+#define BATADV_VIS_TIMEOUT		200000
 
 int batadv_vis_seq_print_text(struct seq_file *seq, void *offset);
 void batadv_receive_server_sync_packet(struct bat_priv *bat_priv,
-- 
1.7.10

