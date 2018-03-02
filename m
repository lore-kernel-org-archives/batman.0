Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  2 Mar 2018 18:57:42 +0100
Message-Id: <20180302175745.12551-3-sw@simonwunderlich.de>
In-Reply-To: <20180302175745.12551-1-sw@simonwunderlich.de>
References: <20180302175745.12551-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Update copyright years for
 2018
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 include/uapi/linux/batadv_packet.h     | 2 +-
 include/uapi/linux/batman_adv.h        | 2 +-
 net/batman-adv/Kconfig                 | 2 +-
 net/batman-adv/Makefile                | 2 +-
 net/batman-adv/bat_algo.c              | 2 +-
 net/batman-adv/bat_algo.h              | 2 +-
 net/batman-adv/bat_iv_ogm.c            | 2 +-
 net/batman-adv/bat_iv_ogm.h            | 2 +-
 net/batman-adv/bat_v.c                 | 2 +-
 net/batman-adv/bat_v.h                 | 2 +-
 net/batman-adv/bat_v_elp.c             | 2 +-
 net/batman-adv/bat_v_elp.h             | 2 +-
 net/batman-adv/bat_v_ogm.c             | 2 +-
 net/batman-adv/bat_v_ogm.h             | 2 +-
 net/batman-adv/bitarray.c              | 2 +-
 net/batman-adv/bitarray.h              | 2 +-
 net/batman-adv/bridge_loop_avoidance.c | 2 +-
 net/batman-adv/bridge_loop_avoidance.h | 2 +-
 net/batman-adv/debugfs.c               | 2 +-
 net/batman-adv/debugfs.h               | 2 +-
 net/batman-adv/distributed-arp-table.c | 2 +-
 net/batman-adv/distributed-arp-table.h | 2 +-
 net/batman-adv/fragmentation.c         | 2 +-
 net/batman-adv/fragmentation.h         | 2 +-
 net/batman-adv/gateway_client.c        | 2 +-
 net/batman-adv/gateway_client.h        | 2 +-
 net/batman-adv/gateway_common.c        | 2 +-
 net/batman-adv/gateway_common.h        | 2 +-
 net/batman-adv/hard-interface.c        | 2 +-
 net/batman-adv/hard-interface.h        | 2 +-
 net/batman-adv/hash.c                  | 2 +-
 net/batman-adv/hash.h                  | 2 +-
 net/batman-adv/icmp_socket.c           | 2 +-
 net/batman-adv/icmp_socket.h           | 2 +-
 net/batman-adv/log.c                   | 2 +-
 net/batman-adv/log.h                   | 2 +-
 net/batman-adv/main.c                  | 2 +-
 net/batman-adv/main.h                  | 2 +-
 net/batman-adv/multicast.c             | 2 +-
 net/batman-adv/multicast.h             | 2 +-
 net/batman-adv/netlink.c               | 2 +-
 net/batman-adv/netlink.h               | 2 +-
 net/batman-adv/network-coding.c        | 2 +-
 net/batman-adv/network-coding.h        | 2 +-
 net/batman-adv/originator.c            | 2 +-
 net/batman-adv/originator.h            | 2 +-
 net/batman-adv/routing.c               | 2 +-
 net/batman-adv/routing.h               | 2 +-
 net/batman-adv/send.c                  | 2 +-
 net/batman-adv/send.h                  | 2 +-
 net/batman-adv/soft-interface.c        | 2 +-
 net/batman-adv/soft-interface.h        | 2 +-
 net/batman-adv/sysfs.c                 | 2 +-
 net/batman-adv/sysfs.h                 | 2 +-
 net/batman-adv/tp_meter.c              | 2 +-
 net/batman-adv/tp_meter.h              | 2 +-
 net/batman-adv/translation-table.c     | 2 +-
 net/batman-adv/translation-table.h     | 2 +-
 net/batman-adv/tvlv.c                  | 2 +-
 net/batman-adv/tvlv.h                  | 2 +-
 net/batman-adv/types.h                 | 2 +-
 61 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 5cb360be2a11..daefd7283896 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index ae00c99cbed0..56ae28934070 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: MIT */
-/* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2018  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  *
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index c44f6515be5e..e4e2e02b7380 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 022f6e77307b..b97ba6fb8353 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 80c72c7d3cad..ea309ad06175 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 029221615ba3..534b790c3753 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
  *
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 79e326383726..e21aa147607b 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
index 9dc0dd5c83df..317cafd302cf 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 27e165ac9302..9c3a34b65b15 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
  *
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
index a17ab68bbce8..ec4a2a569750 100644
--- a/net/batman-adv/bat_v.h
+++ b/net/batman-adv/bat_v.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
  *
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index a83478c46597..28687493599f 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
  *
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 5e39d0588a48..e8c7b7fd290d 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
  *
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index ba59b77c605d..2948b41b06d4 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index 6a4c14ccc3c6..ed36c5e79fde 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index bdc1ef06e05b..a296a4d851f5 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index ca9d0753dd6b..48f683289531 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index fad47853ad3c..8ff81346ff0c 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index b27571abcd2f..71f95a3e4d3f 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 21d1189957a7..4229b01ac7b5 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index 90a08d35c501..37b069698b04 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 9703c791ffc5..19b15de455ab 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index 12897eb46268..e24aa9601c52 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2018  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 22dde42fd80e..d815acc13c35 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index 138b22a1836a..944512e07782 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2018  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 37fe9a644f22..c294f6fd43e0 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 981f58421a32..f0b86fcb2493 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index b3e156af2256..936c107f3199 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index afebd9c7edf4..80afb2793687 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 5f186bff284a..fd4a263dd6b7 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index de5e9a374ece..d1c0f6189301 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 04d964358c98..7b49e4001778 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 4ce1b6d3ad5c..9490a7ca2ba6 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2018  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index e91f29c7c638..7d5e9abb7a65 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index 84cddd01eeab..958be22beda9 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index dc9fa37ddd14..52d8a4b848c0 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 35e02b2b9e72..35f4f397ed57 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d31c8266e244..69c0d85bceb3 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 69bfedfad174..d5d65999207e 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index cbdeb47ec3f6..6eaffe50335a 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2014-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2014-2018  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
  *
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 3ac06337ab71..6b8594e23da3 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2014-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2014-2018  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
  *
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index a823d3899bad..129af56b944d 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2018  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  *
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 0e7e57b69b54..571d9a5ae7aa 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2016-2018  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
  *
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index b48116bb24ef..c3578444f3cb 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  *
diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-coding.h
index adaeafa4f71e..65c346812bc1 100644
--- a/net/batman-adv/network-coding.h
+++ b/net/batman-adv/network-coding.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  *
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 58a7d9274435..2a51a0cbb82a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 8e543a3cdc6c..f3601ab0872e 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index b6891e8b741c..289df027ecdd 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index a1289bc5f115..db54c2d9b8bf 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 2a5ab6f1076d..4a35f5c2f52b 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 1e8c79093623..64cce07b8fe6 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 900c5ce21cd4..c95e2b2677fd 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 075c5b5b2ce1..daf87f07fadd 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index c1578fa0b952..f2eef43bd2ec 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index bbeee61221fa..c1e3fb69952d 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 8b576712d0c1..11520de96ccb 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
  *
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index c8b8f2cb2c2b..68e600974759 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2018  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
  *
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7550a9ccd695..0225616d5771 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 8d9e3abec2c8..01b6c8eafaf9 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 5ffcb45ac6ff..a637458205d1 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index a74df33f446d..ef5867f49824 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index bb1578410e0c..4a3b8837e1b5 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2018  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
-- 
2.11.0

