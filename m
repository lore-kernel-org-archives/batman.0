Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  5 Jun 2016 20:47:01 +0200
Message-Id: <1465152428-17299-3-git-send-email-sven@narfation.org>
In-Reply-To: <1465152428-17299-1-git-send-email-sven@narfation.org>
References: <1465152428-17299-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 03/10] alfred: Add netlink dependencies
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile         |  35 ++++++++--
 README           |   2 +
 batman_adv.h     | 208 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.c        |  84 ++++++++++++++++++++++
 netlink.h        |  30 ++++++++
 vis/Makefile     |  30 ++++++++
 vis/batman_adv.h |   1 +
 vis/netlink.c    |   1 +
 vis/netlink.h    |   1 +
 9 files changed, 386 insertions(+), 6 deletions(-)
 create mode 100644 batman_adv.h
 create mode 100644 netlink.c
 create mode 100644 netlink.h
 create mode 120000 vis/batman_adv.h
 create mode 120000 vis/netlink.c
 create mode 120000 vis/netlink.h

diff --git a/Makefile b/Makefile
index 1c364f7..6daa904 100755
--- a/Makefile
+++ b/Makefile
@@ -25,6 +25,7 @@ OBJ += client.o
 OBJ += debugfs.o
 OBJ += hash.o
 OBJ += main.o
+OBJ += netlink.o
 OBJ += netsock.o
 OBJ += recv.o
 OBJ += send.o
@@ -83,14 +84,36 @@ ifneq ($(CONFIG_ALFRED_GPSD),n)
 	GPSD_INSTALL=gpsd-install
 endif
 
-ifneq ($(CONFIG_ALFRED_CAPABILITIES),n)
-  ifeq ($(origin PKG_CONFIG), undefined)
-    PKG_CONFIG = pkg-config
-    ifeq ($(shell which $(PKG_CONFIG) 2>/dev/null),)
-      $(error $(PKG_CONFIG) not found)
-    endif
+ifeq ($(origin PKG_CONFIG), undefined)
+  PKG_CONFIG = pkg-config
+  ifeq ($(shell which $(PKG_CONFIG) 2>/dev/null),)
+    $(error $(PKG_CONFIG) not found)
+  endif
+endif
+
+ifeq ($(origin LIBNL_CFLAGS) $(origin LIBNL_LDLIBS), undefined undefined)
+  LIBNL_NAME ?= libnl-3.0
+  ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBNL_NAME) 2>/dev/null),)
+    $(error No $(LIBNL_NAME) development libraries found!)
   endif
+  LIBNL_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(LIBNL_NAME))
+  LIBNL_LDLIBS +=  $(shell $(PKG_CONFIG) --libs $(LIBNL_NAME))
+endif
+CFLAGS += $(LIBNL_CFLAGS)
+LDLIBS += $(LIBNL_LDLIBS)
 
+ifeq ($(origin LIBNL_GENL_CFLAGS) $(origin LIBNL_GENL_LDLIBS), undefined undefined)
+  LIBNL_GENL_NAME ?= libnl-genl-3.0
+  ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBNL_GENL_NAME) 2>/dev/null),)
+    $(error No $(LIBNL_GENL_NAME) development libraries found!)
+  endif
+  LIBNL_GENL_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(LIBNL_GENL_NAME))
+  LIBNL_GENL_LDLIBS += $(shell $(PKG_CONFIG) --libs $(LIBNL_GENL_NAME))
+endif
+CFLAGS += $(LIBNL_GENL_CFLAGS)
+LDLIBS += $(LIBNL_GENL_LDLIBS)
+
+ifneq ($(CONFIG_ALFRED_CAPABILITIES),n)
   ifeq ($(origin LIBCAP_CFLAGS) $(origin LIBCAP_LDLIBS), undefined undefined)
     LIBCAP_NAME ?= libcap
     ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBCAP_NAME) 2>/dev/null),)
