Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri,  9 Jan 2015 11:22:17 +0100
Message-Id: <1420798937-28761-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batctl: fix misspelled words
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Reported-by: checkpatch
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 packet.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packet.h b/packet.h
index facd1fe..b81fbbf 100644
--- a/packet.h
+++ b/packet.h
@@ -377,7 +377,7 @@ struct batadv_frag_packet {
 	uint8_t reserved:4;
 	uint8_t no:4;
 #else
-#error "unknown bitfield endianess"
+#error "unknown bitfield endianness"
 #endif
 	uint8_t dest[ETH_ALEN];
 	uint8_t orig[ETH_ALEN];
@@ -453,7 +453,7 @@ struct batadv_coded_packet {
  * @src: address of the source
  * @dst: address of the destination
  * @tvlv_len: length of tvlv data following the unicast tvlv header
- * @align: 2 bytes to align the header to a 4 byte boundry
+ * @align: 2 bytes to align the header to a 4 byte boundary
  */
 struct batadv_unicast_tvlv_packet {
 	uint8_t  packet_type;
-- 
2.2.1

