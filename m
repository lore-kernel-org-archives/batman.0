Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Dec 2017 12:01:08 +0100
Message-Id: <20171220110124.13117-4-sw@simonwunderlich.de>
In-Reply-To: <20171220110124.13117-1-sw@simonwunderlich.de>
References: <20171220110124.13117-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 03/19] batman-adv: Add SPDX license
 identifier above copyright header
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The "Linux kernel licensing rules" require that each file has a SPDX
license identifier as first line (and sometimes as second line).

The FSFE REUSE practices [1] would also require the same tags but have no
restrictions on the placement in the source file. Using the "Linux kernel
licensing rules" is therefore also fulfilling the FSFE REUSE practices
requirements at the same time.

[1] https://reuse.software/practices/

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
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
 60 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index efd641c8a5d6..fb4533826163 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ISC */
 /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 915987bc6d29..022f6e77307b 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -1,4 +1,4 @@
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 44fd073b7546..fa306b25a78b 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 29f6312f9bf1..029221615ba3 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 1b659ab652fb..bff5ec66a2e1 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
index ae2ab526bdb1..9dc0dd5c83df 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 341ceab8338d..16709552c21e 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
index dd7c4b647e6b..a17ab68bbce8 100644
--- a/net/batman-adv/bat_v.h
+++ b/net/batman-adv/bat_v.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1de992c58b35..8375fd679db3 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 376ead280ab9..5e39d0588a48 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index c251445a42a0..22d2bafa814a 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index 2068770b542d..6a4c14ccc3c6 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 2b070c7e31da..125817c389e5 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index cc262c9d97e0..8cb2c874f5d3 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index cdd8e8e4df0b..007147f3ed9e 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 234775748b8e..b568cec819c5 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index e32ad47c6efd..d94585dc2dbe 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index 9c5d4a65b98c..90a08d35c501 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 760c0de72582..3c2faf773335 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index ec364a3c1c66..d81a05a6e6f9 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index a98cf1104a30..22ce4c0c86c3 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index 1a2d6c308745..30ffa992fcfc 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 10d521f0b17f..e8db19940ab8 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 3baa3d466e5e..981f58421a32 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index 2c26039c23fc..a7039503d88e 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index 0a6a97d201f2..7c298b05c1dc 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 4e3d5340ad96..2f067a507fd5 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 9f9890ff7a22..ac7311a91f9d 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index b5f7e13918ac..a6dbaf2e9fc9 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 0c905e91c5e2..81cf54eb2fad 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index bded31121d12..cc76f1365300 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index f3fec40aae86..84cddd01eeab 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 4ef4bde2cc2d..148e64e846d2 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 65ce97efa6b5..6744a64143c0 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 4daed7ad46f2..5ce2007ea11b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index bb8003cf2296..4bdb39ab3b20 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index e553a8770a89..01546a42b7ad 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2014-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 2a78cddab0e9..51f273b5b77d 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2014-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index ab13b4d58733..ce424fe2f24e 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index f1cd8c5da966..0e7e57b69b54 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 3604d7899e2c..5cfac6e56610 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-coding.h
index c66efb81d2f4..adaeafa4f71e 100644
--- a/net/batman-adv/network-coding.h
+++ b/net/batman-adv/network-coding.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 0a565d0422bb..0716daf5b9a7 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 40c7f039d5d7..b5d2164532c9 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index 8e8a5db197cb..4eaf4b426726 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 40d9bf3e5bfe..86b0ea1e5c1c 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 5ede16c32f15..a1289bc5f115 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 7895323fd2a7..a6c53684ba70 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index a16b34f473ef..eb36820e41bc 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 9f673cdfecf8..e543024f98ef 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 639c3abb214a..075c5b5b2ce1 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index aa187fd42475..ab0b95f15b36 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index e487412e256b..0384cb6c406b 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 15cd2139381e..601feb2c4ecf 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index a8ada5c123bd..c8b8f2cb2c2b 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 8a3ce79b1307..281bd4cf7f90 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 411d586191da..8d9e3abec2c8 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 1d9e267caec9..67b2ba4b824b 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index 4d01400ada30..a74df33f446d 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a62795868794..1df798b32077 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
-- 
2.11.0