diff --git a/README b/README
index fbca7d1..2a015b8 100644
--- a/README
+++ b/README
@@ -28,6 +28,8 @@ Compilation
 alfred depends on:
  * librt (usually part of libc)
  * IPv6 support in the kernel/host system
+ * libnl-3 - support for netlink sockets
+ * libnl-3-genl - support for generic netlink messages
 
 and optionally:
  * libgps - if you want to distribute GPS information
diff --git a/batman_adv.h b/batman_adv.h
new file mode 100644
index 0000000..37157d0
--- /dev/null
+++ b/batman_adv.h
@@ -0,0 +1,208 @@
+/* Copyright (C) 2016 B.A.T.M.A.N. contributors:
+ *
+ * Matthias Schiffer
+ *
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
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _UAPI_LINUX_BATMAN_ADV_H_
+#define _UAPI_LINUX_BATMAN_ADV_H_
+
+#define BATADV_NL_NAME "batadv"
+
+#define BATADV_NL_MCAST_GROUP_TPMETER	"tpmeter"
+
+/**
+ * enum batadv_tt_client_flags - TT client specific flags
+ * @BATADV_TT_CLIENT_DEL: the client has to be deleted from the table
+ * @BATADV_TT_CLIENT_ROAM: the client roamed to/from another node and the new
+ *  update telling its new real location has not been received/sent yet
+ * @BATADV_TT_CLIENT_WIFI: this client is connected through a wifi interface.
+ *  This information is used by the "AP Isolation" feature
+ * @BATADV_TT_CLIENT_ISOLA: this client is considered "isolated". This
+ *  information is used by the Extended Isolation feature
+ * @BATADV_TT_CLIENT_NOPURGE: this client should never be removed from the table
+ * @BATADV_TT_CLIENT_NEW: this client has been added to the local table but has
+ *  not been announced yet
+ * @BATADV_TT_CLIENT_PENDING: this client is marked for removal but it is kept
+ *  in the table for one more originator interval for consistency purposes
+ * @BATADV_TT_CLIENT_TEMP: this global client has been detected to be part of
+ *  the network but no nnode has already announced it
+ *
+ * Bits from 0 to 7 are called _remote flags_ because they are sent on the wire.
+ * Bits from 8 to 15 are called _local flags_ because they are used for local
+ * computations only.
+ *
+ * Bits from 4 to 7 - a subset of remote flags - are ensured to be in sync with
+ * the other nodes in the network. To achieve this goal these flags are included
+ * in the TT CRC computation.
+ */
+enum batadv_tt_client_flags {
+	BATADV_TT_CLIENT_DEL     = (1 << 0),
+	BATADV_TT_CLIENT_ROAM    = (1 << 1),
+	BATADV_TT_CLIENT_WIFI    = (1 << 4),
+	BATADV_TT_CLIENT_ISOLA	 = (1 << 5),
+	BATADV_TT_CLIENT_NOPURGE = (1 << 8),
+	BATADV_TT_CLIENT_NEW     = (1 << 9),
+	BATADV_TT_CLIENT_PENDING = (1 << 10),
+	BATADV_TT_CLIENT_TEMP	 = (1 << 11),
+};
+
+/**
+ * enum batadv_nl_attrs - batman-adv netlink attributes
+ *
+ * @BATADV_ATTR_UNSPEC: unspecified attribute to catch errors
+ * @BATADV_ATTR_VERSION: batman-adv version string
+ * @BATADV_ATTR_ALGO_NAME: name of routing algorithm
+ * @BATADV_ATTR_MESH_IFINDEX: index of the batman-adv interface
+ * @BATADV_ATTR_MESH_IFNAME: name of the batman-adv interface
+ * @BATADV_ATTR_MESH_ADDRESS: mac address of the batman-adv interface
+ * @BATADV_ATTR_HARD_IFINDEX: index of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_IFNAME: name of the non-batman-adv interface
+ * @BATADV_ATTR_HARD_ADDRESS: mac address of the non-batman-adv interface
+ * @BATADV_ATTR_ORIG_ADDRESS: originator mac address
+ * @BATADV_ATTR_TPMETER_RESULT: result of run (see batadv_tp_meter_status)
+ * @BATADV_ATTR_TPMETER_TEST_TIME: time (msec) the run took
+ * @BATADV_ATTR_TPMETER_BYTES: amount of acked bytes during run
+ * @BATADV_ATTR_TPMETER_COOKIE: session cookie to match tp_meter session
+ * @BATADV_ATTR_PAD: attribute used for padding for 64-bit alignment
+ * @BATADV_ATTR_ACTIVE: Flag indicating if the hard interface is active
+ * @BATADV_ATTR_TT_ADDRESS: Client MAC address
+ * @BATADV_ATTR_TT_TTVN: Translation table version
+ * @BATADV_ATTR_TT_LAST_TTVN: Previous translation table version
+ * @BATADV_ATTR_TT_CRC32: CRC32 over translation table
+ * @BATADV_ATTR_TT_VID: VLAN ID
+ * @BATADV_ATTR_TT_FLAGS: Translation table client flags
+ * @BATADV_ATTR_FLAG_BEST: Flags indicating entry is the best
+ * @BATADV_ATTR_LAST_SEEN_MSECS: Time in milliseconds since last seen
+ * @BATADV_ATTR_NEIGH_ADDRESS: Neighbour MAC address
+ * @BATADV_ATTR_TQ: TQ to neighbour
+ * @BATADV_ATTR_THROUGHPUT: Estimated throughput to Neighbour
+ * @BATADV_ATTR_BANDWIDTH_UP: Reported uplink bandwidth
+ * @BATADV_ATTR_BANDWIDTH_DOWN: Reported downlink bandwidth
+ * @BATADV_ATTR_ROUTER: Gateway router MAC address
+ * @BATADV_ATTR_BLA_OWN: Flag indicating own originator
+ * @BATADV_ATTR_BLA_ADDRESS: Bridge loop avoidance claim MAC address
+ * @BATADV_ATTR_BLA_VID: BLA VLAN ID
+ * @BATADV_ATTR_BLA_BACKBONE: BLA gateway originator MAC address
+ * @BATADV_ATTR_BLA_CRC: BLA CRC
+ * @__BATADV_ATTR_AFTER_LAST: internal use
+ * @NUM_BATADV_ATTR: total number of batadv_nl_attrs available
+ * @BATADV_ATTR_MAX: highest attribute number currently defined
+ */
+enum batadv_nl_attrs {
+	BATADV_ATTR_UNSPEC,
+	BATADV_ATTR_VERSION,
+	BATADV_ATTR_ALGO_NAME,
+	BATADV_ATTR_MESH_IFINDEX,
+	BATADV_ATTR_MESH_IFNAME,
+	BATADV_ATTR_MESH_ADDRESS,
+	BATADV_ATTR_HARD_IFINDEX,
+	BATADV_ATTR_HARD_IFNAME,
+	BATADV_ATTR_HARD_ADDRESS,
+	BATADV_ATTR_ORIG_ADDRESS,
+	BATADV_ATTR_TPMETER_RESULT,
+	BATADV_ATTR_TPMETER_TEST_TIME,
+	BATADV_ATTR_TPMETER_BYTES,
+	BATADV_ATTR_TPMETER_COOKIE,
+	BATADV_ATTR_PAD,
+	BATADV_ATTR_ACTIVE,
+	BATADV_ATTR_TT_ADDRESS,
+	BATADV_ATTR_TT_TTVN,
+	BATADV_ATTR_TT_LAST_TTVN,
+	BATADV_ATTR_TT_CRC32,
+	BATADV_ATTR_TT_VID,
+	BATADV_ATTR_TT_FLAGS,
+	BATADV_ATTR_FLAG_BEST,
+	BATADV_ATTR_LAST_SEEN_MSECS,
+	BATADV_ATTR_NEIGH_ADDRESS,
+	BATADV_ATTR_TQ,
+	BATADV_ATTR_THROUGHPUT,
+	BATADV_ATTR_BANDWIDTH_UP,
+	BATADV_ATTR_BANDWIDTH_DOWN,
+	BATADV_ATTR_ROUTER,
+	BATADV_ATTR_BLA_OWN,
+	BATADV_ATTR_BLA_ADDRESS,
+	BATADV_ATTR_BLA_VID,
+	BATADV_ATTR_BLA_BACKBONE,
+	BATADV_ATTR_BLA_CRC,
+	/* add attributes above here, update the policy in netlink.c */
+	__BATADV_ATTR_AFTER_LAST,
+	NUM_BATADV_ATTR = __BATADV_ATTR_AFTER_LAST,
+	BATADV_ATTR_MAX = __BATADV_ATTR_AFTER_LAST - 1
+};
+
+/**
+ * enum batadv_nl_commands - supported batman-adv netlink commands
+ *
+ * @BATADV_CMD_UNSPEC: unspecified command to catch errors
+ * @BATADV_CMD_GET_MESH_INFO: Query basic information about batman-adv device
+ * @BATADV_CMD_TP_METER: Start a tp meter session
+ * @BATADV_CMD_TP_METER_CANCEL: Cancel a tp meter session
+ * @BATADV_CMD_GET_ROUTING_ALGOS: Query the list of routing algorithms.
+ * @BATADV_CMD_GET_HARDIFS: Query list of hard interfaces
+ * @BATADV_CMD_GET_TRANSTABLE_LOCAL: Query list of local translations
+ * @BATADV_CMD_GET_TRANSTABLE_GLOBAL Query list of global translations
+ * @BATADV_CMD_GET_ORIGINATORS: Query list of originators
+ * @BATADV_CMD_GET_NEIGHBORS: Query list of neighbours
+ * @BATADV_CMD_GET_GATEWAYS: Query list of gateways
+ * @BATADV_CMD_GET_BLA_CLAIM: Query list of bridge loop avoidance claims
+ * @BATADV_CMD_GET_BLA_BACKBONE: Query list of bridge loop avoidance backbones
+ * @__BATADV_CMD_AFTER_LAST: internal use
+ * @BATADV_CMD_MAX: highest used command number
+ */
+enum batadv_nl_commands {
+	BATADV_CMD_UNSPEC,
+	BATADV_CMD_GET_MESH_INFO,
+	BATADV_CMD_TP_METER,
+	BATADV_CMD_TP_METER_CANCEL,
+	BATADV_CMD_GET_ROUTING_ALGOS,
+	BATADV_CMD_GET_HARDIFS,
+	BATADV_CMD_GET_TRANSTABLE_LOCAL,
+	BATADV_CMD_GET_TRANSTABLE_GLOBAL,
+	BATADV_CMD_GET_ORIGINATORS,
+	BATADV_CMD_GET_NEIGHBORS,
+	BATADV_CMD_GET_GATEWAYS,
+	BATADV_CMD_GET_BLA_CLAIM,
+	BATADV_CMD_GET_BLA_BACKBONE,
+	/* add new commands above here */
+	__BATADV_CMD_AFTER_LAST,
+	BATADV_CMD_MAX = __BATADV_CMD_AFTER_LAST - 1
+};
+
+/**
+ * enum batadv_tp_meter_reason - reason of a tp meter test run stop
+ * @BATADV_TP_REASON_COMPLETE: sender finished tp run
+ * @BATADV_TP_REASON_CANCEL: sender was stopped during run
+ * @BATADV_TP_REASON_DST_UNREACHABLE: receiver could not be reached or didn't
+ *  answer
+ * @BATADV_TP_REASON_RESEND_LIMIT: (unused) sender retry reached limit
+ * @BATADV_TP_REASON_ALREADY_ONGOING: test to or from the same node already
+ *  ongoing
+ * @BATADV_TP_REASON_MEMORY_ERROR: test was stopped due to low memory
+ * @BATADV_TP_REASON_CANT_SEND: failed to send via outgoing interface
+ * @BATADV_TP_REASON_TOO_MANY: too many ongoing sessions
+ */
+enum batadv_tp_meter_reason {
+	BATADV_TP_REASON_COMPLETE		= 3,
+	BATADV_TP_REASON_CANCEL			= 4,
+	/* error status >= 128 */
+	BATADV_TP_REASON_DST_UNREACHABLE	= 128,
+	BATADV_TP_REASON_RESEND_LIMIT		= 129,
+	BATADV_TP_REASON_ALREADY_ONGOING	= 130,
+	BATADV_TP_REASON_MEMORY_ERROR		= 131,
+	BATADV_TP_REASON_CANT_SEND		= 132,
+	BATADV_TP_REASON_TOO_MANY		= 133,
+};
+
+#endif /* _UAPI_LINUX_BATMAN_ADV_H_ */
diff --git a/netlink.c b/netlink.c
new file mode 100644
index 0000000..d9c1f55
--- /dev/null
+++ b/netlink.c
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
+ *
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
+ */
+
+#include "netlink.h"
+
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+#include <net/ethernet.h>
+
+#include "batman_adv.h"
+
+struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
+	[BATADV_ATTR_VERSION]		= { .type = NLA_STRING },
+	[BATADV_ATTR_ALGO_NAME]		= { .type = NLA_STRING },
+	[BATADV_ATTR_MESH_IFINDEX]	= { .type = NLA_U32 },
+	[BATADV_ATTR_MESH_IFNAME]	= { .type = NLA_STRING,
+					    .maxlen = IFNAMSIZ },
+	[BATADV_ATTR_MESH_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_HARD_IFINDEX]	= { .type = NLA_U32 },
+	[BATADV_ATTR_HARD_IFNAME]	= { .type = NLA_STRING,
+					    .maxlen = IFNAMSIZ },
+	[BATADV_ATTR_HARD_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_ORIG_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_TPMETER_RESULT]	= { .type = NLA_U8 },
+	[BATADV_ATTR_TPMETER_TEST_TIME]	= { .type = NLA_U32 },
+	[BATADV_ATTR_TPMETER_BYTES]	= { .type = NLA_U64 },
+	[BATADV_ATTR_TPMETER_COOKIE]	= { .type = NLA_U32 },
+	[BATADV_ATTR_PAD]		= { .type = NLA_UNSPEC },
+	[BATADV_ATTR_ACTIVE]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_TT_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_TT_TTVN]		= { .type = NLA_U8 },
+	[BATADV_ATTR_TT_LAST_TTVN]	= { .type = NLA_U8 },
+	[BATADV_ATTR_TT_CRC32]		= { .type = NLA_U32 },
+	[BATADV_ATTR_TT_VID]		= { .type = NLA_U16 },
+	[BATADV_ATTR_TT_FLAGS]		= { .type = NLA_U32 },
+	[BATADV_ATTR_FLAG_BEST]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_LAST_SEEN_MSECS]	= { .type = NLA_U32 },
+	[BATADV_ATTR_NEIGH_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_TQ]		= { .type = NLA_U8 },
+	[BATADV_ATTR_THROUGHPUT]	= { .type = NLA_U32 },
+	[BATADV_ATTR_BANDWIDTH_UP]	= { .type = NLA_U32 },
+	[BATADV_ATTR_BANDWIDTH_DOWN]	= { .type = NLA_U32 },
+	[BATADV_ATTR_ROUTER]		= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_BLA_OWN]		= { .type = NLA_FLAG },
+	[BATADV_ATTR_BLA_ADDRESS]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_BLA_VID]		= { .type = NLA_U16 },
+	[BATADV_ATTR_BLA_BACKBONE]	= { .type = NLA_UNSPEC,
+					    .minlen = ETH_ALEN,
+					    .maxlen = ETH_ALEN },
+	[BATADV_ATTR_BLA_CRC]		= { .type = NLA_U16 },
+};
diff --git a/netlink.h b/netlink.h
new file mode 100644
index 0000000..f903563
--- /dev/null
+++ b/netlink.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
+ *
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
+ */
+
+#ifndef _ALFRED_NETLINK_H
+#define _ALFRED_NETLINK_H
+
+#include <netlink/genl/genl.h>
+#include <netlink/genl/ctrl.h>
+
+extern struct nla_policy batadv_netlink_policy[];
+
+#endif /* _ALFRED_NETLINK_H */
diff --git a/vis/Makefile b/vis/Makefile
index 52ca981..fd99f49 100755
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -21,6 +21,7 @@
 # batadv-vis build
 BINARY_NAME = batadv-vis
 OBJ += debugfs.o
