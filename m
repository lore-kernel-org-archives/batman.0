Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Apr 2015 12:45:06 +0200
Message-Id: <1429613108-19928-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 1/3] batman-adv: Use kernel-like folder
	structure
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

The person submitting the patches to the Networking maintainer has to take
each patch and move files around and add some files to make it work in the
actual kernel tree. Having all files included and already  in the correct
kernel tree layout should make this a lot easier.

The only files not part of the kernel tree are compat-include and every
regular file in the top level directory.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v3: Rebased it on current master without the the hashtable patches
v2:
 * Cleaned up the Makefile
 * Rebased on top of 9f01c16a4409e43e86629418fae9184fabb59da5
 * Use symlink to show the Documentation/networking/batman-adv.txt as README
   in the root folder

 .../ABI/testing/sysfs-class-net-batman-adv         |  0
 .../ABI/testing/sysfs-class-net-mesh               |  0
 README => Documentation/networking/batman-adv.txt  |  0
 Makefile                                           | 22 +++++++++++++++-------
 Makefile.kbuild => net/batman-adv/Makefile         |  0
 bat_algo.h => net/batman-adv/bat_algo.h            |  0
 bat_iv_ogm.c => net/batman-adv/bat_iv_ogm.c        |  0
 bitarray.c => net/batman-adv/bitarray.c            |  0
 bitarray.h => net/batman-adv/bitarray.h            |  0
 .../batman-adv/bridge_loop_avoidance.c             |  0
 .../batman-adv/bridge_loop_avoidance.h             |  0
 debugfs.c => net/batman-adv/debugfs.c              |  0
 debugfs.h => net/batman-adv/debugfs.h              |  0
 .../batman-adv/distributed-arp-table.c             |  0
 .../batman-adv/distributed-arp-table.h             |  0
 fragmentation.c => net/batman-adv/fragmentation.c  |  0
 fragmentation.h => net/batman-adv/fragmentation.h  |  0
 .../batman-adv/gateway_client.c                    |  0
 .../batman-adv/gateway_client.h                    |  0
 .../batman-adv/gateway_common.c                    |  0
 .../batman-adv/gateway_common.h                    |  0
 .../batman-adv/hard-interface.c                    |  0
 .../batman-adv/hard-interface.h                    |  0
 hash.c => net/batman-adv/hash.c                    |  0
 hash.h => net/batman-adv/hash.h                    |  0
 icmp_socket.c => net/batman-adv/icmp_socket.c      |  0
 icmp_socket.h => net/batman-adv/icmp_socket.h      |  0
 main.c => net/batman-adv/main.c                    |  0
 main.h => net/batman-adv/main.h                    |  0
 multicast.c => net/batman-adv/multicast.c          |  0
 multicast.h => net/batman-adv/multicast.h          |  0
 .../batman-adv/network-coding.c                    |  0
 .../batman-adv/network-coding.h                    |  0
 originator.c => net/batman-adv/originator.c        |  0
 originator.h => net/batman-adv/originator.h        |  0
 packet.h => net/batman-adv/packet.h                |  0
 routing.c => net/batman-adv/routing.c              |  0
 routing.h => net/batman-adv/routing.h              |  0
 send.c => net/batman-adv/send.c                    |  0
 send.h => net/batman-adv/send.h                    |  0
 .../batman-adv/soft-interface.c                    |  0
 .../batman-adv/soft-interface.h                    |  0
 sysfs.c => net/batman-adv/sysfs.c                  |  0
 sysfs.h => net/batman-adv/sysfs.h                  |  0
 .../batman-adv/translation-table.c                 |  0
 .../batman-adv/translation-table.h                 |  0
 types.h => net/batman-adv/types.h                  |  0
 47 files changed, 15 insertions(+), 7 deletions(-)
 rename sysfs-class-net-batman-adv => Documentation/ABI/testing/sysfs-class-net-batman-adv (100%)
 rename sysfs-class-net-mesh => Documentation/ABI/testing/sysfs-class-net-mesh (100%)
 rename README => Documentation/networking/batman-adv.txt (100%)
 rename Makefile.kbuild => net/batman-adv/Makefile (100%)
 rename bat_algo.h => net/batman-adv/bat_algo.h (100%)
 rename bat_iv_ogm.c => net/batman-adv/bat_iv_ogm.c (100%)
 rename bitarray.c => net/batman-adv/bitarray.c (100%)
 rename bitarray.h => net/batman-adv/bitarray.h (100%)
 rename bridge_loop_avoidance.c => net/batman-adv/bridge_loop_avoidance.c (100%)
 rename bridge_loop_avoidance.h => net/batman-adv/bridge_loop_avoidance.h (100%)
 rename debugfs.c => net/batman-adv/debugfs.c (100%)
 rename debugfs.h => net/batman-adv/debugfs.h (100%)
 rename distributed-arp-table.c => net/batman-adv/distributed-arp-table.c (100%)
 rename distributed-arp-table.h => net/batman-adv/distributed-arp-table.h (100%)
 rename fragmentation.c => net/batman-adv/fragmentation.c (100%)
 rename fragmentation.h => net/batman-adv/fragmentation.h (100%)
 rename gateway_client.c => net/batman-adv/gateway_client.c (100%)
 rename gateway_client.h => net/batman-adv/gateway_client.h (100%)
 rename gateway_common.c => net/batman-adv/gateway_common.c (100%)
 rename gateway_common.h => net/batman-adv/gateway_common.h (100%)
 rename hard-interface.c => net/batman-adv/hard-interface.c (100%)
 rename hard-interface.h => net/batman-adv/hard-interface.h (100%)
 rename hash.c => net/batman-adv/hash.c (100%)
 rename hash.h => net/batman-adv/hash.h (100%)
 rename icmp_socket.c => net/batman-adv/icmp_socket.c (100%)
 rename icmp_socket.h => net/batman-adv/icmp_socket.h (100%)
 rename main.c => net/batman-adv/main.c (100%)
 rename main.h => net/batman-adv/main.h (100%)
 rename multicast.c => net/batman-adv/multicast.c (100%)
 rename multicast.h => net/batman-adv/multicast.h (100%)
 rename network-coding.c => net/batman-adv/network-coding.c (100%)
 rename network-coding.h => net/batman-adv/network-coding.h (100%)
 rename originator.c => net/batman-adv/originator.c (100%)
 rename originator.h => net/batman-adv/originator.h (100%)
 rename packet.h => net/batman-adv/packet.h (100%)
 rename routing.c => net/batman-adv/routing.c (100%)
 rename routing.h => net/batman-adv/routing.h (100%)
 rename send.c => net/batman-adv/send.c (100%)
 rename send.h => net/batman-adv/send.h (100%)
 rename soft-interface.c => net/batman-adv/soft-interface.c (100%)
 rename soft-interface.h => net/batman-adv/soft-interface.h (100%)
 rename sysfs.c => net/batman-adv/sysfs.c (100%)
 rename sysfs.h => net/batman-adv/sysfs.h (100%)
 rename translation-table.c => net/batman-adv/translation-table.c (100%)
 rename translation-table.h => net/batman-adv/translation-table.h (100%)
 rename types.h => net/batman-adv/types.h (100%)

