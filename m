Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 12 Feb 2016 11:35:35 +0100
Message-Id: <1455273335-27063-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix logic error in
	batadv_v_ogm_forward
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
Cc: Simon Wunderlich <simon.wunderlich@open-mesh.com>

From: Simon Wunderlich <simon.wunderlich@open-mesh.com>

My latest restructure attempt of the BATMAN v forward function
introduced a regression, causing kernel crashes when an OGM is
forwarded. This patch fixes it.

Fixes: 30c96bc787 ("batman-adv: move and restructure
batadv_v_ogm_forward")
Reported-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Signed-off-by: Simon Wunderlich <simon.wunderlich@open-mesh.com>
---
 net/batman-adv/bat_v_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 1b2399e..4155fa5 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -309,7 +309,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 	u16 tvlv_len;
 
 	/* only forward for specific interfaces, not for the default one. */
-	if (if_outgoing != BATADV_IF_DEFAULT)
+	if (if_outgoing == BATADV_IF_DEFAULT)
 		goto out;
 
 	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
-- 
2.7.0