+OBJ += netlink.o
 OBJ += vis.o
 MANPAGE = man/batadv-vis.8
 
@@ -59,6 +60,35 @@ ifneq ($(REVISION),)
 CPPFLAGS += -DSOURCE_VERSION=\"$(REVISION)\"
 endif
 
+ifeq ($(origin PKG_CONFIG), undefined)
+  PKG_CONFIG = pkg-config
+  ifeq ($(shell which $(PKG_CONFIG) 2>/dev/null),)
+    $(error $(PKG_CONFIG) not found)
+  endif
+endif
+
+ifeq ($(origin LIBNL_CFLAGS) $(origin LIBNL_LDLIBS), undefined undefined)
+  LIBNL_NAME ?= libnl-3.0
+  ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBNL_NAME) 2>/dev/null),)
+    $(error No $(LIBNL_NAME) development libraries found!)
+  endif
+  LIBNL_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(LIBNL_NAME))
+  LIBNL_LDLIBS +=  $(shell $(PKG_CONFIG) --libs $(LIBNL_NAME))
+endif
+CFLAGS += $(LIBNL_CFLAGS)
+LDLIBS += $(LIBNL_LDLIBS)
+
+ifeq ($(origin LIBNL_GENL_CFLAGS) $(origin LIBNL_GENL_LDLIBS), undefined undefined)
+  LIBNL_GENL_NAME ?= libnl-genl-3.0
+  ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBNL_GENL_NAME) 2>/dev/null),)
+    $(error No $(LIBNL_GENL_NAME) development libraries found!)
+  endif
+  LIBNL_GENL_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(LIBNL_GENL_NAME))
+  LIBNL_GENL_LDLIBS += $(shell $(PKG_CONFIG) --libs $(LIBNL_GENL_NAME))
+endif
+CFLAGS += $(LIBNL_GENL_CFLAGS)
+LDLIBS += $(LIBNL_GENL_LDLIBS)
+
 # default target
 all: $(BINARY_NAME)
 
diff --git a/vis/batman_adv.h b/vis/batman_adv.h
new file mode 120000
index 0000000..72222e9
--- /dev/null
+++ b/vis/batman_adv.h
@@ -0,0 +1 @@
+../batman_adv.h
\ No newline at end of file
diff --git a/vis/netlink.c b/vis/netlink.c
new file mode 120000
index 0000000..06d13cc
--- /dev/null
+++ b/vis/netlink.c
@@ -0,0 +1 @@
+../netlink.c
\ No newline at end of file
diff --git a/vis/netlink.h b/vis/netlink.h
new file mode 120000
index 0000000..c7a63b5
--- /dev/null
+++ b/vis/netlink.h
@@ -0,0 +1 @@
+../netlink.h
\ No newline at end of file
-- 
2.8.1

