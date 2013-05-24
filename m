Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 24 May 2013 11:21:25 +0200
Message-Id: <1369387285-2248-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix typo in kernel doc
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Introduced by 8405301b979466610a726b7d595b6bfee5306cf7
("batman-adv: tvlv - convert tt data sent within OGMs")

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 packet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packet.h b/packet.h
index 2a73ebd..21254a4 100644
--- a/packet.h
+++ b/packet.h
@@ -388,7 +388,7 @@ struct batadv_tvlv_gateway_data {
 };
 
 /**
- * struct tvlv_tt_data - tt data propagated through the tt tvlv container
+ * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
  * @flags: translation table flags (see batadv_tt_data_flags)
  * @ttvn: translation table version number
  * @crc: crc32 checksum of the local translation table
-- 
1.8.1.5

