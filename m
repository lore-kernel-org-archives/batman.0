Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:11 +0100
Message-Id: <20171119140517.24329-4-sven@narfation.org>
In-Reply-To: <20171119140517.24329-1-sven@narfation.org>
References: <20171119140517.24329-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/9] batman-adv: Add SPDX license identifier
 above copyright header
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

The "Linux kernel licensing rules" require that each file has a SPDX
license identifier as first line (and sometimes as second line).

The FSFE REUSE practices [1] would also require the same tags but have no
restrictions on the placement in the source file. Using the "Linux kernel
licensing rules" is therefore also fulfilling the FSFE REUSE practices
requirements at the same time.

[1] https://reuse.software/practices/

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                               | 2 +-
 compat-include/linux/average.h         | 1 +
 compat-include/linux/cache.h           | 1 +
 compat-include/linux/etherdevice.h     | 1 +
 compat-include/linux/ethtool.h         | 1 +
 compat-include/linux/export.h          | 1 +
 compat-include/linux/genetlink.h       | 1 +
 compat-include/linux/if_ether.h        | 1 +
 compat-include/linux/if_vlan.h         | 1 +
 compat-include/linux/kernel.h          | 1 +
 compat-include/linux/kref.h            | 1 +
 compat-include/linux/list.h            | 1 +
 compat-include/linux/net.h             | 1 +
 compat-include/linux/netdev_features.h | 1 +
 compat-include/linux/netdevice.h       | 1 +
 compat-include/linux/netlink.h         | 1 +
 compat-include/linux/random.h          | 1 +
 compat-include/linux/rculist.h         | 1 +
 compat-include/linux/seq_file.h        | 1 +
 compat-include/linux/skbuff.h          | 1 +
 compat-include/linux/slab.h            | 1 +
 compat-include/net/genetlink.h         | 1 +
 compat-sources/net/core/skbuff.c       | 1 +
 compat-sources/net/ipv4/igmp.c         | 1 +
 compat-sources/net/ipv6/mcast_snoop.c  | 1 +
 compat.h                               | 1 +
 include/uapi/linux/batman_adv.h        | 1 +
 net/batman-adv/Makefile                | 2 +-
 net/batman-adv/bat_algo.c              | 1 +
 net/batman-adv/bat_algo.h              | 1 +
 net/batman-adv/bat_iv_ogm.c            | 1 +
 net/batman-adv/bat_iv_ogm.h            | 1 +
 net/batman-adv/bat_v.c                 | 1 +
 net/batman-adv/bat_v.h                 | 1 +
 net/batman-adv/bat_v_elp.c             | 1 +
 net/batman-adv/bat_v_elp.h             | 1 +
 net/batman-adv/bat_v_ogm.c             | 1 +
 net/batman-adv/bat_v_ogm.h             | 1 +
 net/batman-adv/bitarray.c              | 1 +
 net/batman-adv/bitarray.h              | 1 +
 net/batman-adv/bridge_loop_avoidance.c | 1 +
 net/batman-adv/bridge_loop_avoidance.h | 1 +
 net/batman-adv/debugfs.c               | 1 +
 net/batman-adv/debugfs.h               | 1 +
 net/batman-adv/distributed-arp-table.c | 1 +
 net/batman-adv/distributed-arp-table.h | 1 +
 net/batman-adv/fragmentation.c         | 1 +
 net/batman-adv/fragmentation.h         | 1 +
 net/batman-adv/gateway_client.c        | 1 +
 net/batman-adv/gateway_client.h        | 1 +
 net/batman-adv/gateway_common.c        | 1 +
 net/batman-adv/gateway_common.h        | 1 +
 net/batman-adv/hard-interface.c        | 1 +
 net/batman-adv/hard-interface.h        | 1 +
 net/batman-adv/hash.c                  | 1 +
 net/batman-adv/hash.h                  | 1 +
 net/batman-adv/icmp_socket.c           | 1 +
 net/batman-adv/icmp_socket.h           | 1 +
 net/batman-adv/log.c                   | 1 +
 net/batman-adv/log.h                   | 1 +
 net/batman-adv/main.c                  | 1 +
 net/batman-adv/main.h                  | 1 +
 net/batman-adv/multicast.c             | 1 +
 net/batman-adv/multicast.h             | 1 +
 net/batman-adv/netlink.c               | 1 +
 net/batman-adv/netlink.h               | 1 +
 net/batman-adv/network-coding.c        | 1 +
 net/batman-adv/network-coding.h        | 1 +
 net/batman-adv/originator.c            | 1 +
 net/batman-adv/originator.h            | 1 +
 net/batman-adv/packet.h                | 1 +
 net/batman-adv/routing.c               | 1 +
 net/batman-adv/routing.h               | 1 +
 net/batman-adv/send.c                  | 1 +
 net/batman-adv/send.h                  | 1 +
 net/batman-adv/soft-interface.c        | 1 +
 net/batman-adv/soft-interface.h        | 1 +
 net/batman-adv/sysfs.c                 | 1 +
 net/batman-adv/sysfs.h                 | 1 +
 net/batman-adv/tp_meter.c              | 1 +
 net/batman-adv/tp_meter.h              | 1 +
 net/batman-adv/translation-table.c     | 1 +
 net/batman-adv/translation-table.h     | 1 +
 net/batman-adv/tvlv.c                  | 1 +
 net/batman-adv/tvlv.h                  | 1 +
 net/batman-adv/types.h                 | 1 +
 86 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e40f26a5..7a5cb243 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,4 @@
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/average.h b/compat-include/linux/average.h
index b5a3d3d7..2bbaf97f 100644
--- a/compat-include/linux/average.h
+++ b/compat-include/linux/average.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/cache.h b/compat-include/linux/cache.h
index 11ba7c6b..ea3b98a7 100644
--- a/compat-include/linux/cache.h
+++ b/compat-include/linux/cache.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/etherdevice.h b/compat-include/linux/etherdevice.h
index 58bab019..fbeaa677 100644
--- a/compat-include/linux/etherdevice.h
+++ b/compat-include/linux/etherdevice.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/ethtool.h b/compat-include/linux/ethtool.h
index b802e9ca..9259614a 100644
--- a/compat-include/linux/ethtool.h
+++ b/compat-include/linux/ethtool.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/compat-include/linux/export.h b/compat-include/linux/export.h
index e786e1c8..39679142 100644
--- a/compat-include/linux/export.h
+++ b/compat-include/linux/export.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/genetlink.h b/compat-include/linux/genetlink.h
index 90e8414f..0abaeb96 100644
--- a/compat-include/linux/genetlink.h
+++ b/compat-include/linux/genetlink.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/if_ether.h b/compat-include/linux/if_ether.h
index 3c2532c6..71001820 100644
--- a/compat-include/linux/if_ether.h
+++ b/compat-include/linux/if_ether.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/if_vlan.h b/compat-include/linux/if_vlan.h
index 3114e67c..994a855d 100644
--- a/compat-include/linux/if_vlan.h
+++ b/compat-include/linux/if_vlan.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/kernel.h b/compat-include/linux/kernel.h
index c6cf8773..26938cd8 100644
--- a/compat-include/linux/kernel.h
+++ b/compat-include/linux/kernel.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/kref.h b/compat-include/linux/kref.h
index f92ae695..124173ff 100644
--- a/compat-include/linux/kref.h
+++ b/compat-include/linux/kref.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/list.h b/compat-include/linux/list.h
index ea071bf8..776ef03c 100644
--- a/compat-include/linux/list.h
+++ b/compat-include/linux/list.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/net.h b/compat-include/linux/net.h
index e5636601..0dbfd913 100644
--- a/compat-include/linux/net.h
+++ b/compat-include/linux/net.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/netdev_features.h b/compat-include/linux/netdev_features.h
index ce85956f..28510994 100644
--- a/compat-include/linux/netdev_features.h
+++ b/compat-include/linux/netdev_features.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 6bbf8d8b..1f3b9c47 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
index cbc5577d..578d2efc 100644
--- a/compat-include/linux/netlink.h
+++ b/compat-include/linux/netlink.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/random.h b/compat-include/linux/random.h
index 19d445e6..a88e6fd9 100644
--- a/compat-include/linux/random.h
+++ b/compat-include/linux/random.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/rculist.h b/compat-include/linux/rculist.h
index 0f3eec38..bc2db8ec 100644
--- a/compat-include/linux/rculist.h
+++ b/compat-include/linux/rculist.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/seq_file.h b/compat-include/linux/seq_file.h
index 6a70f0b6..e98f41bb 100644
--- a/compat-include/linux/seq_file.h
+++ b/compat-include/linux/seq_file.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index f60247bd..0b641d67 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/linux/slab.h b/compat-include/linux/slab.h
index 3afd0330..33de121b 100644
--- a/compat-include/linux/slab.h
+++ b/compat-include/linux/slab.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index 66bec7aa..f69fd148 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/compat-sources/net/core/skbuff.c b/compat-sources/net/core/skbuff.c
index a130b0ee..f62e31af 100644
--- a/compat-sources/net/core/skbuff.c
+++ b/compat-sources/net/core/skbuff.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	Routines having to do with the 'struct sk_buff' memory handlers.
  *
