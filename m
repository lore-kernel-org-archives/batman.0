Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:45 +0200
Message-Id: <20181025162245.19389-43-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 42/42] batctl: Allow to enable/disable
 subcommands
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

Systems with limited space are usually not using all the functionality of
batman-adv and of batctl. Still, most of the batctl is still build even
when the corresponding batman-adv functionality would not be available.
This becomes especially important for subcommands which implement most
functionality in userspace when it was previously completely handled by the
kernel.

An external build system for such system can now just select the commands
it really needs. Combining this with link-time-optimizationa and/or
function/data-section garbage collection allows to find the right mix
between size and functionality.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile | 83 +++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 35 deletions(-)

diff --git a/Makefile b/Makefile
index dfcfbd9..e6b2412 100755
--- a/Makefile
+++ b/Makefile
@@ -20,56 +20,69 @@
 #
 # License-Filename: LICENSES/preferred/GPL-2.0
 
-# changing the CONFIG_* line to 'y' enables the related feature
-# batctl advanced debugging tool bisect:
+# just for backward compatibility - please use CONFIG_bisect_iv instead
 export CONFIG_BATCTL_BISECT=n
 
 # batctl build
 BINARY_NAME = batctl
 
-obj-y += aggregation.o
-obj-y += ap_isolation.o
 obj-y += bat-hosts.o
-obj-y += backbonetable.o
-obj-$(CONFIG_BATCTL_BISECT) += bisect_iv.o
-obj-y += bonding.o
-obj-y += bridge_loop_avoidance.o
-obj-y += claimtable.o
-obj-y += dat_cache.o
 obj-y += debugfs.o
 obj-y += debug.o
-obj-y += distributed_arp_table.o
-obj-y += event.o
-obj-y += fragmentation.o
 obj-y += functions.o
-obj-y += gateways.o
 obj-y += genl.o
-obj-y += gw_mode.o
 obj-y += hash.o
 obj-y += icmp_helper.o
-obj-y += interface.o
-obj-y += isolation_mark.o
-obj-y += loglevel.o
-obj-y += log.o
 obj-y += main.o
-obj-y += mcast_flags.o
-obj-y += multicast_mode.o
-obj-y += nc_nodes.o
-obj-y += neighbors.o
 obj-y += netlink.o
-obj-y += network_coding.o
-obj-y += ping.o
-obj-y += originators.o
-obj-y += orig_interval.o
-obj-y += routing_algo.o
-obj-y += statistics.o
 obj-y += sys.o
-obj-y += tcpdump.o
-obj-y += throughputmeter.o
-obj-y += traceroute.o
-obj-y += transglobal.o
-obj-y += translate.o
-obj-y += translocal.o
+
+define add_command
+  CONFIG_$(1):=$(2)
+  ifneq ($$(CONFIG_$(1)),y)
+    ifneq ($$(CONFIG_$(1)),n)
+      $$(warning invalid value for parameter CONFIG_$(1): $$(CONFIG_$(1)))
+    endif
+  endif
+
+  obj-$$(CONFIG_$(1)) += $(1).o
+endef # add_command
+
+# using the make parameter CONFIG_* (e.g. CONFIG_bisect_iv) with the value 'y'
+# enables the related feature and 'n' disables it
+$(eval $(call add_command,aggregation,y))
+$(eval $(call add_command,ap_isolation,y))
+$(eval $(call add_command,backbonetable,y))
+$(eval $(call add_command,bisect_iv,$(CONFIG_BATCTL_BISECT)))
+$(eval $(call add_command,bonding,y))
+$(eval $(call add_command,bridge_loop_avoidance,y))
+$(eval $(call add_command,claimtable,y))
+$(eval $(call add_command,dat_cache,y))
+$(eval $(call add_command,distributed_arp_table,y))
+$(eval $(call add_command,event,y))
+$(eval $(call add_command,fragmentation,y))
+$(eval $(call add_command,gateways,y))
+$(eval $(call add_command,gw_mode,y))
+$(eval $(call add_command,interface,y))
+$(eval $(call add_command,isolation_mark,y))
+$(eval $(call add_command,log,y))
+$(eval $(call add_command,loglevel,y))
+$(eval $(call add_command,mcast_flags,y))
+$(eval $(call add_command,multicast_mode,y))
+$(eval $(call add_command,nc_nodes,y))
+$(eval $(call add_command,neighbors,y))
+$(eval $(call add_command,network_coding,y))
+$(eval $(call add_command,orig_interval,y))
+$(eval $(call add_command,originators,y))
+$(eval $(call add_command,ping,y))
+$(eval $(call add_command,routing_algo,y))
+$(eval $(call add_command,statistics,y))
+$(eval $(call add_command,tcpdump,y))
+$(eval $(call add_command,throughputmeter,y))
+$(eval $(call add_command,traceroute,y))
+$(eval $(call add_command,transglobal,y))
+$(eval $(call add_command,translate,y))
+$(eval $(call add_command,translocal,y))
 
 MANPAGE = man/batctl.8
 
-- 
2.11.0

