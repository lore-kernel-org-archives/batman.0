Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 21 Nov 2011 23:53:13 +0100
Message-Id: <1321915993-29312-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1321915993-29312-1-git-send-email-ordex@autistici.org>
References: <1321915993-29312-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 7/7] batman-adv: add Distributed ARP Table
	compile option
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

This patch makes it possible possible to decide whether to compile DAT or not.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
Reviewed-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 Makefile.kbuild         |    8 +++++++-
 README                  |    4 ++++
 distributed-arp-table.h |   12 ++++++++++++
 3 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index e8861cb..f09004f 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -18,6 +18,8 @@
 # 02110-1301, USA
 #
 
+# uncomment the following line to enable the related feature
+# CONFIG_BATMAN_ADV_DAT=y # Distributed ARP Table
 
 
 # openwrt integration
@@ -27,6 +29,10 @@ endif
 
 # ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
 
+ifeq ($(CONFIG_BATMAN_ADV_DAT), y)
+ccflags-y += -DCONFIG_BATMAN_ADV_DAT
+endif
+
 ifneq ($(REVISION),)
 ccflags-y += -DSOURCE_VERSION=\"$(REVISION)\"
 endif
@@ -36,7 +42,7 @@ batman-adv-y += bat_debugfs.o
 batman-adv-y += bat_iv_ogm.o
 batman-adv-y += bat_sysfs.o
 batman-adv-y += bitarray.o
-batman-adv-y += distributed-arp-table.o
+batman-adv-$(CONFIG_BATMAN_ADV_DAT) += distributed-arp-table.o
 batman-adv-y += gateway_client.o
 batman-adv-y += gateway_common.o
 batman-adv-y += hard-interface.o
diff --git a/README b/README
index b4fdc8d..8a50eda 100644
--- a/README
+++ b/README
@@ -26,6 +26,10 @@ it.  If you work on a backport, feel free to contact us.  :-)
 COMPILE
 -------
 
+Before compiling you want to have a look at the Makefile.kbuild
+file to enable/disable wanted features. Actually there are:
+- CONFIG_BATMAN_ADV_DAT enables the Distributed ARP Table
+
 To compile against your currently installed  kernel, just type:
 
 # make
diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index d3fb8b1..bd32c89 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -28,6 +28,8 @@
 #define ARP_HW_DST(skb) (ARP_HW_SRC(skb) + ETH_ALEN + 4)
 #define ARP_IP_DST(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN * 2 + 4))
 
+#ifdef CONFIG_BATMAN_ADV_DAT
+
 uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb);
 bool arp_snoop_outgoing_request(struct bat_priv *bat_priv,
 				struct sk_buff *skb);
@@ -36,6 +38,16 @@ bool arp_snoop_incoming_request(struct bat_priv *bat_priv,
 bool arp_snoop_outgoing_reply(struct bat_priv *bat_priv, struct sk_buff *skb);
 bool arp_snoop_incoming_reply(struct bat_priv *bat_priv, struct sk_buff *skb);
 
+#else
+
+#define arp_get_type(...) (0)
+#define arp_snoop_outgoing_request(...) (0)
+#define arp_snoop_incoming_request(...) (0)
+#define arp_snoop_outgoing_reply(...)
+#define arp_snoop_incoming_reply(...)
+
+#endif
+
 /* hash function to choose an entry in a hash table of given size */
 /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
 static inline uint32_t hash_ipv4(const void *data, uint32_t size)
-- 
1.7.3.4

