Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Mar 2019 15:52:07 +0100
Message-Id: <20190303145207.19864-5-sven@narfation.org>
In-Reply-To: <20190303145207.19864-1-sven@narfation.org>
References: <20190303145207.19864-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: Drop license boilerplate
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

All files got a SPDX-License-Identifier with commit 369df8541f13
("batman-adv: Add SPDX license identifier above copyright header"). All the
required information about the license conditions can be found in
LICENSES/.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                               | 13 -------------
 compat-include/linux/average.h         | 12 ------------
 compat-include/linux/build_bug.h       | 12 ------------
 compat-include/linux/cache.h           | 12 ------------
 compat-include/linux/compiler.h        | 12 ------------
 compat-include/linux/ethtool.h         | 12 ------------
 compat-include/linux/eventpoll.h       | 12 ------------
 compat-include/linux/fs.h              | 12 ------------
 compat-include/linux/if_bridge.h       | 12 ------------
 compat-include/linux/igmp.h            | 12 ------------
 compat-include/linux/list.h            | 12 ------------
 compat-include/linux/netdevice.h       | 12 ------------
 compat-include/linux/netlink.h         | 12 ------------
 compat-include/linux/nl80211.h         | 12 ------------
 compat-include/linux/seq_file.h        | 12 ------------
 compat-include/linux/skbuff.h          | 12 ------------
 compat-include/linux/timer.h           | 12 ------------
 compat-include/linux/types.h           | 12 ------------
 compat-include/linux/uaccess.h         | 12 ------------
 compat-include/net/addrconf.h          | 12 ------------
 compat-include/net/cfg80211.h          | 12 ------------
 compat-include/net/genetlink.h         | 12 ------------
 compat-include/net/ip6_checksum.h      | 12 ------------
 compat-include/net/netlink.h           | 12 ------------
 compat-include/uapi/linux/eventpoll.h  | 12 ------------
 compat-include/uapi/linux/nl80211.h    | 12 ------------
 compat-sources/Makefile                | 12 ------------
 compat-sources/net/core/skbuff.c       |  5 -----
 compat-sources/net/ipv4/igmp.c         |  5 -----
 compat-sources/net/ipv6/mcast_snoop.c  | 13 -------------
 compat.h                               | 15 ---------------
 gen-compat-autoconf.sh                 | 12 ------------
 include/uapi/linux/batadv_packet.h     | 12 ------------
 include/uapi/linux/batman_adv.h        | 18 ------------------
 net/batman-adv/Kconfig                 | 12 ------------
 net/batman-adv/Makefile                | 13 -------------
 net/batman-adv/bat_algo.c              | 12 ------------
 net/batman-adv/bat_algo.h              | 12 ------------
 net/batman-adv/bat_iv_ogm.c            | 12 ------------
 net/batman-adv/bat_iv_ogm.h            | 12 ------------
 net/batman-adv/bat_v.c                 | 12 ------------
 net/batman-adv/bat_v.h                 | 12 ------------
 net/batman-adv/bat_v_elp.c             | 12 ------------
 net/batman-adv/bat_v_elp.h             | 12 ------------
 net/batman-adv/bat_v_ogm.c             | 12 ------------
 net/batman-adv/bat_v_ogm.h             | 12 ------------
 net/batman-adv/bitarray.c              | 12 ------------
 net/batman-adv/bitarray.h              | 12 ------------
 net/batman-adv/bridge_loop_avoidance.c | 12 ------------
 net/batman-adv/bridge_loop_avoidance.h | 12 ------------
 net/batman-adv/debugfs.c               | 12 ------------
 net/batman-adv/debugfs.h               | 12 ------------
 net/batman-adv/distributed-arp-table.c | 12 ------------
 net/batman-adv/distributed-arp-table.h | 12 ------------
 net/batman-adv/fragmentation.c         | 12 ------------
 net/batman-adv/fragmentation.h         | 12 ------------
 net/batman-adv/gateway_client.c        | 12 ------------
 net/batman-adv/gateway_client.h        | 12 ------------
 net/batman-adv/gateway_common.c        | 12 ------------
 net/batman-adv/gateway_common.h        | 12 ------------
 net/batman-adv/hard-interface.c        | 12 ------------
 net/batman-adv/hard-interface.h        | 12 ------------
 net/batman-adv/hash.c                  | 12 ------------
 net/batman-adv/hash.h                  | 12 ------------
 net/batman-adv/icmp_socket.c           | 12 ------------
 net/batman-adv/icmp_socket.h           | 12 ------------
 net/batman-adv/log.c                   | 12 ------------
 net/batman-adv/log.h                   | 12 ------------
 net/batman-adv/main.c                  | 12 ------------
 net/batman-adv/main.h                  | 12 ------------
 net/batman-adv/multicast.c             | 12 ------------
 net/batman-adv/multicast.h             | 12 ------------
 net/batman-adv/netlink.c               | 12 ------------
 net/batman-adv/netlink.h               | 12 ------------
 net/batman-adv/network-coding.c        | 12 ------------
 net/batman-adv/network-coding.h        | 12 ------------
 net/batman-adv/originator.c            | 12 ------------
 net/batman-adv/originator.h            | 12 ------------
 net/batman-adv/routing.c               | 12 ------------
 net/batman-adv/routing.h               | 12 ------------
 net/batman-adv/send.c                  | 12 ------------
 net/batman-adv/send.h                  | 12 ------------
 net/batman-adv/soft-interface.c        | 12 ------------
 net/batman-adv/soft-interface.h        | 12 ------------
 net/batman-adv/sysfs.c                 | 12 ------------
 net/batman-adv/sysfs.h                 | 12 ------------
 net/batman-adv/tp_meter.c              | 12 ------------
 net/batman-adv/tp_meter.h              | 12 ------------
 net/batman-adv/trace.c                 | 12 ------------
 net/batman-adv/trace.h                 | 12 ------------
 net/batman-adv/translation-table.c     | 12 ------------
 net/batman-adv/translation-table.h     | 12 ------------
 net/batman-adv/tvlv.c                  | 12 ------------
 net/batman-adv/tvlv.h                  | 12 ------------
 net/batman-adv/types.h                 | 12 ------------
 95 files changed, 1138 deletions(-)

