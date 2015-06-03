Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed,  3 Jun 2015 16:14:00 +0200
Message-Id: <1433340848-1682-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
References: <1433340848-1682-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 04/12] batman-adv: iv_ogm,
	Fix dup_status comment
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Markus Pargmann <mpa@pengutronix.de>

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 66ac9e8..23c41d1 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -28,7 +28,7 @@
 
 /**
  * enum batadv_dup_status - duplicate status
- * @BATADV_NO_DUP: the packet is a duplicate
+ * @BATADV_NO_DUP: the packet is no duplicate
  * @BATADV_ORIG_DUP: OGM is a duplicate in the originator (but not for the
  *  neighbor)
  * @BATADV_NEIGH_DUP: OGM is a duplicate for the neighbor
-- 
2.4.2

