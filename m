Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 22 Nov 2013 13:02:07 +0100
Message-Id: <1385121727-12847-2-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1385121727-12847-1-git-send-email-sw@simonwunderlich.de>
References: <1385121727-12847-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: fix orig_node multiif
	regression in network coding
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

A previous commit for the multi interface optimization did not
change the member access for orig_node to their respective new ifinfo
structures for the network coding implementation.

This was introduced by change de6bcc76ea84fecb136f8c8f5ba1862e4a13f06b
("batman-adv: split out router from orig_node")

Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
---
 network-coding.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/network-coding.c b/network-coding.c
index 8678448..b2fde56 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -715,9 +715,21 @@ static bool batadv_can_nc_with_orig(struct batadv_priv *bat_priv,
 				    struct batadv_orig_node *orig_node,
 				    struct batadv_ogm_packet *ogm_packet)
 {
-	if (orig_node->last_real_seqno != ntohl(ogm_packet->seqno))
+	struct batadv_orig_ifinfo *orig_ifinfo;
+	uint32_t last_real_seqno;
+	uint8_t last_ttl;
+
+	orig_ifinfo = batadv_orig_ifinfo_get(orig_node, BATADV_IF_DEFAULT);
+	if (!orig_ifinfo)
 		return false;
-	if (orig_node->last_ttl != ogm_packet->header.ttl + 1)
+
+	last_ttl = orig_ifinfo->last_ttl;
+	last_real_seqno = orig_ifinfo->last_real_seqno;
+	batadv_orig_ifinfo_free_ref(orig_ifinfo);
+
+	if (last_real_seqno != ntohl(ogm_packet->seqno))
+		return false;
+	if (last_ttl != ogm_packet->header.ttl + 1)
 		return false;
 	if (!batadv_compare_eth(ogm_packet->orig, ogm_packet->prev_sender))
 		return false;
-- 
1.7.10.4

