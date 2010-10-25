Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 25 Oct 2010 23:46:05 +0200
Message-Id: <1288043165-8144-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: add seq_printf() wrapper for
	older kernels that don't support %pM
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
 batman-adv/bat_printk.c |   18 ++++++++++++++++++
 batman-adv/compat.h     |    3 +++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/batman-adv/bat_printk.c b/batman-adv/bat_printk.c
index 4fa3e18..69a7f95 100644
--- a/batman-adv/bat_printk.c
+++ b/batman-adv/bat_printk.c
@@ -935,3 +935,21 @@ int bat_snprintf(char *buf, size_t size, const char *fmt, ...)
 
 	return i;
 }
+
+int bat_seq_printf(struct seq_file *m, const char *f, ...)
+{
+	va_list args;
+	int len;
+
+	if (m->count < m->size) {
+		va_start(args, f);
+		len = bat_vsnprintf(m->buf + m->count, m->size - m->count, f, args);
+		va_end(args);
+		if (m->count + len < m->size) {
+			m->count += len;
+			return 0;
+		}
+	}
+	m->count = m->size;
+	return -1;
+}
diff --git a/batman-adv/compat.h b/batman-adv/compat.h
index da474e4..b01455f 100644
--- a/batman-adv/compat.h
+++ b/batman-adv/compat.h
@@ -259,6 +259,9 @@ int bat_sprintf(char *buf, const char *fmt, ...);
 int bat_snprintf(char *buf, size_t size, const char *fmt, ...);
 #define snprintf bat_snprintf
 
+int bat_seq_printf(struct seq_file *m, const char *f, ...);
+#define seq_printf bat_seq_printf
+
 #endif /* < KERNEL_VERSION(2, 6, 29) */
 
 #endif /* _NET_BATMAN_ADV_COMPAT_H_ */
-- 
1.7.1

