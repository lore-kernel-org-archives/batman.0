From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed,  3 Jun 2009 12:39:26 +0200
Message-Id: <1244025566-13147-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1243965365-6526-1-git-send-email-sven.eckelmann@gmx.de>
References: <1243965365-6526-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2] [batman] Align pointers in hna list
	elements
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
 batman/batman.h |    1 +
 batman/hna.h    |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/batman/batman.h b/batman/batman.h
index d6b00cf..23f8e9a 100644
--- a/batman/batman.h
+++ b/batman/batman.h
@@ -153,6 +153,7 @@
 
 #define BATMANUNUSED(x) (x)__attribute__((unused))
 #define ALIGN_WORD __attribute__ ((aligned(sizeof(TYPE_OF_WORD))))
+#define ALIGN_POINTER __attribute__ ((aligned(sizeof(void*))))
 
 
 
diff --git a/batman/hna.h b/batman/hna.h
index 6063324..a046857 100644
--- a/batman/hna.h
+++ b/batman/hna.h
@@ -58,8 +58,8 @@ struct hna_global_entry
 {
 	uint32_t addr;
 	uint8_t netmask;
-	struct orig_node *curr_orig_node;
-	struct list_head_first orig_list;
+	struct orig_node *curr_orig_node ALIGN_POINTER;
+	struct list_head_first orig_list ALIGN_POINTER;
 } __attribute__((packed));
 
 struct hna_orig_ptr
-- 
1.6.3.1

