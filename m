Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 30 Oct 2012 14:09:46 +0100
Message-Id: <1351602589-22844-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1351602589-22844-1-git-send-email-ordex@autistici.org>
References: <1351602589-22844-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/6] batman-adv: remove useless goto
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

This was introduced by ("batman-adv: roaming handling mechanism redesign")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index 6fecb94..59e64bc 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -292,7 +292,6 @@ void batadv_tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 			 */
 			tt_local->common.flags &= ~BATADV_TT_CLIENT_ROAM;
 			roamed_back = true;
-			goto check_roaming;
 		}
 		goto check_roaming;
 	}
-- 
1.7.12.4

