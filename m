Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu,  5 May 2016 12:35:19 +0200
Message-Id: <1462444519-26509-2-git-send-email-sven.eckelmann@open-mesh.com>
In-Reply-To: <1462444519-26509-1-git-send-email-sven.eckelmann@open-mesh.com>
References: <1462444519-26509-1-git-send-email-sven.eckelmann@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Add missing include for
	container_of
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Fixes: 0d8468553c3c ("batman-adv: remove ogm_emit and ogm_schedule API calls")
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
Problem was found by https://lists.open-mesh.org/pipermail/linux-merge/2016-May/003146.html

 net/batman-adv/bat_iv_ogm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 67bdba1..4815db9 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -30,6 +30,7 @@
 #include <linux/if_ether.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/kref.h>
 #include <linux/lockdep.h>
-- 
2.8.1

