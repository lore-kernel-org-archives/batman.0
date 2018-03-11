Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 11 Mar 2018 01:02:49 +0100
Message-Id: <20180311000252.3289-2-linus.luessing@c0d3.blue>
In-Reply-To: <20180311000252.3289-1-linus.luessing@c0d3.blue>
References: <20180311000252.3289-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2 1/4] batctl: add DAT cache netlink support
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

Dump the list of DAT cache entries via the netlink socket.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 batman_adv.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/batman_adv.h b/batman_adv.h
index 56ae289..85c9fe8 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -272,6 +272,21 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_BLA_CRC,
 
+	/**
+	 * @BATADV_ATTR_DC_ADDRESS: Client IPv4 address
+	 */
+	BATADV_ATTR_DC_ADDRESS,
+
+	/**
+	 * @BATADV_ATTR_DC_HWADDRESS: Client MAC address
+	 */
+	BATADV_ATTR_DC_HWADDRESS,
+
+	/**
+	 * @BATADV_ATTR_DC_VID: VLAN ID
+	 */
+	BATADV_ATTR_DC_VID,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
@@ -361,6 +376,11 @@ enum batadv_nl_commands {
 	 */
 	BATADV_CMD_GET_BLA_BACKBONE,
 
+	/**
+	 * @BATADV_CMD_GET_DAT_CACHE: Query list of DAT cache entries
+	 */
+	BATADV_CMD_GET_DAT_CACHE,
+
 	/* add new commands above here */
 
 	/**
-- 
2.11.0

