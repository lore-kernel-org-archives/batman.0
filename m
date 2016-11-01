Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  1 Nov 2016 07:17:50 +0100
Message-Id: <20161101061750.15995-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Deactivate __ro_after_init for
	kernels < 4.10
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

The pre-4.10 kernels must write to batadv_netlink_family after the family
was registered. Thus disabling __ro_after_init for now is required on these
kernels.

Fixes: c776b4a071d8 ("batman-adv: genetlink: mark families as __ro_after_init")
Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/cache.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/compat-include/linux/cache.h b/compat-include/linux/cache.h
index 93dff58..7b7069a 100644
--- a/compat-include/linux/cache.h
+++ b/compat-include/linux/cache.h
@@ -24,11 +24,13 @@
 #include <linux/version.h>
 #include_next <linux/cache.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 10, 0)
 
-#ifndef __ro_after_init
-#define __ro_after_init
+/* hack for netlink.c which marked the family ops as ro */
+#ifdef __ro_after_init
+#undef __ro_after_init
 #endif
+#define __ro_after_init
 
 #endif /* < KERNEL_VERSION(4, 6, 0) */
 
-- 
2.10.2