diff --git a/Makefile b/Makefile
index bccea1b3..3dfe2946 100644
--- a/Makefile
+++ b/Makefile
@@ -2,19 +2,6 @@
 # Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of version 2 of the GNU General Public
-# License as published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 
 # read README.external for more information about the configuration
 # batman-adv DebugFS entries:
diff --git a/compat-include/linux/average.h b/compat-include/linux/average.h
index b768fba7..2674924f 100644
--- a/compat-include/linux/average.h
+++ b/compat-include/linux/average.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/build_bug.h b/compat-include/linux/build_bug.h
index e071e580..34357617 100644
--- a/compat-include/linux/build_bug.h
+++ b/compat-include/linux/build_bug.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/cache.h b/compat-include/linux/cache.h
index c8f4f394..efe440d1 100644
--- a/compat-include/linux/cache.h
+++ b/compat-include/linux/cache.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/compiler.h b/compat-include/linux/compiler.h
index f4a84b11..e9ccbc6e 100644
--- a/compat-include/linux/compiler.h
+++ b/compat-include/linux/compiler.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/ethtool.h b/compat-include/linux/ethtool.h
index 20071656..e1f39c33 100644
--- a/compat-include/linux/ethtool.h
+++ b/compat-include/linux/ethtool.h
@@ -3,18 +3,6 @@
  *
  * Antonio Quartulli
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/eventpoll.h b/compat-include/linux/eventpoll.h
index eb38199b..750e7f18 100644
--- a/compat-include/linux/eventpoll.h
+++ b/compat-include/linux/eventpoll.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/fs.h b/compat-include/linux/fs.h
index 30c97dc3..c52e0e8e 100644
--- a/compat-include/linux/fs.h
+++ b/compat-include/linux/fs.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/if_bridge.h b/compat-include/linux/if_bridge.h
index 63e727d2..0c158a0c 100644
--- a/compat-include/linux/if_bridge.h
+++ b/compat-include/linux/if_bridge.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/igmp.h b/compat-include/linux/igmp.h
index 3aa64197..63a5dbf6 100644
--- a/compat-include/linux/igmp.h
+++ b/compat-include/linux/igmp.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/list.h b/compat-include/linux/list.h
index 0aa887d8..b75457d5 100644
--- a/compat-include/linux/list.h
+++ b/compat-include/linux/list.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index 19acd7c2..dd99a924 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
index 4497d667..595bb9ce 100644
--- a/compat-include/linux/netlink.h
+++ b/compat-include/linux/netlink.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/nl80211.h b/compat-include/linux/nl80211.h
index 71126a1d..e2dc0915 100644
--- a/compat-include/linux/nl80211.h
+++ b/compat-include/linux/nl80211.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/seq_file.h b/compat-include/linux/seq_file.h
index 1077cfc0..f125f514 100644
--- a/compat-include/linux/seq_file.h
+++ b/compat-include/linux/seq_file.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/skbuff.h b/compat-include/linux/skbuff.h
index edda41d9..f149f31a 100644
--- a/compat-include/linux/skbuff.h
+++ b/compat-include/linux/skbuff.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/timer.h b/compat-include/linux/timer.h
index 83b4bc92..7f5a2ea4 100644
--- a/compat-include/linux/timer.h
+++ b/compat-include/linux/timer.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/types.h b/compat-include/linux/types.h
index c1571e9a..22ba449e 100644
--- a/compat-include/linux/types.h
+++ b/compat-include/linux/types.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/linux/uaccess.h b/compat-include/linux/uaccess.h
index 3a6ee47d..7901cecb 100644
--- a/compat-include/linux/uaccess.h
+++ b/compat-include/linux/uaccess.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/net/addrconf.h b/compat-include/net/addrconf.h
index a37a8e9f..98aa3991 100644
--- a/compat-include/net/addrconf.h
+++ b/compat-include/net/addrconf.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/net/cfg80211.h b/compat-include/net/cfg80211.h
index f9e60983..04806f91 100644
--- a/compat-include/net/cfg80211.h
+++ b/compat-include/net/cfg80211.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
index 8e8f1e3c..58fc24d7 100644
--- a/compat-include/net/genetlink.h
+++ b/compat-include/net/genetlink.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/net/ip6_checksum.h b/compat-include/net/ip6_checksum.h
index 5382e886..5ecbe6f6 100644
--- a/compat-include/net/ip6_checksum.h
+++ b/compat-include/net/ip6_checksum.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/net/netlink.h b/compat-include/net/netlink.h
index ce57a19e..51339fc8 100644
--- a/compat-include/net/netlink.h
+++ b/compat-include/net/netlink.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/uapi/linux/eventpoll.h b/compat-include/uapi/linux/eventpoll.h
index d4a26d60..64e06527 100644
--- a/compat-include/uapi/linux/eventpoll.h
+++ b/compat-include/uapi/linux/eventpoll.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-include/uapi/linux/nl80211.h b/compat-include/uapi/linux/nl80211.h
index 8fda321f..62500bf0 100644
--- a/compat-include/uapi/linux/nl80211.h
+++ b/compat-include/uapi/linux/nl80211.h
@@ -3,18 +3,6 @@
  *
  * Marek Lindner, Simon Wunderlich
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This file contains macros for maintaining compatibility with older versions
  * of the Linux kernel.
  */
