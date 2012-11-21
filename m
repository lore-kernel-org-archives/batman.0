Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 21 Nov 2012 13:11:56 +0100
Message-Id: <1353499919-28596-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1353499919-28596-1-git-send-email-ordex@autistici.org>
References: <1353499919-28596-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 6/9] batman-adv: Add function to calculate
	crc32c for the skb payload
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/Kconfig |  1 +
 net/batman-adv/main.c  | 34 ++++++++++++++++++++++++++++++++++
 net/batman-adv/main.h  |  1 +
 3 files changed, 36 insertions(+)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index 250e0b5..8d8afb1 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -6,6 +6,7 @@ config BATMAN_ADV
 	tristate "B.A.T.M.A.N. Advanced Meshing Protocol"
 	depends on NET
 	select CRC16
+	select LIBCRC32C
         default n
 	help
           B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index dc33a0c..f65a222 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -17,6 +17,8 @@
  * 02110-1301, USA
  */
 
+#include <linux/crc32c.h>
+#include <linux/highmem.h>
 #include "main.h"
 #include "sysfs.h"
 #include "debugfs.h"
@@ -420,6 +422,38 @@ int batadv_algo_seq_print_text(struct seq_file *seq, void *offset)
 	return 0;
 }
 
+/**
+ * batadv_skb_crc32 - calculate CRC32 of the whole packet and skip bytes in
+ *  the header
+ * @skb: skb pointing to fragmented socket buffers
+ * @payload_ptr: Pointer to position inside the head buffer of the skb
+ *  marking the start of the data to be CRC'ed
+ *
+ * payload_ptr must always point to an address in the skb head buffer and not to
+ * a fragment.
+ */
+__be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
+{
+	u32 crc = 0;
+	unsigned int from;
+	unsigned int to = skb->len;
+	struct skb_seq_state st;
+	const u8 *data;
+	unsigned int len;
+	unsigned int consumed = 0;
+
+	from = (unsigned int)(payload_ptr - skb->data);
+
+	skb_prepare_seq_read(skb, from, to, &st);
+	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
+		crc = crc32c(crc, data, len);
+		consumed += len;
+	}
+	skb_abort_seq_read(&st);
+
+	return htonl(crc);
+}
+
 static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 {
 	struct batadv_algo_ops *bat_algo_ops;
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 8f149bb..ce5e5b9 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -174,6 +174,7 @@ void batadv_recv_handler_unregister(uint8_t packet_type);
 int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops);
 int batadv_algo_select(struct batadv_priv *bat_priv, char *name);
 int batadv_algo_seq_print_text(struct seq_file *seq, void *offset);
+__be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
 
 /**
  * enum batadv_dbg_level - available log levels
-- 
1.8.0

