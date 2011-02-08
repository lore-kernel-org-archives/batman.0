Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  8 Feb 2011 01:27:00 +0100
Message-Id: <1297124820-26721-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Split combined variable
	declarations
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

Multiple variable declarations in a single statements over multiple lines can
be split into multiple variable declarations without changing the actual
behavior.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman-adv/unicast.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/batman-adv/unicast.c b/batman-adv/unicast.c
index 52b52e3..db62b66 100644
--- a/batman-adv/unicast.c
+++ b/batman-adv/unicast.c
@@ -39,8 +39,8 @@ static struct sk_buff *frag_merge_packet(struct list_head *head,
 		(struct unicast_frag_packet *)skb->data;
 	struct sk_buff *tmp_skb;
 	struct unicast_packet *unicast_packet;
-	int hdr_len = sizeof(struct unicast_packet),
-	uni_diff = sizeof(struct unicast_frag_packet) - hdr_len;
+	int hdr_len = sizeof(struct unicast_packet);
+	int uni_diff = sizeof(struct unicast_frag_packet) - hdr_len;
 
 	/* set skb to the first part and tmp_skb to the second part */
 	if (up->flags & UNI_FRAG_HEAD) {
-- 
1.7.2.3

