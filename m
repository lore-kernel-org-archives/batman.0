Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 17 Oct 2012 22:15:07 +0200
Message-Id: <1350504907-21477-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Provide default SOURCE_VERSION for
	tarball distribution
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 alfred.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/alfred.h b/alfred.h
index 795a78a..bfc7649 100644
--- a/alfred.h
+++ b/alfred.h
@@ -25,6 +25,10 @@
 #include "hash.h"
 #define __packed __attribute__ ((packed))
 
+#ifndef SOURCE_VERSION
+#define SOURCE_VERSION "2013.0.0"
+#endif
+
 struct alfred_data {
 	uint8_t source[ETH_ALEN];
 	uint8_t type;
-- 
1.7.10.4

