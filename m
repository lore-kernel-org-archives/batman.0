Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat,  4 Jan 2014 18:03:31 +0100
Message-Id: <1388855012-8849-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH-next 1/2] batctl: change version to 2014.0.0
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

Since we delayed the 2013.5.0 release to 2014, change the release name.

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 main.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.h b/main.h
index 6ee7c46..0839771 100644
--- a/main.h
+++ b/main.h
@@ -23,7 +23,7 @@
 #define _BATCTL_MAIN_H
 
 #ifndef SOURCE_VERSION
-#define SOURCE_VERSION "2013.5.0"
+#define SOURCE_VERSION "2014.0.0"
 #endif
 
 #define SOCKET_PATH_FMT "%s/batman_adv/%s/socket"
-- 
1.7.10.4

