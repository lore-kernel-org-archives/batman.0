Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 15 Oct 2013 18:01:09 +0200
Message-Id: <1381852869-2104-2-git-send-email-sven@narfation.org>
In-Reply-To: <1381852869-2104-1-git-send-email-sven@narfation.org>
References: <1381852869-2104-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Finish resolving of mac address
	early
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

It is not necessary to check the remaining msg buffer coming from the kernel
when already the correct mac address was found.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/functions.c b/functions.c
index 959784b..f2b23f2 100644
--- a/functions.c
+++ b/functions.c
@@ -683,6 +683,7 @@ static struct ether_addr *resolve_mac_from_cache(int ai_family,
 			if (parsed) {
 				if (memcmp(&l3addr_tmp, l3addr, l3_len) == 0) {
 					mac_result = &mac_tmp;
+					finished = 1;
 					break;
 				}
 			}
-- 
1.8.4.rc3