diff --git a/compat-sources/Makefile b/compat-sources/Makefile
index fd4e6db1..9004f100 100644
--- a/compat-sources/Makefile
+++ b/compat-sources/Makefile
@@ -2,18 +2,6 @@
 # Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of version 2 of the GNU General Public
-# License as published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/core/skbuff.o
 batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += ../../compat-sources/net/ipv4/igmp.o
diff --git a/compat-sources/net/core/skbuff.c b/compat-sources/net/core/skbuff.c
index 30fbfbfb..7386b3c7 100644
--- a/compat-sources/net/core/skbuff.c
+++ b/compat-sources/net/core/skbuff.c
@@ -26,11 +26,6 @@
  *	disabled, or you better be *real* sure that the operation is atomic
  *	with respect to whatever list is being frobbed (e.g. via lock_sock()
  *	or via disabling bottom half handlers, etc).
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
  */
 
 #include <linux/in6.h>
diff --git a/compat-sources/net/ipv4/igmp.c b/compat-sources/net/ipv4/igmp.c
index ecb987d1..762818b4 100644
--- a/compat-sources/net/ipv4/igmp.c
+++ b/compat-sources/net/ipv4/igmp.c
@@ -12,11 +12,6 @@
  *	Authors:
  *		Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  *	Fixes:
  *
  *		Alan Cox	:	Added lots of __inline__ to optimise
diff --git a/compat-sources/net/ipv6/mcast_snoop.c b/compat-sources/net/ipv6/mcast_snoop.c
index 01b19969..9ab2a1a2 100644
--- a/compat-sources/net/ipv6/mcast_snoop.c
+++ b/compat-sources/net/ipv6/mcast_snoop.c
@@ -2,19 +2,6 @@
 /* Copyright (C) 2010: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
  * Copyright (C) 2015: Linus Lüssing <linus.luessing@c0d3.blue>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- *
  * Based on the MLD support added to br_multicast.c by YOSHIFUJI Hideaki.
  */
 
