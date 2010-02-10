Return-Path: <linus.luessing@web.de>
Date: Wed, 10 Feb 2010 03:36:41 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100210023641.GA2112@Linus-Debian>
References: <20100208205602.GA9369@Sellars>
 <20100208213212.GA9389@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20100208213212.GA9389@Sellars>
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: use original printk in bat_printk
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

bat_printk is calling a printk which got previously
substituted because of the define in compat.h.
This patch removes the define for the scope of
bat_printk.c.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
diff --git a/batman-adv-kernelland/bat_printk.c b/batman-adv-kernelland/bat_printk.c
index a55eff3..556620a 100644
--- a/batman-adv-kernelland/bat_printk.c
+++ b/batman-adv-kernelland/bat_printk.c
@@ -35,6 +35,13 @@
 /* Works only for digits and letters, but small and fast */
 #define TOLOWER(x) ((x) | 0x20)
 
+/* We don't want to recursively call bat_printk here
+   because of the previous define in compat.h */
+#ifdef printk
+#define ___printk printk
+#undef printk
+#endif
+
 static int skip_atoi(const char **s)
 {
 	int i = 0;
@@ -853,3 +860,8 @@ asmlinkage int bat_printk(const char *fmt, ...)
 
 	return printk("foo:%s", buf);
 }
+
+#ifdef ___printk
+#define printk ___printk
+#undef ___printk
+#endif
