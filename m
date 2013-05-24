Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 24 May 2013 15:04:44 +0200
Message-Id: <1369400684-1937-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: correctly align the tt_tvlv_data
	struct
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
Cc: Antonio Quartulli <ordex@autistici.org>

4bytes long members must start at an address multiple of 4
in order to avoid unaligned memory access.

Add 2 padding bytes to satisfy this requirement.

Introduced by c5e7a06a29612056006e4dc01910c0b44e858583
"batman-adv: use CRC32C instead of CRC16 in TT code"

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 packet.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/packet.h b/packet.h
index 21254a4..8675b52 100644
--- a/packet.h
+++ b/packet.h
@@ -391,11 +391,13 @@ struct batadv_tvlv_gateway_data {
  * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
  * @flags: translation table flags (see batadv_tt_data_flags)
  * @ttvn: translation table version number
+ * @reserved: not used, useful for alignment purposes
  * @crc: crc32 checksum of the local translation table
  */
 struct batadv_tvlv_tt_data {
 	uint8_t flags;
 	uint8_t ttvn;
+	uint16_t reserved;
 	__be32  crc;
 };
 
-- 
1.8.1.5