diff --git a/sysfs-class-net-batman-adv b/Documentation/ABI/testing/sysfs-class-net-batman-adv
similarity index 100%
rename from sysfs-class-net-batman-adv
rename to Documentation/ABI/testing/sysfs-class-net-batman-adv
diff --git a/sysfs-class-net-mesh b/Documentation/ABI/testing/sysfs-class-net-mesh
similarity index 100%
rename from sysfs-class-net-mesh
rename to Documentation/ABI/testing/sysfs-class-net-mesh
diff --git a/README b/Documentation/networking/batman-adv.txt
similarity index 100%
rename from README
rename to Documentation/networking/batman-adv.txt
diff --git a/Makefile b/Makefile
index e57fcb3..8a04d12 100644
--- a/Makefile
+++ b/Makefile
@@ -41,26 +41,34 @@ RM ?= rm -f
 REVISION= $(shell	if [ -d "$(PWD)/.git" ]; then \
 				echo $$(git --git-dir="$(PWD)/.git" describe --always --dirty --match "v*" |sed 's/^v//' 2> /dev/null || echo "[unknown]"); \
 			fi)
-NOSTDINC_FLAGS := \
+export NOSTDINC_FLAGS := \
 	-I$(PWD)/compat-include/ \
 	-include $(PWD)/compat.h \
 	$(CFLAGS)
 
