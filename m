Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: batman-adv: Include random.h for get_random_u32_below
Date: Tue, 27 Dec 2022 09:03:01 +0100
Message-Id: <20221227080301.516810-2-sven@narfation.org>
In-Reply-To: <20221227080301.516810-1-sven@narfation.org>
References: <20221227080301.516810-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The commit a15d3f3c1c2a ("batman-adv: use get_random_u32_below() instead of
deprecated function") replaced the prandom.h function prandom_u32_max with
the random.h function get_random_u32_below.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 5e1f422b3a94b119746a6b3b5cf64182951e8eb3..ecd871abda34284cd01ae7863f8852e479ccc23d 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -26,6 +26,7 @@
 #include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/printk.h>
+#include <linux/random.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/skbuff.h>
