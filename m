Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 May 2013 16:15:25 +0800
Message-Id: <1368346525-15171-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: fix false uninitialized variable
	warning when compiling with O2
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 functions.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/functions.c b/functions.c
index a025395..cc05a48 100644
--- a/functions.c
+++ b/functions.c
@@ -458,7 +458,7 @@ static void request_arp(uint32_t ipv4_addr)
 static struct ether_addr *resolve_mac_from_arp(uint32_t ipv4_addr)
 {
 	struct ether_addr mac_empty;
-	struct ether_addr *mac_result = NULL, *mac_tmp;
+	struct ether_addr *mac_result = NULL, *mac_tmp = NULL;
 	struct sockaddr_in inet4;
 	int ret;
 	FILE *f;
-- 
1.7.10.4

