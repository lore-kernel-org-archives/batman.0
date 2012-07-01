Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  2 Jul 2012 01:43:41 +0200
Message-Id: <1341186226-10549-12-git-send-email-ordex@autistici.org>
In-Reply-To: <1341186226-10549-1-git-send-email-ordex@autistici.org>
References: <1341186226-10549-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 11/16] batman-adv: Transform
	BATADV_LOG_BUFF(idx) into function
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

The linux Documentation/CodingStyle says that:
 * Chapter 12: "inline functions are preferable to macros resembling functions"
 * Chapter 12.2: Depending on local variables with a magic name is bad
 * Chapter 12.3: Macros with arguments used as l-value are bad

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/bat_debugfs.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_debugfs.c b/net/batman-adv/bat_debugfs.c
index db7b9bf..acf33e2 100644
--- a/net/batman-adv/bat_debugfs.c
+++ b/net/batman-adv/bat_debugfs.c
@@ -36,13 +36,21 @@ static struct dentry *batadv_debugfs;
 
 #ifdef CONFIG_BATMAN_ADV_DEBUG
 #define BATADV_LOG_BUFF_MASK (batadv_log_buff_len - 1)
-#define BATADV_LOG_BUFF(idx) (debug_log->log_buff[(idx) & BATADV_LOG_BUFF_MASK])
 
-static int batadv_log_buff_len = BATADV_LOG_BUF_LEN;
+static const int batadv_log_buff_len = BATADV_LOG_BUF_LEN;
+
+static char *batadv_log_char_addr(struct batadv_debug_log *debug_log,
+				  size_t idx)
+{
+	return &debug_log->log_buff[idx & BATADV_LOG_BUFF_MASK];
+}
 
 static void batadv_emit_log_char(struct batadv_debug_log *debug_log, char c)
 {
-	BATADV_LOG_BUFF(debug_log->log_end) = c;
+	char *char_addr;
+
+	char_addr = batadv_log_char_addr(debug_log, debug_log->log_end);
+	*char_addr = c;
 	debug_log->log_end++;
 
 	if (debug_log->log_end - debug_log->log_start > batadv_log_buff_len)
@@ -109,6 +117,7 @@ static ssize_t batadv_log_read(struct file *file, char __user *buf,
 	struct batadv_priv *bat_priv = file->private_data;
 	struct batadv_debug_log *debug_log = bat_priv->debug_log;
 	int error, i = 0;
+	char *char_addr;
 	char c;
 
 	if ((file->f_flags & O_NONBLOCK) &&
@@ -134,7 +143,9 @@ static ssize_t batadv_log_read(struct file *file, char __user *buf,
 
 	while ((!error) && (i < count) &&
 	       (debug_log->log_start != debug_log->log_end)) {
-		c = BATADV_LOG_BUFF(debug_log->log_start);
+		char_addr = batadv_log_char_addr(debug_log,
+						 debug_log->log_start);
+		c = *char_addr;
 
 		debug_log->log_start++;
 
-- 
1.7.9.4

