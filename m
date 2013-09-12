Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Sep 2013 22:58:37 +0200
Message-Id: <1379019524-23543-7-git-send-email-sven@narfation.org>
In-Reply-To: <1379019524-23543-1-git-send-email-sven@narfation.org>
References: <1379019524-23543-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/13] batmand: Fix preprocessor check for
	defined NO_POLICY_ROUTING
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 linux/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux/route.c b/linux/route.c
index 7934c27..12f7734 100644
--- a/linux/route.c
+++ b/linux/route.c
@@ -69,7 +69,7 @@ static const char *rule_type_to_string_script[] = {
  *
  ***/
 
-#if NO_POLICY_ROUTING
+#ifdef NO_POLICY_ROUTING
 
 #include <net/route.h>
 
-- 
1.8.4.rc3

