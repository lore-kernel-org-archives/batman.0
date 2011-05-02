Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  2 May 2011 16:53:44 +0200
Message-Id: <1304348024-11681-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: purge unnecessary include
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 compat.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/compat.h b/compat.h
index 0c5ad82..bddf7e2 100644
--- a/compat.h
+++ b/compat.h
@@ -26,7 +26,6 @@
 #define _NET_BATMAN_ADV_COMPAT_H_
 
 #include <linux/version.h>	/* LINUX_VERSION_CODE */
-#include "bat_sysfs.h"		/* struct bat_attribute */
 
 #ifndef IPPROTO_UDP
 #define IPPROTO_UDP 17
-- 
1.7.2.3

