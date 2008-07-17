Message-Id: <A2A8A9D0-44EF-4330-8AEE-4A17F741C109@gmail.com>
From: Scott Raynel <scottraynel@gmail.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-1--419391626
Mime-Version: 1.0 (Apple Message framework v926)
Date: Thu, 17 Jul 2008 13:34:53 +1200
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv-kernelland linux-2.6.21
	compatibility
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net


--Apple-Mail-1--419391626
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi there,

Not sure how you guys want patches submitted, so point me in the right  
direction if this is not it. Here's a simple patch that enables  
compilation on linux-2.6.21 (and possibly earlier, though I've tested  
2.6.16 and it doesn't work).

Cheers,

--
Scott Raynel
WAND Network Research Group
Department of Computer Science
University of Waikato
New Zealand



--Apple-Mail-1--419391626
Content-Disposition: attachment;
	filename=compat-2.6.21.patch
Content-Type: application/octet-stream; x-unix-mode=0644;
	name="compat-2.6.21.patch"
Content-Transfer-Encoding: 7bit

diff --git a/batman-adv-kernelland/batman-core/compat.h b/batman-adv-kernelland/batman-core/compat.h
new file mode 100644
index 0000000..cb94665
--- /dev/null
+++ b/batman-adv-kernelland/batman-core/compat.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2007-2008 B.A.T.M.A.N. contributors:
+ * Marek Lindner, Simon Wunderlich
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,22)
+
+#define skb_set_network_header(_skb, _offset) \
+	do { (_skb)->nh.raw = (_skb)->data + (_offset); } while (0)
+
+#define skb_reset_mac_header(_skb) \
+	do { (_skb)->mac.raw = (_skb)->data; } while (0)
+
+#define list_first_entry(ptr, type, member) \
+	list_entry((ptr)->next, type, member)
+
+#endif
diff --git a/batman-adv-kernelland/batman-core/device.c b/batman-adv-kernelland/batman-core/device.c
index 80bc31c..18b026a 100644
--- a/batman-adv-kernelland/batman-core/device.c
+++ b/batman-adv-kernelland/batman-core/device.c
@@ -28,7 +28,7 @@
 #include "types.h"
 #include "hash.h"
 
-
+#include "compat.h"
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 #include <linux/devfs_fs_kernel.h>
diff --git a/batman-adv-kernelland/batman-core/send.c b/batman-adv-kernelland/batman-core/send.c
index ee6e8de..48e05bc 100644
--- a/batman-adv-kernelland/batman-core/send.c
+++ b/batman-adv-kernelland/batman-core/send.c
@@ -29,6 +29,7 @@
 #include "types.h"
 #include "vis.h"
 
+#include "compat.h"
 
 
 static DECLARE_DELAYED_WORK(send_own_packet_wq, send_own_packet_work);
@@ -73,7 +74,7 @@ void send_raw_packet(unsigned char *pack_buff, int pack_buff_len, uint8_t *src_a
 	ethhdr->h_proto = htons(ETH_P_BATMAN);
 
 	skb_reset_mac_header(skb);
-	skb->network_header = skb->mac_header + ETH_HLEN;
+	skb_set_network_header(skb, ETH_HLEN);
 	skb->priority = TC_PRIO_CONTROL;
 	skb->protocol = __constant_htons(ETH_P_BATMAN);
 	skb->dev = batman_if->net_dev;

--Apple-Mail-1--419391626--