-CONFIG_BATMAN_ADV=m
 ifneq ($(REVISION),)
-ccflags-y += -DBATADV_SOURCE_VERSION=\"$(REVISION)\"
+NOSTDINC_FLAGS += -DBATADV_SOURCE_VERSION=\"$(REVISION)\"
 endif
-include $(PWD)/Makefile.kbuild
+
+BUILD_FLAGS := \
+	M=$(PWD)/net/batman-adv \
+	CONFIG_BATMAN_ADV=m \
+	CONFIG_BATMAN_ADV_DEBUG=$(CONFIG_BATMAN_ADV_DEBUG) \
+	CONFIG_BATMAN_ADV_BLA=$(CONFIG_BATMAN_ADV_BLA) \
+	CONFIG_BATMAN_ADV_DAT=$(CONFIG_BATMAN_ADV_DAT) \
+	CONFIG_BATMAN_ADV_NC=$(CONFIG_BATMAN_ADV_NC) \
+	CONFIG_BATMAN_ADV_MCAST=$(CONFIG_BATMAN_ADV_MCAST) \
+	INSTALL_MOD_DIR=updates/net/batman-adv/
 
 all: config
-	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) modules
+	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS)	modules
 
 clean:
 	$(RM) compat-autoconf.h*
-	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) clean
+	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) clean
 
 install: config
-	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) INSTALL_MOD_DIR=updates/net/batman-adv/ modules_install
+	$(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) modules_install
 	depmod -a
 
 config:
