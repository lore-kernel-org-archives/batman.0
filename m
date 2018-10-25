Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:44 +0200
Message-Id: <20181025162245.19389-42-sven@narfation.org>
In-Reply-To: <20181025162245.19389-1-sven@narfation.org>
References: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 41/42] batctl: Simplify enabling for
 bisect_iv subcommand
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

The variable content of CONFIG_BATCTL_BISECT can be used to decide whether
the bisect_iv command is enabled or not. This would make it possible in the
future to introduce a generic way to enable or disable commands. Combining
this with link-time-optimization and/or function/data-section allows to
relatively freely scale the functionality of batctl and its size.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile | 96 +++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/Makefile b/Makefile
index cf2b1c7..dfcfbd9 100755
--- a/Makefile
+++ b/Makefile
@@ -27,53 +27,49 @@ export CONFIG_BATCTL_BISECT=n
 # batctl build
 BINARY_NAME = batctl
 
-OBJ_BISECT = bisect_iv.o
-
-OBJ += aggregation.o
-OBJ += ap_isolation.o
-OBJ += bat-hosts.o
-OBJ += backbonetable.o
-ifeq ($(CONFIG_BATCTL_BISECT),y)
-OBJ += $(OBJ_BISECT)
-endif
-OBJ += bonding.o
-OBJ += bridge_loop_avoidance.o
-OBJ += claimtable.o
-OBJ += dat_cache.o
-OBJ += debugfs.o
-OBJ += debug.o
-OBJ += distributed_arp_table.o
-OBJ += event.o
-OBJ += fragmentation.o
-OBJ += functions.o
-OBJ += gateways.o
-OBJ += genl.o
-OBJ += gw_mode.o
-OBJ += hash.o
-OBJ += icmp_helper.o
-OBJ += interface.o
-OBJ += isolation_mark.o
-OBJ += loglevel.o
-OBJ += log.o
-OBJ += main.o
-OBJ += mcast_flags.o
-OBJ += multicast_mode.o
-OBJ += nc_nodes.o
-OBJ += neighbors.o
-OBJ += netlink.o
-OBJ += network_coding.o
-OBJ += ping.o
-OBJ += originators.o
-OBJ += orig_interval.o
-OBJ += routing_algo.o
-OBJ += statistics.o
-OBJ += sys.o
-OBJ += tcpdump.o
-OBJ += throughputmeter.o
-OBJ += traceroute.o
-OBJ += transglobal.o
-OBJ += translate.o
-OBJ += translocal.o
+obj-y += aggregation.o
+obj-y += ap_isolation.o
+obj-y += bat-hosts.o
+obj-y += backbonetable.o
+obj-$(CONFIG_BATCTL_BISECT) += bisect_iv.o
+obj-y += bonding.o
+obj-y += bridge_loop_avoidance.o
+obj-y += claimtable.o
+obj-y += dat_cache.o
+obj-y += debugfs.o
+obj-y += debug.o
+obj-y += distributed_arp_table.o
+obj-y += event.o
+obj-y += fragmentation.o
+obj-y += functions.o
+obj-y += gateways.o
+obj-y += genl.o
+obj-y += gw_mode.o
+obj-y += hash.o
+obj-y += icmp_helper.o
+obj-y += interface.o
+obj-y += isolation_mark.o
+obj-y += loglevel.o
+obj-y += log.o
+obj-y += main.o
+obj-y += mcast_flags.o
+obj-y += multicast_mode.o
+obj-y += nc_nodes.o
+obj-y += neighbors.o
+obj-y += netlink.o
+obj-y += network_coding.o
+obj-y += ping.o
+obj-y += originators.o
+obj-y += orig_interval.o
+obj-y += routing_algo.o
+obj-y += statistics.o
+obj-y += sys.o
+obj-y += tcpdump.o
+obj-y += throughputmeter.o
+obj-y += traceroute.o
+obj-y += transglobal.o
+obj-y += translate.o
+obj-y += translocal.o
 
 MANPAGE = man/batctl.8
 
@@ -150,11 +146,11 @@ all: $(BINARY_NAME)
 .c.o:
 	$(COMPILE.c) -o $@ $<
 
-$(BINARY_NAME): $(OBJ)
+$(BINARY_NAME): $(obj-y)
 	$(LINK.o) $^ $(LDLIBS) -o $@
 
 clean:
-	$(RM) $(BINARY_NAME) $(OBJ) $(OBJ_BISECT) $(DEP)
+	$(RM) $(BINARY_NAME) $(obj-y) $(obj-n) $(DEP)
 
 install: $(BINARY_NAME)
 	$(MKDIR) $(DESTDIR)$(SBINDIR)
@@ -163,7 +159,7 @@ install: $(BINARY_NAME)
 	$(INSTALL) -m 0644 $(MANPAGE) $(DESTDIR)$(MANDIR)/man8
 
 # load dependencies
-DEP = $(OBJ:.o=.d) $(OBJ_BISECT:.o=.d)
+DEP = $(obj-y:.o=.d) $(obj-n:.o=.d)
 -include $(DEP)
 
 .PHONY: all clean install
-- 
2.11.0

