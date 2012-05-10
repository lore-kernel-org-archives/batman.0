Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 May 2012 12:54:02 +0800
Message-Id: <1336625644-29442-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: change comment style for
	David
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Should be merged with c9619b5e07a756af43c196874e9e9e91e3251154

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_iv_ogm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 2a1845e..96ce556 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1200,7 +1200,8 @@ static int bat_iv_ogm_receive(struct sk_buff *skb,
 		return NET_RX_DROP;
 
 	/* did we receive a B.A.T.M.A.N. IV OGM packet on an interface
-	 * that does not have B.A.T.M.A.N. IV enabled ? */
+	 * that does not have B.A.T.M.A.N. IV enabled ?
+	 */
 	if (bat_priv->bat_algo_ops->bat_ogm_emit != bat_iv_ogm_emit)
 		return NET_RX_DROP;
 
-- 
1.7.9.1

