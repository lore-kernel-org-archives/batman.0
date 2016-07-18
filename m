Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Jul 2016 12:11:59 +0200
Message-Id: <1468836728-21890-2-git-send-email-sven@narfation.org>
In-Reply-To: <6098496.c9QsHxvAun@sven-edge>
References: <6098496.c9QsHxvAun@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH v11 02/11] batctl: add B.A.T.M.A.N. Dump BLA
	claims via netlink
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

From: Andrew Lunn <andrew@lunn.ch>

Dump the list of bridge loop avoidance claims via the netlink socket.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
[sven.eckelmann@open-mesh.com: add policy for attributes, fix includes, fix
soft_iface reference leak]
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
[sw@simonwunderlich.de: fix kerneldoc, fix error reporting]
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 batman_adv.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/batman_adv.h b/batman_adv.h
index a13fc09..96b37ab 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -91,6 +91,11 @@ enum batadv_tt_client_flags {
  * @BATADV_ATTR_BANDWIDTH_UP: Reported uplink bandwidth
  * @BATADV_ATTR_BANDWIDTH_DOWN: Reported downlink bandwidth
  * @BATADV_ATTR_ROUTER: Gateway router MAC address
+ * @BATADV_ATTR_BLA_OWN: Flag indicating own originator
+ * @BATADV_ATTR_BLA_ADDRESS: Bridge loop avoidance claim MAC address
+ * @BATADV_ATTR_BLA_VID: BLA VLAN ID
+ * @BATADV_ATTR_BLA_BACKBONE: BLA gateway originator MAC address
+ * @BATADV_ATTR_BLA_CRC: BLA CRC
  * @__BATADV_ATTR_AFTER_LAST: internal use
  * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
  * @BATADV_ATTR_MAX: highest attribute number currently defined
@@ -126,6 +131,11 @@ enum batadv_nl_attrs {
 	BATADV_ATTR_BANDWIDTH_UP,
 	BATADV_ATTR_BANDWIDTH_DOWN,
 	BATADV_ATTR_ROUTER,
+	BATADV_ATTR_BLA_OWN,
+	BATADV_ATTR_BLA_ADDRESS,
+	BATADV_ATTR_BLA_VID,
+	BATADV_ATTR_BLA_BACKBONE,
+	BATADV_ATTR_BLA_CRC,
 	/* add attributes above here, update the policy in netlink.c */
 	__BATADV_ATTR_AFTER_LAST,
 	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
@@ -146,6 +156,7 @@ enum batadv_nl_attrs {
  * @BATADV_CMD_GET_ORIGINATORS: Query list of originators
  * @BATADV_CMD_GET_NEIGHBORS: Query list of neighbours
  * @BATADV_CMD_GET_GATEWAYS: Query list of gateways
+ * @BATADV_CMD_GET_BLA_CLAIM: Query list of bridge loop avoidance claims
  * @__BATADV_CMD_AFTER_LAST: internal use
  * @BATADV_CMD_MAX: highest used command number
  */
@@ -161,6 +172,7 @@ enum batadv_nl_commands {
 	BATADV_CMD_GET_ORIGINATORS,
 	BATADV_CMD_GET_NEIGHBORS,
 	BATADV_CMD_GET_GATEWAYS,
+	BATADV_CMD_GET_BLA_CLAIM,
 	/* add new commands above here */
 	__BATADV_CMD_AFTER_LAST,
 	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
-- 
2.8.1

