Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 12 Oct 2010 00:54:33 +0200
Message-Id: <1286837673-17108-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: replace the use of <module>-objs
	with <module>-y
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

From: Tracey Dent <tdent48227@gmail.com>

Changed <module>-objs to <module>-y n Makefile.

Signed-off-by: Tracey Dent <tdent48227@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/Makefile.kbuild |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv/Makefile.kbuild b/batman-adv/Makefile.kbuild
index ca81cb1..14e3daa 100644
--- a/batman-adv/Makefile.kbuild
+++ b/batman-adv/Makefile.kbuild
@@ -32,4 +32,4 @@ EXTRA_CFLAGS += -DREVISION_VERSION=\"$(REVISION)\"
 endif
 
 obj-m += batman-adv.o
-batman-adv-objs := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o gateway_common.o gateway_client.o unicast.o $(shell [ "2" -eq "$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
+batman-adv-y := main.o bat_debugfs.o bat_sysfs.o send.o routing.o soft-interface.o icmp_socket.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o gateway_common.o gateway_client.o unicast.o $(shell [ "2" -eq "$(VERSION)" ] 2>&- && [ "6" -eq "$(PATCHLEVEL)" ] 2>&- && [ "$(SUBLEVEL)" -le "28" ] 2>&- && echo bat_printk.o)
-- 
1.7.1

