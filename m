Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 May 2015 11:37:46 +0200
Message-Id: <1433065068-25957-2-git-send-email-sven@narfation.org>
In-Reply-To: <1433065068-25957-1-git-send-email-sven@narfation.org>
References: <1433065068-25957-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Backport kstrtou64 for Linux
	< 2.6.39
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
 compat-include/linux/kernel.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/compat-include/linux/kernel.h b/compat-include/linux/kernel.h
index 6eee020..e401fe2 100644
--- a/compat-include/linux/kernel.h
+++ b/compat-include/linux/kernel.h
@@ -36,6 +36,18 @@
 		_r = -ERANGE;\
 	_r;\
 })
+
+#define kstrtou64(cp, base, v)\
+({\
+	unsigned long long _v;\
+	int _r;\
+	_r = strict_strtoull(cp, base, &_v);\
+	*(v) = (uint64_t)_v;\
+	if ((unsigned long long)*(v) != _v)\
+		_r = -ERANGE;\
+	_r;\
+})
+
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
-- 
2.1.4

