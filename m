Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 May 2011 16:47:23 +0200
Message-Id: <1305730043-3666-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: a multiline comment should
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

This comment has been wrongly put after the variable it refers to and was also bad indented

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

 types.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/types.h b/types.h
index fab70e8..65b3222 100644
--- a/types.h
+++ b/types.h
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
1.7.3.4

