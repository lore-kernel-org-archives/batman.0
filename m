Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  5 Nov 2012 10:15:24 +0100
Message-Id: <1352106924-6755-1-git-send-email-sven@narfation.org>
In-Reply-To: <1352038798-29658-3-git-send-email-sven@narfation.org>
References: <1352038798-29658-3-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [RFC-alt 3/4] batman-adv: Fix alignment for payload
	after batadv_unicast_4addr_packet
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

batadv_unicast_4addr_packet created an odd aligned ethernet header and a not 4
bytes boundary aligned IP header. Adding an extra reserved bytes avoids this
problem.

This problem was introduced in 78fc6bbe0aca868b65b92723b1e259e7ef7b35c0
("batman-adv: add UNICAST_4ADDR packet type")

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This is an alternative version of the third patch.

DONT APPLY PATCH 4 WHEN NOT APPLYING THE INITIAL VERSION OF THE THIRD PATCH

 packet.h  |    6 +++++-
 unicast.c |    1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/packet.h b/packet.h
index 43c863c..0a9886c 100644
--- a/packet.h
+++ b/packet.h
@@ -191,7 +191,11 @@ struct batadv_unicast_4addr_packet {
 	struct batadv_unicast_packet u;
 	uint8_t src[ETH_ALEN];
 	uint8_t subtype;
-} __packed;
+	uint8_t reserved;
+	/* "4 bytes boundary + 2 bytes" long to make the payload after the
+	 * following ethernet header again 4 bytes boundary aligned
+	 */
+};
 
 struct batadv_unicast_frag_packet {
 	struct batadv_header header;
diff --git a/unicast.c b/unicast.c
index 9416136..10aff49 100644
--- a/unicast.c
+++ b/unicast.c
@@ -374,6 +374,7 @@ bool batadv_unicast_4addr_prepare_skb(struct batadv_priv *bat_priv,
 	memcpy(unicast_4addr_packet->src, primary_if->net_dev->dev_addr,
 	       ETH_ALEN);
 	unicast_4addr_packet->subtype = packet_subtype;
+	unicast_4addr_packet->reserved = 0;
 
 	ret = true;
 out:
-- 
1.7.10.4