diff --git a/compat-sources/net/ipv4/igmp.c b/compat-sources/net/ipv4/igmp.c
index e8439a03..d6e08c73 100644
--- a/compat-sources/net/ipv4/igmp.c
+++ b/compat-sources/net/ipv4/igmp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	Linux NET3:	Internet Group Management Protocol  [IGMP]
  *
diff --git a/compat-sources/net/ipv6/mcast_snoop.c b/compat-sources/net/ipv6/mcast_snoop.c
index fca0bbfa..5e500f73 100644
--- a/compat-sources/net/ipv6/mcast_snoop.c
+++ b/compat-sources/net/ipv6/mcast_snoop.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2010: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
  * Copyright (C) 2015: Linus Lüssing <linus.luessing@c0d3.blue>
  *
diff --git a/compat.h b/compat.h
index 8acfc724..15996d77 100644
--- a/compat.h
+++ b/compat.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index efd641c8..fb453382 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ISC */
 /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index f70dbd8a..93165ca0 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -1,4 +1,4 @@
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 921700ab..36407f5b 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 78836cf3..5c0a260e 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 96bc5d46..4de912c8 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
index 62e5ff65..1646664d 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 91c4b64f..c2eac642 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
index eb14b048..060e088f 100644
--- a/net/batman-adv/bat_v.h
+++ b/net/batman-adv/bat_v.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index ab10da9a..1aa175a4 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 6edab11e..2d6f6611 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index f63a6f82..0ce2d95a 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index 31e37733..31066c51 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 260059b0..8b0d2dc1 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index 4a36989a..69e8fff5 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index fd91fd67..f5b917b6 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 67e5d0cb..4c9497b4 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 563f2614..e5f76c76 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index 555f62a0..85bd864c 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 8590e7bf..e708fda4 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index 1e5a8f76..beedd7d5 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 72ba5689..c49ca050 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index dd9b28f2..a2ed3b47 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 974cee04..b962430a 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 5d3e4e5c..c34c75c1 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index b08b8e48..ddef07af 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index 3f6d9c9c..a1fb66f9 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index cd5e8e57..464c98f2 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index c56c4e60..d1760649 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index d7833f7f..33fd8fae 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index ffde3e61..55819b20 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index d46b7fd0..ca51c488 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index 41531641..c904f20e 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index c2e541fd..78e4dddb 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 7b251b45..f880d874 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d6d0bbe6..6b3db9b4 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index bc518dca..6cfbba52 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index bbd6013f..3cef5a76 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2014-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 026dc285..ef098ce3 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2014-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 5d588b7b..d70d0e2d 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index f6f33e02..f2aa2fcc 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index ba41be15..c3d65af3 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-coding.h
index b78dcbaa..80a88ef0 100644
--- a/net/batman-adv/network-coding.h
+++ b/net/batman-adv/network-coding.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 889263ce..f365de37 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 9b0c6f5a..220c12f2 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index f1fd0311..d58288c3 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 1d27e798..0acfa6ee 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 0a24d83e..5a92e883 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index cc235db8..a9c505b7 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 5e3c1428..f6ead20b 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 7384de4f..178d998b 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 85708f95..40123cb4 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 2e11d6d5..e54a662b 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index 35a6f8fa..0a3d41d5 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index b6c9ea0c..f890319b 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index f4fc6f31..cb19c283 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 98d688a4..efa4ef02 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 2b4ffd9e..21273aea 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index a310341d..fcaa7bd4 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index 314c77ec..661467be 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index e2d1d1f1..a00079fb 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
-- 
2.11.0

