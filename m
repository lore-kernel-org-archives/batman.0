Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Apr 2015 18:56:20 +0200
Message-Id: <1429548982-10628-2-git-send-email-sven@narfation.org>
In-Reply-To: <1429548982-10628-1-git-send-email-sven@narfation.org>
References: <1429548982-10628-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/4] batman-adv: Add Kconfig to the sources
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

The Kconfig file is not used by the out-of-tree module but it has to be
modified when new patches are added which would modify it in the kernel tree.
Otherwise the information has to be stored somewhere else until someone submits
it to the Networking maintainer.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2: Moved from main patch to extra patch

 net/batman-adv/Kconfig | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 net/batman-adv/Kconfig

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
new file mode 100644
index 0000000..c6fc8f7
--- /dev/null
+++ b/net/batman-adv/Kconfig
@@ -0,0 +1,70 @@
+#
+# B.A.T.M.A.N meshing protocol
+#
+
+config BATMAN_ADV
+	tristate "B.A.T.M.A.N. Advanced Meshing Protocol"
+	depends on NET
+	select CRC16
+	select LIBCRC32C
+        default n
+	help
+          B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
+          a routing protocol for multi-hop ad-hoc mesh networks. The
+          networks may be wired or wireless. See
+          http://www.open-mesh.org/ for more information and user space
+          tools.
+
+config BATMAN_ADV_BLA
+	bool "Bridge Loop Avoidance"
+	depends on BATMAN_ADV && INET
+	default y
+	help
+	  This option enables BLA (Bridge Loop Avoidance), a mechanism
+	  to avoid Ethernet frames looping when mesh nodes are connected
+	  to both the same LAN and the same mesh. If you will never use
+	  more than one mesh node in the same LAN, you can safely remove
+	  this feature and save some space.
+
+config BATMAN_ADV_DAT
+	bool "Distributed ARP Table"
+	depends on BATMAN_ADV && INET
+	default n
+	help
+	  This option enables DAT (Distributed ARP Table), a DHT based
+	  mechanism that increases ARP reliability on sparse wireless
+	  mesh networks. If you think that your network does not need
+	  this option you can safely remove it and save some space.
+
+config BATMAN_ADV_NC
+	bool "Network Coding"
+	depends on BATMAN_ADV
+	default n
+	help
+	  This option enables network coding, a mechanism that aims to
+	  increase the overall network throughput by fusing multiple
+	  packets in one transmission.
+	  Note that interfaces controlled by batman-adv must be manually
+	  configured to have promiscuous mode enabled in order to make
+	  network coding work.
+	  If you think that your network does not need this feature you
+	  can safely disable it and save some space.
+
+config BATMAN_ADV_MCAST
+	bool "Multicast optimisation"
+	depends on BATMAN_ADV
+	default n
+	help
+	  This option enables the multicast optimisation which aims to
+	  reduce the air overhead while improving the reliability of
+	  multicast messages.
+
+config BATMAN_ADV_DEBUG
+	bool "B.A.T.M.A.N. debugging"
+	depends on BATMAN_ADV
+	depends on DEBUG_FS
+	help
+	  This is an option for use by developers; most people should
+	  say N here. This enables compilation of support for
+	  outputting debugging information to the kernel log. The
+	  output is controlled via the module parameter debug.
-- 
2.1.4