diff --git a/Makefile.kbuild b/net/batman-adv/Makefile
similarity index 100%
rename from Makefile.kbuild
rename to net/batman-adv/Makefile
diff --git a/bat_algo.h b/net/batman-adv/bat_algo.h
similarity index 100%
rename from bat_algo.h
rename to net/batman-adv/bat_algo.h
diff --git a/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
similarity index 100%
rename from bat_iv_ogm.c
rename to net/batman-adv/bat_iv_ogm.c
diff --git a/bitarray.c b/net/batman-adv/bitarray.c
similarity index 100%
rename from bitarray.c
rename to net/batman-adv/bitarray.c
diff --git a/bitarray.h b/net/batman-adv/bitarray.h
similarity index 100%
rename from bitarray.h
rename to net/batman-adv/bitarray.h
diff --git a/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
similarity index 100%
rename from bridge_loop_avoidance.c
rename to net/batman-adv/bridge_loop_avoidance.c
diff --git a/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
similarity index 100%
rename from bridge_loop_avoidance.h
rename to net/batman-adv/bridge_loop_avoidance.h
diff --git a/debugfs.c b/net/batman-adv/debugfs.c
similarity index 100%
rename from debugfs.c
rename to net/batman-adv/debugfs.c
diff --git a/debugfs.h b/net/batman-adv/debugfs.h
similarity index 100%
rename from debugfs.h
rename to net/batman-adv/debugfs.h
diff --git a/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
similarity index 100%
rename from distributed-arp-table.c
rename to net/batman-adv/distributed-arp-table.c
diff --git a/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
similarity index 100%
rename from distributed-arp-table.h
rename to net/batman-adv/distributed-arp-table.h
diff --git a/fragmentation.c b/net/batman-adv/fragmentation.c
similarity index 100%
rename from fragmentation.c
rename to net/batman-adv/fragmentation.c
diff --git a/fragmentation.h b/net/batman-adv/fragmentation.h
similarity index 100%
rename from fragmentation.h
rename to net/batman-adv/fragmentation.h
diff --git a/gateway_client.c b/net/batman-adv/gateway_client.c
similarity index 100%
rename from gateway_client.c
rename to net/batman-adv/gateway_client.c
diff --git a/gateway_client.h b/net/batman-adv/gateway_client.h
similarity index 100%
rename from gateway_client.h
rename to net/batman-adv/gateway_client.h
diff --git a/gateway_common.c b/net/batman-adv/gateway_common.c
similarity index 100%
rename from gateway_common.c
rename to net/batman-adv/gateway_common.c
diff --git a/gateway_common.h b/net/batman-adv/gateway_common.h
similarity index 100%
rename from gateway_common.h
rename to net/batman-adv/gateway_common.h
diff --git a/hard-interface.c b/net/batman-adv/hard-interface.c
similarity index 100%
rename from hard-interface.c
rename to net/batman-adv/hard-interface.c
diff --git a/hard-interface.h b/net/batman-adv/hard-interface.h
similarity index 100%
rename from hard-interface.h
rename to net/batman-adv/hard-interface.h
diff --git a/hash.c b/net/batman-adv/hash.c
similarity index 100%
rename from hash.c
rename to net/batman-adv/hash.c
diff --git a/hash.h b/net/batman-adv/hash.h
similarity index 100%
rename from hash.h
rename to net/batman-adv/hash.h
diff --git a/icmp_socket.c b/net/batman-adv/icmp_socket.c
similarity index 100%
rename from icmp_socket.c
rename to net/batman-adv/icmp_socket.c
diff --git a/icmp_socket.h b/net/batman-adv/icmp_socket.h
similarity index 100%
rename from icmp_socket.h
rename to net/batman-adv/icmp_socket.h
diff --git a/main.c b/net/batman-adv/main.c
similarity index 100%
rename from main.c
rename to net/batman-adv/main.c
diff --git a/main.h b/net/batman-adv/main.h
similarity index 100%
rename from main.h
rename to net/batman-adv/main.h
diff --git a/multicast.c b/net/batman-adv/multicast.c
similarity index 100%
rename from multicast.c
rename to net/batman-adv/multicast.c
diff --git a/multicast.h b/net/batman-adv/multicast.h
similarity index 100%
rename from multicast.h
rename to net/batman-adv/multicast.h
diff --git a/network-coding.c b/net/batman-adv/network-coding.c
similarity index 100%
rename from network-coding.c
rename to net/batman-adv/network-coding.c
diff --git a/network-coding.h b/net/batman-adv/network-coding.h
similarity index 100%
rename from network-coding.h
rename to net/batman-adv/network-coding.h
diff --git a/originator.c b/net/batman-adv/originator.c
similarity index 100%
rename from originator.c
rename to net/batman-adv/originator.c
diff --git a/originator.h b/net/batman-adv/originator.h
similarity index 100%
rename from originator.h
rename to net/batman-adv/originator.h
diff --git a/packet.h b/net/batman-adv/packet.h
similarity index 100%
rename from packet.h
rename to net/batman-adv/packet.h
diff --git a/routing.c b/net/batman-adv/routing.c
similarity index 100%
rename from routing.c
rename to net/batman-adv/routing.c
diff --git a/routing.h b/net/batman-adv/routing.h
similarity index 100%
rename from routing.h
rename to net/batman-adv/routing.h
diff --git a/send.c b/net/batman-adv/send.c
similarity index 100%
rename from send.c
rename to net/batman-adv/send.c
diff --git a/send.h b/net/batman-adv/send.h
similarity index 100%
rename from send.h
rename to net/batman-adv/send.h
diff --git a/soft-interface.c b/net/batman-adv/soft-interface.c
similarity index 100%
rename from soft-interface.c
rename to net/batman-adv/soft-interface.c
diff --git a/soft-interface.h b/net/batman-adv/soft-interface.h
similarity index 100%
rename from soft-interface.h
rename to net/batman-adv/soft-interface.h
diff --git a/sysfs.c b/net/batman-adv/sysfs.c
similarity index 100%
rename from sysfs.c
rename to net/batman-adv/sysfs.c
diff --git a/sysfs.h b/net/batman-adv/sysfs.h
similarity index 100%
rename from sysfs.h
rename to net/batman-adv/sysfs.h
diff --git a/translation-table.c b/net/batman-adv/translation-table.c
similarity index 100%
rename from translation-table.c
rename to net/batman-adv/translation-table.c
diff --git a/translation-table.h b/net/batman-adv/translation-table.h
similarity index 100%
rename from translation-table.h
rename to net/batman-adv/translation-table.h
diff --git a/types.h b/net/batman-adv/types.h
similarity index 100%
rename from types.h
rename to net/batman-adv/types.h
-- 
2.1.4

