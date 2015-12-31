Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Jan 2016 00:01:03 +0100
Message-Id: <1451602863-23358-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: update copyright years for 2016
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
 Makefile                               | 2 +-
 compat-include/linux/atomic.h          | 2 +-
 compat-include/linux/bug.h             | 2 +-
 compat-include/linux/compiler.h        | 2 +-
 compat-include/linux/etherdevice.h     | 2 +-
 compat-include/linux/export.h          | 2 +-
 compat-include/linux/if_ether.h        | 2 +-
 compat-include/linux/if_vlan.h         | 2 +-
 compat-include/linux/kconfig.h         | 2 +-
 compat-include/linux/kernel.h          | 2 +-
 compat-include/linux/list.h            | 2 +-
 compat-include/linux/lockdep.h         | 2 +-
 compat-include/linux/moduleparam.h     | 2 +-
 compat-include/linux/net.h             | 2 +-
 compat-include/linux/netdev_features.h | 2 +-
 compat-include/linux/netdevice.h       | 2 +-
 compat-include/linux/percpu.h          | 2 +-
 compat-include/linux/printk.h          | 2 +-
 compat-include/linux/random.h          | 2 +-
 compat-include/linux/rculist.h         | 2 +-
 compat-include/linux/rcupdate.h        | 2 +-
 compat-include/linux/seq_file.h        | 2 +-
 compat-include/linux/skbuff.h          | 2 +-
 compat-include/linux/slab.h            | 2 +-
 compat.h                               | 2 +-
 net/batman-adv/Makefile                | 2 +-
 net/batman-adv/bat_algo.h              | 2 +-
 net/batman-adv/bat_iv_ogm.c            | 2 +-
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
 net/batman-adv/main.c                  | 2 +-
 net/batman-adv/main.h                  | 2 +-
 net/batman-adv/multicast.c             | 2 +-
 net/batman-adv/multicast.h             | 2 +-
 net/batman-adv/network-coding.c        | 2 +-
 net/batman-adv/network-coding.h        | 2 +-
 net/batman-adv/originator.c            | 2 +-
 net/batman-adv/originator.h            | 2 +-
 net/batman-adv/packet.h                | 2 +-
 net/batman-adv/routing.c               | 2 +-
 net/batman-adv/routing.h               | 2 +-
 net/batman-adv/send.c                  | 2 +-
 net/batman-adv/send.h                  | 2 +-
 net/batman-adv/soft-interface.c        | 2 +-
 net/batman-adv/soft-interface.h        | 2 +-
 net/batman-adv/sysfs.c                 | 2 +-
 net/batman-adv/sysfs.h                 | 2 +-
 net/batman-adv/translation-table.c     | 2 +-
 net/batman-adv/translation-table.h     | 2 +-
 net/batman-adv/types.h                 | 2 +-
 68 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/Makefile b/Makefile
