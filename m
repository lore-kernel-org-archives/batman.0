From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue,  2 Jun 2009 19:56:05 +0200
Message-Id: <1243965365-6526-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <200906021950.07235.sven.eckelmann@gmx.de>
References: <200906021950.07235.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] [batman] Align pointers in hna list elements
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Architectures like SuperARM or Xscale needs aligned data for multi-byte
operations. GCC can create instructions sequences for packed data, but
must know that something will not be aligned. Since list_add will
operate on untyped data over void-pointers it cannot know that
hna_global_entry is packed and will create only a fast and unsafe
version for load and store operations.
It is only important for the first 5 bytes of hna_global_entry to be
packed we can force these elements to be aligned without changing
the relative addresses of the first bytes.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/hna.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/batman/hna.h b/batman/hna.h
index 6063324..3e7049e 100644
--- a/batman/hna.h
+++ b/batman/hna.h
@@ -58,8 +58,8 @@ struct hna_global_entry
 {
 	uint32_t addr;
 	uint8_t netmask;
-	struct orig_node *curr_orig_node;
-	struct list_head_first orig_list;
+	struct orig_node *curr_orig_node ALIGN_WORD;
+	struct list_head_first orig_list ALIGN_WORD;
 } __attribute__((packed));
 
 struct hna_orig_ptr
-- 
1.6.3.1

