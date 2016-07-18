Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Jul 2016 12:12:00 +0200
Message-Id: <1468836728-21890-3-git-send-email-sven@narfation.org>
In-Reply-To: <6098496.c9QsHxvAun@sven-edge>
References: <6098496.c9QsHxvAun@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v11 03/11] batctl: add backbone table netlink
	support
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

From: Simon Wunderlich <sw@simonwunderlich.de>

Dump the list of bridge loop avoidance backbones via the netlink socket.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batman_adv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/batman_adv.h b/batman_adv.h
index 96b37ab..734fe83 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -157,6 +157,7 @@ enum batadv_nl_attrs {
  * @BATADV_CMD_GET_NEIGHBORS: Query list of neighbours
  * @BATADV_CMD_GET_GATEWAYS: Query list of gateways
  * @BATADV_CMD_GET_BLA_CLAIM: Query list of bridge loop avoidance claims
+ * @BATADV_CMD_GET_BLA_BACKBONE: Query list of bridge loop avoidance backbones
  * @__BATADV_CMD_AFTER_LAST: internal use
  * @BATADV_CMD_MAX: highest used command number
  */
@@ -173,6 +174,7 @@ enum batadv_nl_commands {
 	BATADV_CMD_GET_NEIGHBORS,
 	BATADV_CMD_GET_GATEWAYS,
 	BATADV_CMD_GET_BLA_CLAIM,
+	BATADV_CMD_GET_BLA_BACKBONE,
 	/* add new commands above here */
 	__BATADV_CMD_AFTER_LAST,
 	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
-- 
2.8.1