diff --git a/compat.h b/compat.h
index b3327fa1..faf98c13 100644
--- a/compat.h
+++ b/compat.h
@@ -2,21 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
- * This file contains macros for maintaining compatibility with older versions
- * of the Linux kernel.
  */
 
 #ifndef _NET_BATMAN_ADV_COMPAT_H_
diff --git a/gen-compat-autoconf.sh b/gen-compat-autoconf.sh
index 7a8c8eef..0acda0f2 100755
--- a/gen-compat-autoconf.sh
+++ b/gen-compat-autoconf.sh
@@ -3,18 +3,6 @@
 # Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of version 2 of the GNU General Public
-# License as published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 set -e
 
diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index c99336f4..4ebc2135 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _UAPI_LINUX_BATADV_PACKET_H_
diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 305bf316..e53f2b5e 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -2,24 +2,6 @@
 /* Copyright (C) 2016-2019  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
- * DEALINGS IN THE SOFTWARE.
  */
 
 #ifndef _UAPI_LINUX_BATMAN_ADV_H_
diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index a31db5e9..17595ec0 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -2,18 +2,6 @@
 # Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of version 2 of the GNU General Public
-# License as published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 #
 # B.A.T.M.A.N meshing protocol
diff --git a/net/batman-adv/Makefile b/net/batman-adv/Makefile
index a887ecc3..1bf7acfe 100644
--- a/net/batman-adv/Makefile
+++ b/net/batman-adv/Makefile
@@ -2,19 +2,6 @@
 # Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
 #
 # Marek Lindner, Simon Wunderlich
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of version 2 of the GNU General Public
-# License as published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful, but
-# WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-# General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 
 obj-$(CONFIG_BATMAN_ADV) += batman-adv.o
 batman-adv-y += bat_algo.o
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 7b7e1564..fa39eaaa 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/net/batman-adv/bat_algo.h b/net/batman-adv/bat_algo.h
index 25e7bb51..cb7d57d1 100644
--- a/net/batman-adv/bat_algo.h
+++ b/net/batman-adv/bat_algo.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_BAT_ALGO_H_
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index de61091a..bd4138dd 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "bat_iv_ogm.h"
diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
index 785f6666..c7a9ba30 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_BAT_IV_OGM_H_
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 445594ed..231b4aab 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "bat_v.h"
diff --git a/net/batman-adv/bat_v.h b/net/batman-adv/bat_v.h
index 465a4fc2..37833db0 100644
--- a/net/batman-adv/bat_v.h
+++ b/net/batman-adv/bat_v.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Linus Lüssing
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_BAT_V_H_
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index d5df0114..2614a9ca 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "bat_v_elp.h"
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 75f189ee..bb3d40f7 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing, Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_BAT_V_ELP_H_
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index c9698ad4..fad95ef6 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "bat_v_ogm.h"
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index f67cf7ee..616bf2ea 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_BAT_V_OGM_H_
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 63e134e7..7f04a6ac 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "bitarray.h"
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index f3a05ad9..84ad2d2b 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_BITARRAY_H_
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 4fb01108..5ce8b719 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "bridge_loop_avoidance.h"
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 31771c75..012d72c8 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_BLA_H_
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 3b9d1ad2..d38d70cc 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "debugfs.h"
diff --git a/net/batman-adv/debugfs.h b/net/batman-adv/debugfs.h
index c0b86940..7fac680c 100644
--- a/net/batman-adv/debugfs.h
+++ b/net/batman-adv/debugfs.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_DEBUGFS_H_
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 310a4f35..c14faaa3 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "distributed-arp-table.h"
diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index 68c0ff32..110c2744 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2011-2019  B.A.T.M.A.N. contributors:
  *
  * Antonio Quartulli
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_DISTRIBUTED_ARP_TABLE_H_
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index b506d15b..385fccdc 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "fragmentation.h"
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index abdac265..d6074ba2 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2013-2019  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll <martin@hundeboll.net>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_FRAGMENTATION_H_
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index f5811f61..be63d670 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "gateway_client.h"
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index b5732c8b..0e14026f 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_GATEWAY_CLIENT_H_
diff --git a/net/batman-adv/gateway_common.c b/net/batman-adv/gateway_common.c
index e064de45..dac097f9 100644
--- a/net/batman-adv/gateway_common.c
+++ b/net/batman-adv/gateway_common.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "gateway_common.h"
diff --git a/net/batman-adv/gateway_common.h b/net/batman-adv/gateway_common.h
index 128467a0..5cf50736 100644
--- a/net/batman-adv/gateway_common.h
+++ b/net/batman-adv/gateway_common.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_GATEWAY_COMMON_H_
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 96ef7c70..79d1731b 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "hard-interface.h"
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 48de28c8..c8ef6aa0 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_HARD_INTERFACE_H_
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 56a08ce1..a9d4e176 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "hash.h"
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 37507b6d..ceef171f 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2006-2019  B.A.T.M.A.N. contributors:
  *
  * Simon Wunderlich, Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_HASH_H_
