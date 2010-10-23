Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Oct 2010 17:11:35 +0200
Message-Id: <1287846695-17402-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove obsolete flags variable
	to avoid kernel warnings
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
 batman-adv/bat_debugfs.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
index 11e5f65..934c879 100644
--- a/batman-adv/bat_debugfs.c
+++ b/batman-adv/bat_debugfs.c
@@ -57,7 +57,6 @@ static int fdebug_log(struct debug_log *debug_log, char *fmt, ...)
 	va_list args;
 	static char debug_log_buf[256];
 	char *p;
-	unsigned long flags;
 
 	if (!debug_log)
 		return 0;
@@ -113,7 +112,6 @@ static ssize_t log_read(struct file *file, char __user *buf,
 	struct debug_log *debug_log = bat_priv->debug_log;
 	int error, i = 0;
 	char c;
-	unsigned long flags;
 
 	if ((file->f_flags & O_NONBLOCK) &&
 	    !(debug_log->log_end - debug_log->log_start))
-- 
1.7.1

