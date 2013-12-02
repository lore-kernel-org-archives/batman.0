Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon,  2 Dec 2013 20:38:33 +0100
Message-Id: <1386013113-25471-4-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
References: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-next 4/4] batman-adv: fix size of
	batadv_bla_claim_dst
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

Since this is a mac address and always 48 bit, and we can assume that
it is always aligned to 2-byte boundaries, add a pack(2) pragma.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 packet.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/packet.h b/packet.h
index 001b941..cc7ac9e 100644
--- a/packet.h
+++ b/packet.h
@@ -155,6 +155,7 @@ enum batadv_tvlv_type {
 	BATADV_TVLV_ROAM	= 0x05,
 };
 
+#pragma pack(2)
 /* the destination hardware field in the ARP frame is used to
  * transport the claim type and the group id
  */
@@ -163,6 +164,7 @@ struct batadv_bla_claim_dst {
 	uint8_t type;		/* bla_claimframe */
 	__be16 group;		/* group id */
 };
+#pragma pack()
 
 /**
  * struct batadv_ogm_packet - ogm (routing protocol) packet
-- 
1.7.10.4

