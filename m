Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 10 Oct 2010 15:38:11 +0200
Message-Id: <1286717891-17091-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix wrongly formatted %pM in
	bat_dbg()
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

bat_dbg() invokes debug_log() which invokes the kernel's vscnprintf(),
which invokes the kernel's vsnprintf(), and not the customized
bat_vsnprintf(), which backports the %pM to older kernel versions!

Therefore this commit ports a customized vscnprintf() to bat_printk.c,
too, making mac addresses being displayed correctly with bat_dbg()
again.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_printk.c |   25 +++++++++++++++++++++++++
 compat.h     |    3 +++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/bat_printk.c b/bat_printk.c
index 4a02d7e..6615876 100644
--- a/bat_printk.c
+++ b/bat_printk.c
@@ -838,6 +838,31 @@ static int bat_vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 }
 
 /**
+ * bat_vscnprintf - Format a string and place it in a buffer
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @args: Arguments for the format string
+ *
+ * The return value is the number of characters which have been written into
+ * the @buf not including the trailing '\0'. If @size is <= 0 the function
+ * returns 0.
+ *
+ * Call this function if you are already dealing with a va_list.
+ * You probably want scnprintf() instead.
+ *
+ * See the vsnprintf() documentation for format string extensions over C99.
+ */
+int bat_vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
+{
+        int i;
+
+        i = bat_vsnprintf(buf, size, fmt, args);
+
+        return (i >= size) ? (size - 1) : i;
+}
+
+/**
  * bat_printk - print a kernel message using extra %p formatting
  * strings, forward compatible with kernel version 2.6.31 printk, minus
  * *p[sS].
diff --git a/compat.h b/compat.h
index d59d709..5c02b44 100644
--- a/compat.h
+++ b/compat.h
@@ -256,6 +256,9 @@ next_sibling:
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
 
+int bat_vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
+#define vscnprintf bat_vscnprintf
+
 asmlinkage int bat_printk(const char *fmt, ...);
 #define printk bat_printk
 
-- 
1.7.1

