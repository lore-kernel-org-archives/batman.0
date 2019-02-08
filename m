Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 00:05:36 +0100
Message-Id: <20190208230536.25248-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix typo "reseved" -> "reserved"
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

checkpatch.pl complains since commit 45e417022023 ("scripts/spelling.txt:
add more spellings to spelling.txt") about an additional spelling mistake
in batman-adv:`

  CHECK: 'reseved' may be misspelled - perhaps 'reserved'?
  #232: FILE: include/uapi/linux/batadv_packet.h:232:
  + * @flags: reseved for routing relevant flags - currently always 0

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batadv_packet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 7eb2936a..c99336f4 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -229,7 +229,7 @@ struct batadv_ogm_packet {
  * @packet_type: batman-adv packet type, part of the general header
  * @version: batman-adv protocol version, part of the general header
  * @ttl: time to live for this packet, part of the general header
- * @flags: reseved for routing relevant flags - currently always 0
+ * @flags: reserved for routing relevant flags - currently always 0
  * @seqno: sequence number
  * @orig: originator mac address
  * @tvlv_len: length of the appended tvlv buffer (in bytes)
-- 
2.20.1

