Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon,  9 May 2011 10:15:32 +0200
Message-Id: <1304928932-10114-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix build with linux
	2.6.25-2.6.27
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

We must prevent that IPPROTO_UDP gets redefined using compat.h.
Otherwise the build will fail when including things like net/addrconf.h

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/compat.c b/compat.c
index 70de376..586898f 100644
--- a/compat.c
+++ b/compat.c
@@ -1,3 +1,4 @@
+#include <linux/in.h>
 #include <linux/version.h>
 #include "main.h"
 
-- 
1.7.5.1

