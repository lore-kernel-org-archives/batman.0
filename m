Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Apr 2012 09:40:40 +0200
Message-Id: <1334734840-816-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use real error codes instead of
	meaningless -1
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

Reported-by: David Miller <davem@davemloft.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

This patch is for *next*. This patch fixes a problem pointed out by David S.
Miller.

Actually the idea is to use real error codes instead of meaningless -1, even if
this codes are only used internally to the batman-adv code. IMHO it is a good
idea. Most of the times we convert -1 to real error codes later, but I think it
is better to user real code directly. This patch will be squashed with a patch
which is going to be sent in the next pull request.
Another patch which fix the other error codes should follow.

Cheers,


 bat_iv_ogm.c     |    2 +-
 hard-interface.c |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index ab2085c..2a1845e 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -59,7 +59,7 @@ static int bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
 {
 	struct batman_ogm_packet *batman_ogm_packet;
 	uint32_t random_seqno;
-	int res = -1;
+	int res = -ENOMEM;
 
 	/* randomize initial seqno to avoid collision */
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
diff --git a/hard-interface.c b/hard-interface.c
index e647a43..843caa7 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -309,10 +309,8 @@ int hardif_enable_interface(struct hard_iface *hard_iface,
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
 	ret = bat_priv->bat_algo_ops->bat_iface_enable(hard_iface);
-	if (ret < 0) {
-		ret = -ENOMEM;
+	if (ret < 0)
 		goto err_dev;
-	}
 
 	hard_iface->if_num = bat_priv->num_ifaces;
 	bat_priv->num_ifaces++;
-- 
1.7.9.4

