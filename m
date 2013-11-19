Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 19 Nov 2013 08:26:07 +0100
Message-Id: <1384845967-2497-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat code for kstrtou32
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

kstrtou32() does not exist before 2.6.39. Convert it to
strict_strtoul() in that case.

Used-by: e29249b4483b91d7a590a16e9b5ffe9412ce7fde
("batman-adv: add isolation_mark sysfs attribute")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 compat.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat.h b/compat.h
index 01984b8..334dc5c 100644
--- a/compat.h
+++ b/compat.h
@@ -152,6 +152,8 @@ static inline int batadv_param_set_copystring(const char *val,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
 
+/* cast last argument of strict_strtoul() because we have a uint32_t */
+#define kstrtou32(cp, base, v) strict_strtoul(cp, base, (unsigned long *)v)
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
-- 
1.8.4.3

