Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed,  8 May 2013 13:36:20 +0800
Message-Id: <1367991380-30270-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: consider network coding
	overhead when calculating required mtu
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

The module prints a warning when the MTU on the hard interface is too
small to transfer payload traffic without fragmentation. The required
MTU is calculated based on the encapsulation header size. If network
coding is compild into the module its header size is taken into
account as well.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 types.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/types.h b/types.h
index b2c94e1..8089bd6 100644
--- a/types.h
+++ b/types.h
@@ -27,9 +27,16 @@
 /**
  * Maximum overhead for the encapsulation for a payload packet
  */
+#ifdef CONFIG_BATMAN_ADV_NC
+#define BATADV_HEADER_LEN \
+	(ETH_HLEN + max3(sizeof(struct batadv_unicast_packet), \
+			 sizeof(struct batadv_bcast_packet),   \
+			 sizeof(struct batadv_coded_packet)))
+#else
 #define BATADV_HEADER_LEN \
 	(ETH_HLEN + max(sizeof(struct batadv_unicast_packet), \
 			sizeof(struct batadv_bcast_packet)))
+#endif /* CONFIG_BATMAN_ADV_NC */
 
 #ifdef CONFIG_BATMAN_ADV_DAT
 
-- 
1.7.10.4

