Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 30 May 2011 09:23:01 +0200
Message-Id: <1306740182-2665-17-git-send-email-sven@narfation.org>
In-Reply-To: <1306740182-2665-1-git-send-email-sven@narfation.org>
References: <1306740182-2665-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 16/17] batman-adv: a multiline comment should
	precede the variable it is describing
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

From: Antonio Quartulli <ordex@autistici.org>

This comment has been wrongly put after the variable it refers to and was also bad indented

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/types.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index fab70e8..65b3222 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -246,10 +246,10 @@ struct frag_packet_list_entry {
 };
 
 struct vis_info {
-	unsigned long       first_seen;
-	struct list_head    recv_list;
-			    /* list of server-neighbors we received a vis-packet
-			     * from.  we should not reply to them. */
+	unsigned long first_seen;
+	/* list of server-neighbors we received a vis-packet
+	 * from.  we should not reply to them. */
+	struct list_head recv_list;
 	struct list_head send_list;
 	struct kref refcount;
 	struct hlist_node hash_entry;
-- 
1.7.5.3

