Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 16 Jun 2011 00:32:25 +0200
Message-Id: <1308177145-21191-2-git-send-email-ordex@autistici.org>
In-Reply-To: <201106152056.18072.lindner_marek@yahoo.de>
References: <201106152056.18072.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: skbs have to be freed using
	kfree_skb()
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

The skb structures have always to be freed using kfree_skb() and not the
simple kfree()

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index adecf1b..373ee81 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1199,7 +1199,7 @@ out:
 	if (primary_if)
 		hardif_free_ref(primary_if);
 	if (!ret)
-		kfree(skb);
+		kfree_skb(skb);
 	return ret;
 
 }
@@ -1312,7 +1312,7 @@ out:
 	if (primary_if)
 		hardif_free_ref(primary_if);
 	if (!ret)
-		kfree(skb);
+		kfree_skb(skb);
 	/* This packet was for me, so it doesn't need to be re-routed */
 	return true;
 }
-- 
1.7.3.4