diff --git a/net/batman-adv/icmp_socket.c b/net/batman-adv/icmp_socket.c
index 9859abab..de81b5ec 100644
--- a/net/batman-adv/icmp_socket.c
+++ b/net/batman-adv/icmp_socket.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "icmp_socket.h"
diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
index 5f892652..35eecbfd 100644
--- a/net/batman-adv/icmp_socket.h
+++ b/net/batman-adv/icmp_socket.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_ICMP_SOCKET_H_
diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index 3e610df8..60ce11e1 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "log.h"
diff --git a/net/batman-adv/log.h b/net/batman-adv/log.h
index 660e9bcc..5504637e 100644
--- a/net/batman-adv/log.h
+++ b/net/batman-adv/log.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_LOG_H_
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 75750870..33b9b38b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 3ed669d7..c5de9877 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_MAIN_H_
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index f91b1b62..4d6e89e0 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2014-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "multicast.h"
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index 466013fe..34fb922a 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2014-2019  B.A.T.M.A.N. contributors:
  *
  * Linus Lüssing
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_MULTICAST_H_
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 67a58da2..8e82e656 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2016-2019  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "netlink.h"
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index 72733685..d1e0681b 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2016-2019  B.A.T.M.A.N. contributors:
  *
  * Matthias Schiffer
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_NETLINK_H_
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 278762bd..c5e79060 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "network-coding.h"
diff --git a/net/batman-adv/network-coding.h b/net/batman-adv/network-coding.h
index 96ef0a51..74f56113 100644
--- a/net/batman-adv/network-coding.h
+++ b/net/batman-adv/network-coding.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Martin Hundebøll, Jeppe Ledet-Pedersen
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_NETWORK_CODING_H_
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index e5cdf89e..45db798a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2009-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "originator.h"
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index dca1e4a3..3829e26f 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_ORIGINATOR_H_
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cae0e5dd..f0f86482 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "routing.h"
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index 0102d69d..b96c6d06 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_ROUTING_H_
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 66a8b3e4..3ce5f7ba 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "send.h"
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 1f613292..5921ee4e 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_SEND_H_
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 2e367230..f8fcdd6d 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "soft-interface.h"
diff --git a/net/batman-adv/soft-interface.h b/net/batman-adv/soft-interface.h
index 538bb661..275442a7 100644
--- a/net/batman-adv/soft-interface.h
+++ b/net/batman-adv/soft-interface.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_SOFT_INTERFACE_H_
diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 0b4b3fb7..4fc9f730 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "sysfs.h"
diff --git a/net/batman-adv/sysfs.h b/net/batman-adv/sysfs.h
index 705ffbe7..2d13f59e 100644
--- a/net/batman-adv/sysfs.h
+++ b/net/batman-adv/sysfs.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_SYSFS_H_
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 500109bb..82039214 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "tp_meter.h"
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index 6b4d0f73..604b3799 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2012-2019  B.A.T.M.A.N. contributors:
  *
  * Edo Monticelli, Antonio Quartulli
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_TP_METER_H_
diff --git a/net/batman-adv/trace.c b/net/batman-adv/trace.c
index f77c917e..3cedd2c3 100644
--- a/net/batman-adv/trace.c
+++ b/net/batman-adv/trace.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Sven Eckelmann
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #define CREATE_TRACE_POINTS
diff --git a/net/batman-adv/trace.h b/net/batman-adv/trace.h
index 5e557905..d8f76452 100644
--- a/net/batman-adv/trace.h
+++ b/net/batman-adv/trace.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2010-2019  B.A.T.M.A.N. contributors:
  *
  * Sven Eckelmann
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #if !defined(_NET_BATMAN_ADV_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 26c4e249..9f43845f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "translation-table.h"
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 61bca75e..a3289798 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich, Antonio Quartulli
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_TRANSLATION_TABLE_H_
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 7e947b01..aae63f0d 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index c0f033b1..114ac01e 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_TVLV_H_
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a21b34ed..e19fdb5c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2,18 +2,6 @@
 /* Copyright (C) 2007-2019  B.A.T.M.A.N. contributors:
  *
  * Marek Lindner, Simon Wunderlich
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_TYPES_H_
-- 
2.20.1

