Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 27 Feb 2018 09:10:58 +0100
Message-Id: <20180227081059.13234-3-linus.luessing@c0d3.blue>
In-Reply-To: <20180227081059.13234-1-linus.luessing@c0d3.blue>
References: <20180227081059.13234-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batctl: add multicast flags netlink
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

Dump the list of multicast flags entries via the netlink socket.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 batman_adv.h | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/batman_adv.h b/batman_adv.h
index 85c9fe8..d17ea7a 100644
--- a/batman_adv.h
+++ b/batman_adv.h
@@ -92,6 +92,53 @@ enum batadv_tt_client_flags {
 };
 
 /**
+ * enum batadv_mcast_flags_priv - Private, own multicast flags
+ *
+ * These are internal, multicast related flags. Currently they describe certain
+ * multicast related attributes of the segment this originator bridges into the
+ * mesh.
+ *
+ * Those attributes are used to determine the public multicast flags this
+ * originator is going to announce via TT.
+ *
+ * For netlink, if BATADV_MCAST_FLAGS_BRIDGED is unset then all querier
+ * related flags are undefined.
+ */
+enum batadv_mcast_flags_priv {
+	/**
+	 * @BATADV_MCAST_FLAGS_BRIDGED: There is a bridge on top of the mesh
+	 * interface.
+	 */
+	BATADV_MCAST_FLAGS_BRIDGED			= (1 << 0),
+
+	/**
+	 * @BATADV_MCAST_FLAGS_QUERIER_IPV4_EXISTS: Whether an IGMP querier
+	 * exists in the mesh
+	 */
+	BATADV_MCAST_FLAGS_QUERIER_IPV4_EXISTS		= (1 << 1),
+
+	/**
+	 * @BATADV_MCAST_FLAGS_QUERIER_IPV6_EXISTS: Whether an MLD querier
+	 * exists in the mesh
+	 */
+	BATADV_MCAST_FLAGS_QUERIER_IPV6_EXISTS		= (1 << 2),
+
+	/**
+	 * @BATADV_MCAST_FLAGS_QUERIER_IPV4_SHADOWING: If an IGMP querier
+	 * exists, whether it is potentially shadowing multicast listeners
+	 * (i.e. querier is behind our own bridge segment)
+	 */
+	BATADV_MCAST_FLAGS_QUERIER_IPV4_SHADOWING	= (1 << 3),
+
+	/**
+	 * @BATADV_MCAST_FLAGS_QUERIER_IPV6_SHADOWING: If an MLD querier
+	 * exists, whether it is potentially shadowing multicast listeners
+	 * (i.e. querier is behind our own bridge segment)
+	 */
+	BATADV_MCAST_FLAGS_QUERIER_IPV6_SHADOWING	= (1 << 4),
+};
+
+/**
  * enum batadv_nl_attrs - batman-adv netlink attributes
  */
 enum batadv_nl_attrs {
@@ -287,6 +334,16 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_DC_VID,
 
+	/**
+	 * @BATADV_ATTR_MCAST_FLAGS: Per originator multicast flags
+	 */
+	BATADV_ATTR_MCAST_FLAGS,
+
+	/**
+	 * @BATADV_ATTR_MCAST_FLAGS_PRIV: Private, own multicast flags
+	 */
+	BATADV_ATTR_MCAST_FLAGS_PRIV,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
@@ -381,6 +438,11 @@ enum batadv_nl_commands {
 	 */
 	BATADV_CMD_GET_DAT_CACHE,
 
+	/**
+	 * @BATADV_CMD_GET_MCAST_FLAGS: Query list of multicast flags
+	 */
+	BATADV_CMD_GET_MCAST_FLAGS,
+
 	/* add new commands above here */
 
 	/**
-- 
2.11.0

