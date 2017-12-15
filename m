Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 15 Dec 2017 12:43:04 +0100
Message-Id: <20171215114320.13645-5-sw@simonwunderlich.de>
In-Reply-To: <20171215114320.13645-1-sw@simonwunderlich.de>
References: <20171215114320.13645-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 04/20] batman-adv: Add SPDX license
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
index f70dbd8a2935..93165ca0ea0c 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -1,4 +1,4 @@
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 921700ab306d..36407f5bde08 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 78836cf312d4..5c0a260eee5f 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 96bc5d46548f..4de912c87c23 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
index 62e5ff655bad..1646664d2b4b 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 91c4b64f0c09..c2eac642fabf 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
index eb14b0483d44..060e088f293a 100644
--- a/net/batman-adv/bat_v.h
+++ b/net/batman-adv/bat_v.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index ab10da9a8df0..1aa175a41d62 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 6edab11efd2a..2d6f66119df8 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index f63a6f8204f8..0ce2d95a10aa 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index 31e37733c547..31066c51e1d8 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 260059b03276..8b0d2dc12679 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index 4a36989a4842..69e8fff5c7c2 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index fd91fd673ec8..f5b917b634df 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 67e5d0cb74d1..4c9497b49c93 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 563f2614a3f3..e5f76c76f3ed 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index 555f62a0efb7..85bd864c2bbd 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 8590e7bfa5d9..e708fda4654d 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index 1e5a8f769bdf..beedd7d5531b 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2011-2017  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 72ba568991ee..c49ca0503030 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index dd9b28f2ce60..a2ed3b4755b5 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2013-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 974cee04bfdf..b962430a45ee 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 5d3e4e5c14e9..c34c75c11183 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index b08b8e48992c..ddef07afd999 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index 3f6d9c9c1647..a1fb66f9ca72 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index cd5e8e572199..464c98f2a0c6 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index c56c4e603229..d17606491d24 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index d7833f7fbce4..33fd8fae2a1d 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index ffde3e613d35..55819b20d316 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2006-2017  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index d46b7fd0b9bb..ca51c488f159 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index 415316419d98..c904f20e43ee 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index c2e541fdc7c2..78e4dddb7f2d 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 7b251b450533..f880d8741c7f 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d6d0bbe66b54..6b3db9b42b08 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index d8ee90fe549a..34acfd1f96f4 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index bbd6013fca64..3cef5a764f8d 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2014-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 026dc28592d5..ef098ce363ba 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2014-2017  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 5d588b7b0136..d70d0e2d1b2e 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index f6f33e02a165..f2aa2fcc0b36 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2016-2017  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index ba41be15d0fc..c3d65af33707 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-coding.h
index b78dcbaaea86..80a88ef08964 100644
--- a/net/batman-adv/network-coding.h
+++ b/net/batman-adv/network-coding.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index de6d05cd1a7e..b435106c1617 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2009-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index eae221ee7de4..0e0a12e600af 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index f1fd03116f75..d58288c3a99d 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 1d27e798fb77..0acfa6eee832 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 0a24d83e42e9..5a92e883ea53 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index cc235db866a0..a9c505b78fcd 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 5e3c142821f0..f6ead20b7458 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 7384de4fa8bf..178d998b420b 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 85708f957d00..40123cb4255a 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 2e11d6d5dd74..e54a662b34b1 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index 35a6f8fae5df..0a3d41d52208 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2010-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 4095bf6d5e6c..e7b8ed079f94 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index f4fc6f312fc1..cb19c283cbcc 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2012-2017  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 98d688a4dcfa..efa4ef02639e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 2b4ffd9ea981..21273aea40ad 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index a310341d9b8f..fcaa7bd415bd 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index 314c77ec212e..661467be2af7 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index e2d1d1f13ffb..a00079fbb1b8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
-- 
2.11.0

