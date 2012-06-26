Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 26 Jun 2012 08:49:50 +0200
Message-Id: <1340693391-16434-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1340693391-16434-1-git-send-email-ordex@autistici.org>
References: <20120625.161933.730861831753419928.davem@davemloft.net>
	<1340693391-16434-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2 net-next] batman-adv: fix condition in AP
	isolation
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

During the last conflict resolution involving translation-table.c something went
wrong and a condition in the AP isolation code was reversed. This patch fixes
this problem.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/translation-table.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index cf79883..e4f27a8 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2187,7 +2187,7 @@ bool batadv_is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src,
 	if (!tt_global_entry)
 		goto out;
 
-	if (_batadv_is_ap_isolated(tt_local_entry, tt_global_entry))
+	if (!_batadv_is_ap_isolated(tt_local_entry, tt_global_entry))
 		goto out;
 
 	ret = true;
-- 
1.7.9.4

