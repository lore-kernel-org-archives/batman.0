Return-Path: <andrew.lunn@ascom.ch>
Date: Sat, 18 Jul 2009 16:42:42 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090718144242.GL4656@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [batman-adv] Cleanup log.[ch]
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

Make log.[ch] clean with respect to the 2.6.29 checkpatch
script. 

Signed-off-by: Andrew Lunn <andrew.lunn@ascom.ch>
Index: batman-adv-kernelland/log.c
===================================================================
--- batman-adv-kernelland/log.c	(revision 1351)
+++ batman-adv-kernelland/log.c	(working copy)
@@ -17,28 +17,21 @@
  *
  */
 
-
-
-
-
 #include "main.h"
 #include "log.h"
 
-
 #define LOG_BUF_MASK (log_buf_len-1)
 #define LOG_BUF(idx) (log_buf[(idx) & LOG_BUF_MASK])
 
-
-
 static char log_buf[LOG_BUF_LEN];
 static int log_buf_len = LOG_BUF_LEN;
-static unsigned long log_start = 0;
-static unsigned long log_end = 0;
-volatile uint8_t log_level = 0;
+static unsigned long log_start;
+static unsigned long log_end;
+uint8_t log_level;
 
 static DEFINE_SPINLOCK(logbuf_lock);
 
-struct file_operations proc_log_operations = {
+const struct file_operations proc_log_operations = {
 	.open           = log_open,
 	.release        = log_release,
 	.read           = log_read,
@@ -48,7 +41,6 @@
 
 static DECLARE_WAIT_QUEUE_HEAD(log_wait);
 
-
 static void emit_log_char(char c)
 {
 	LOG_BUF(log_end) = c;
@@ -68,7 +60,8 @@
 
 	spin_lock_irqsave(&logbuf_lock, flags);
 	va_start(args, fmt);
-	printed_len = vscnprintf(debug_log_buf, sizeof(debug_log_buf), fmt, args);
+	printed_len = vscnprintf(debug_log_buf, sizeof(debug_log_buf), fmt,
+				 args);
 	va_end(args);
 
 	for (p = debug_log_buf; *p != 0; p++)
@@ -81,7 +74,6 @@
 	return 0;
 }
 
-
 int debug_log(int type, char *fmt, ...)
 {
 	va_list args;
@@ -92,7 +84,7 @@
 	if (type == LOG_TYPE_CRIT) {
 		va_start(args, fmt);
 		vscnprintf(tmp_log_buf, sizeof(tmp_log_buf), fmt, args);
-		printk("batman-adv: %s", tmp_log_buf);
+		printk(KERN_ERR "batman-adv: %s", tmp_log_buf);
 		va_end(args);
 	}
 
@@ -106,19 +98,20 @@
 	return retval;
 }
 
-int log_open(struct inode * inode, struct file * file)
+int log_open(struct inode *inode, struct file *file)
 {
 	inc_module_count();
 	return 0;
 }
 
-int log_release(struct inode * inode, struct file * file)
+int log_release(struct inode *inode, struct file *file)
 {
 	dec_module_count();
 	return 0;
 }
 
-ssize_t log_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+ssize_t log_read(struct file *file, char __user *buf, size_t count,
+		 loff_t *ppos)
 {
 	int error, i = 0;
 	char c;
@@ -150,7 +143,7 @@
 
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 
-		error = __put_user(c,buf);
+		error = __put_user(c, buf);
 
 		spin_lock_irqsave(&logbuf_lock, flags);
 
@@ -167,7 +160,8 @@
 	return error;
 }
 
-ssize_t log_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+ssize_t log_write(struct file *file, const char __user *buf, size_t count,
+		  loff_t *ppos)
 {
 	return count;
 }
@@ -181,4 +175,3 @@
 
 	return 0;
 }
-
Index: batman-adv-kernelland/log.h
===================================================================
--- batman-adv-kernelland/log.h	(revision 1351)
+++ batman-adv-kernelland/log.h	(working copy)
@@ -17,18 +17,14 @@
  *
  */
 
+extern const struct file_operations proc_log_operations;
+extern uint8_t log_level;
 
-
-
-
-extern struct file_operations proc_log_operations;
-extern volatile uint8_t log_level;
-
-
 int debug_log(int type, char *fmt, ...);
-int log_open(struct inode * inode, struct file * file);
-int log_release(struct inode * inode, struct file * file);
-ssize_t log_read(struct file *file, char __user *buf, size_t count, loff_t *ppos);
-ssize_t log_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos);
+int log_open(struct inode *inode, struct file *file);
+int log_release(struct inode *inode, struct file *file);
+ssize_t log_read(struct file *file, char __user *buf, size_t count,
+		 loff_t *ppos);
+ssize_t log_write(struct file *file, const char __user *buf, size_t count,
+		  loff_t *ppos);
 unsigned int log_poll(struct file *file, poll_table *wait);
-
