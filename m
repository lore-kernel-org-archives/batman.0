Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon,  2 Dec 2013 20:38:30 +0100
Message-Id: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-next 1/4] batman-adv: fix alignment for
	batadv_coded_packet
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

The compiler may decide to pad the structure, and then it does not
have the expected size of 46 byte. Fix this by moving it in the
pragma pack(2) part of the code.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 packet.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packet.h b/packet.h
index 207459b..10597a6 100644
--- a/packet.h
+++ b/packet.h
@@ -315,8 +315,6 @@ struct batadv_bcast_packet {
 	 */
 };
 
-#pragma pack()
-
 /**
  * struct batadv_coded_packet - network coded packet
  * @header: common batman packet header and ttl of first included packet
@@ -349,6 +347,8 @@ struct batadv_coded_packet {
 	__be16   coded_len;
 };
 
+#pragma pack()
+
 /**
  * struct batadv_unicast_tvlv - generic unicast packet with tvlv payload
  * @header: common batman packet header
-- 
1.7.10.4