index ee3be1d..e31c04b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/compat-include/linux/atomic.h b/compat-include/linux/atomic.h
index 025c8b1..5f254fe 100644
--- a/compat-include/linux/atomic.h
+++ b/compat-include/linux/atomic.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/bug.h b/compat-include/linux/bug.h
index 9b7b571..a8b9508 100644
--- a/compat-include/linux/bug.h
+++ b/compat-include/linux/bug.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/compiler.h b/compat-include/linux/compiler.h
index 29a02ae..8d47375 100644
--- a/compat-include/linux/compiler.h
+++ b/compat-include/linux/compiler.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/etherdevice.h b/compat-include/linux/etherdevice.h
index aada96d..d69caf2 100644
--- a/compat-include/linux/etherdevice.h
+++ b/compat-include/linux/etherdevice.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/export.h b/compat-include/linux/export.h
index 3901b29..b69509d 100644
--- a/compat-include/linux/export.h
+++ b/compat-include/linux/export.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/if_ether.h b/compat-include/linux/if_ether.h
index edfc7e8..fcf7f55 100644
--- a/compat-include/linux/if_ether.h
+++ b/compat-include/linux/if_ether.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/if_vlan.h b/compat-include/linux/if_vlan.h
index 0cbd5c4..28233a9 100644
--- a/compat-include/linux/if_vlan.h
+++ b/compat-include/linux/if_vlan.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/kconfig.h b/compat-include/linux/kconfig.h
index a8d0766..bf5d8bf 100644
--- a/compat-include/linux/kconfig.h
+++ b/compat-include/linux/kconfig.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/kernel.h b/compat-include/linux/kernel.h
index c39cbe8..5ffec9a 100644
--- a/compat-include/linux/kernel.h
+++ b/compat-include/linux/kernel.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/list.h b/compat-include/linux/list.h
index 75bcc1c..014242a 100644
--- a/compat-include/linux/list.h
+++ b/compat-include/linux/list.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/lockdep.h b/compat-include/linux/lockdep.h
index e646114..98bd41c 100644
--- a/compat-include/linux/lockdep.h
+++ b/compat-include/linux/lockdep.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/moduleparam.h b/compat-include/linux/moduleparam.h
index c266b9c..c61098b 100644
--- a/compat-include/linux/moduleparam.h
+++ b/compat-include/linux/moduleparam.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/net.h b/compat-include/linux/net.h
index c60acf7..65d9c7d 100644
--- a/compat-include/linux/net.h
+++ b/compat-include/linux/net.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/netdev_features.h b/compat-include/linux/netdev_features.h
index f381142..129b28e 100644
--- a/compat-include/linux/netdev_features.h
+++ b/compat-include/linux/netdev_features.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index eca7668..2de73b8 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/percpu.h b/compat-include/linux/percpu.h
index 0fbcaae..04d87d8 100644
--- a/compat-include/linux/percpu.h
+++ b/compat-include/linux/percpu.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/printk.h b/compat-include/linux/printk.h
index 2b31ed1..bf66859 100644
--- a/compat-include/linux/printk.h
+++ b/compat-include/linux/printk.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/random.h b/compat-include/linux/random.h
index 55b0384..098efc5 100644
--- a/compat-include/linux/random.h
+++ b/compat-include/linux/random.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/rculist.h b/compat-include/linux/rculist.h
index 0b8d7c6..9819876 100644
--- a/compat-include/linux/rculist.h
+++ b/compat-include/linux/rculist.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/rcupdate.h b/compat-include/linux/rcupdate.h
index f0d0413..d02df96 100644
--- a/compat-include/linux/rcupdate.h
+++ b/compat-include/linux/rcupdate.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/seq_file.h b/compat-include/linux/seq_file.h
index 3c0c618..7d43d02 100644
--- a/compat-include/linux/seq_file.h
+++ b/compat-include/linux/seq_file.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index d363cc0..7b5b857 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat-include/linux/slab.h b/compat-include/linux/slab.h
index 276d678..bc046dd 100644
--- a/compat-include/linux/slab.h
+++ b/compat-include/linux/slab.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/compat.h b/compat.h
index f6f8c44..ab6de5a 100644
--- a/compat.h
+++ b/compat.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index 21434ab..b1f803b 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -1,5 +1,5 @@
 #
-# Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+# Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
 #
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 4e59cf3..ac1b24e 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 12bdffa..b92e03d 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 3404195..51f6486 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index 2b64d7a..30d767b 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index d9b034a..54aaa92 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 7ea199b..01ce240 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
  *
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 0fc9df5..6f765ac 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index 80ab8d6..a4decb7 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 60df823..6db23f0 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2016  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index 26d4a52..8c25808 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2011-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2011-2016  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
  *
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 80eddf4..dc51d1b 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2013-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2016  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index c5476fe..0e6a44a 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2013-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2013-2016  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
  *
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 8350775..403e6a7 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index fa95277..3909476 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index b287448..b047696 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index ab893e3..48df505 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 49e05d2..a0391e0 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 5a31420..fc38f13 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 2ea6a18..7bd9936 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 071a87e..de804fa 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2006-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2006-2016  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
  *
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index bcabb5e..0fe013c 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index e937143..34cdff1 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 9d34be6..1905ef3 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index a58dc2f..be27f2f 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 8abf488..5ef66b8 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2014-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2014-2016  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
  *
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 685219f..300771d 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2014-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2014-2016  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
  *
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 56100c5..067ba05 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2012-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  *
diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-coding.h
index 8f6d4ad..4990886 100644
--- a/net/batman-adv/network-coding.h
+++ b/net/batman-adv/network-coding.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2012-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2012-2016  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
  *
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 00b0437..ae0489f 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2009-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2009-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index 2955775..303dbfc 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/packet.h b/net/batman-adv/packet.h
index fdb0163..58dd78a 100644
--- a/net/batman-adv/packet.h
+++ b/net/batman-adv/packet.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 0ba5993..f24d576 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 5315fb3..f3d62e7 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index c188f46..132d965 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 3adc11f..70c2325 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 6c65de9..a83e210 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 8e82176..bda4efe 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index f38d7b7..6bedbdc 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index 6197442..6c4fa8f 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2010-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2010-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
  *
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1ca8831..a603ca5 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index abd8e11..5ceaa7a 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
  *
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 5e8c8df..0dd762c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1,4 +1,4 @@
-/* Copyright (C) 2007-2015 B.A.T.M.A.N. contributors:
+/* Copyright (C) 2007-2016  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
  *
-- 
2.6.4

