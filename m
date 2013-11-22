Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 22 Nov 2013 18:38:30 +0100
Message-Id: <1385141910-2670-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix compat macro for kstrtou32
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

The macro previously introduced in the compat code to replace
kstrtou32() may not work properly in case of a too large
user input.

Fix it by using a temporary variable of the proper length
and then cast the result.

Possibly return -ERANGE is the result is too big to fix a 32bit
long variable.

Cc: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 compat.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/compat.h b/compat.h
index a050bb8..6daeff9 100644
--- a/compat.h
+++ b/compat.h
@@ -152,8 +152,16 @@ static inline int batadv_param_set_copystring(const char *val,
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
 
-/* cast last argument of strict_strtoul() because we have a uint32_t */
-#define kstrtou32(cp, base, v) strict_strtoul(cp, base, (unsigned long *)v)
+#define kstrtou32(cp, base, v)\
+({\
+	unsigned long _v;\
+	int _r;\
+	_r = strict_strtoul(cp, base, &_v);\
+	*(v) = (uint32_t)_v;\
+	if ((unsigned long)*(v) != _v)\
+		_r = -ERANGE;\
+	_r;\
+})
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
-- 
1.8.4.4

