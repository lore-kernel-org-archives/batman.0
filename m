Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 15 Aug 2010 12:51:25 +0200
Message-Id: <1281869485-32283-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Add include guards to unicast.h
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

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/unicast.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/batman-adv/unicast.h b/batman-adv/unicast.h
index 06f374e..1d5cbeb 100644
--- a/batman-adv/unicast.h
+++ b/batman-adv/unicast.h
@@ -19,6 +19,9 @@
  *
  */
 
+#ifndef _NET_BATMAN_ADV_UNICAST_H_
+#define _NET_BATMAN_ADV_UNICAST_H_
+
 #define FRAG_TIMEOUT 10000	/* purge frag list entrys after time in ms */
 #define FRAG_BUFFER_SIZE 6	/* number of list elements in buffer */
 
@@ -32,3 +35,5 @@ struct frag_packet_list_entry *search_frag_packet(struct list_head *head,
 	struct unicast_frag_packet *up);
 void frag_list_free(struct list_head *head);
 int unicast_send_skb(struct sk_buff *skb, struct bat_priv *bat_priv);
+
+#endif /* _NET_BATMAN_ADV_UNICAST_H_ */
-- 
1.7.1

