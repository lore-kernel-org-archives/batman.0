Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Feb 2011 00:21:41 +0100
Message-Id: <1297466503-13246-3-git-send-email-sven@narfation.org>
In-Reply-To: <1297466503-13246-1-git-send-email-sven@narfation.org>
References: <1297466503-13246-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Split combined variable
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Multiple variable declarations in a single statements over multiple lines can
be split into multiple variable declarations without changing the actual
behavior.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/unicast.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/unicast.c b/net/batman-adv/unicast.c
index 9b2a222..6c92eef 100644
--- a/net/batman-adv/unicast.c
+++ b/net/batman-adv/unicast.c
@@ -39,8 +39,8 @@ static struct sk_buff *frag_merge_packet(struct list_head *head,
 		(struct unicast_frag_packet *)skb->data;
 	struct sk_buff *tmp_skb;
 	struct unicast_packet *unicast_packet;
-	int hdr_len = sizeof(struct unicast_packet),
-	    uni_diff = sizeof(struct unicast_frag_packet) - hdr_len;
+	int hdr_len = sizeof(struct unicast_packet);
+	int uni_diff = sizeof(struct unicast_frag_packet) - hdr_len;
 
 	/* set skb to the first part and tmp_skb to the second part */
 	if (up->flags & UNI_FRAG_HEAD) {
-- 
1.7.2.3

