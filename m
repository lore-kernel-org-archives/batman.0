Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 15 Oct 2013 18:01:08 +0200
Message-Id: <1381852869-2104-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Fix static buffer for resolved
	mac adddress
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
Cc: Sven Eckelmann <sven@narfation.org>

The resolve_mac_* functions are currently not reentrant-safe because they are
using ether_aton. Thus all functions returning a mac address in a similar way
must also ensure that their data is in a statically allocated buffer and not on
a stack.

resolve_mac_from_cache did that for the wrong buffer.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/functions.c b/functions.c
index 9e03e72..959784b 100644
--- a/functions.c
+++ b/functions.c
@@ -630,8 +630,8 @@ static int resolve_mac_from_cache_parse(struct ndmsg *ndmsg, size_t len_payload,
 static struct ether_addr *resolve_mac_from_cache(int ai_family,
 						 const void *l3addr)
 {
-	static uint8_t l3addr_tmp[16];
-	struct ether_addr mac_tmp;
+	uint8_t l3addr_tmp[16];
+	static struct ether_addr mac_tmp;
 	struct ether_addr *mac_result = NULL;
 	void *buf = NULL;
 	size_t buflen;
-- 
1.8.4.rc3

