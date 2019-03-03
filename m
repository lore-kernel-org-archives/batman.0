Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Mar 2019 15:52:06 +0100
Message-Id: <20190303145207.19864-4-sven@narfation.org>
In-Reply-To: <20190303145207.19864-1-sven@narfation.org>
References: <20190303145207.19864-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batctl: Drop license boilerplate
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

All files got a SPDX-License-Identifier with commit 696ebd7be0a6
("batctl: Add SPDX license identifier above copyright header"). All the
required information about the license conditions can be found in
LICENSES/.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile                | 14 --------------
 aggregation.c           | 14 --------------
 allocate.h              | 14 --------------
 ap_isolation.c          | 14 --------------
 backbonetable.c         | 14 --------------
 bat-hosts.c             | 14 --------------
 bat-hosts.h             | 14 --------------
 batadv_packet.h         | 12 ------------
 batman_adv.h            | 18 ------------------
 bisect_iv.c             | 14 --------------
 bisect_iv.h             | 14 --------------
 bonding.c               | 14 --------------
 bridge_loop_avoidance.c | 14 --------------
 claimtable.c            | 14 --------------
 dat_cache.c             | 14 --------------
 debug.c                 | 14 --------------
 debug.h                 | 14 --------------
 debugfs.c               | 14 --------------
 debugfs.h               | 14 --------------
 distributed_arp_table.c | 14 --------------
 event.c                 | 14 --------------
 fragmentation.c         | 14 --------------
 functions.c             | 14 --------------
 functions.h             | 14 --------------
 gateways.c              | 14 --------------
 genl.c                  | 12 ------------
 genl.h                  | 14 --------------
 gw_mode.c               | 14 --------------
 hash.c                  | 14 --------------
 hash.h                  | 14 --------------
 hop_penalty.c           | 14 --------------
 icmp_helper.c           | 14 --------------
 icmp_helper.h           | 14 --------------
 interface.c             | 14 --------------
 isolation_mark.c        | 14 --------------
 list.h                  | 18 +-----------------
 log.c                   | 14 --------------
 loglevel.c              | 14 --------------
 main.c                  | 14 --------------
 main.h                  | 14 --------------
 mcast_flags.c           | 14 --------------
 multicast_forceflood.c  | 14 --------------
 multicast_mode.c        | 14 --------------
 nc_nodes.c              | 14 --------------
 neighbors.c             | 14 --------------
 netlink.c               | 14 --------------
 netlink.h               | 14 --------------
 network_coding.c        | 14 --------------
 orig_interval.c         | 14 --------------
 originators.c           | 14 --------------
 ping.c                  | 14 --------------
 routing_algo.c          | 14 --------------
 statistics.c            | 14 --------------
 sys.c                   | 14 --------------
 sys.h                   | 14 --------------
 tcpdump.c               | 14 --------------
 tcpdump.h               | 14 --------------
 throughputmeter.c       | 14 --------------
 traceroute.c            | 14 --------------
 transglobal.c           | 14 --------------
 translate.c             | 14 --------------
 translocal.c            | 14 --------------
 62 files changed, 1 insertion(+), 871 deletions(-)

diff --git a/Makefile b/Makefile
index 03dc804..645d157 100755
--- a/Makefile
+++ b/Makefile
@@ -4,20 +4,6 @@
 #
 # Copyright (C) 2006-2019  B.A.T.M.A.N. contributors
 #
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
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA
-#
 # License-Filename: LICENSES/preferred/GPL-2.0
 
 # just for backward compatibility - please use CONFIG_bisect_iv instead
diff --git a/aggregation.c b/aggregation.c
index 3708215..18e19d8 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/allocate.h b/allocate.h
index 6c14609..69353a2 100644
--- a/allocate.h
+++ b/allocate.h
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/ap_isolation.c b/ap_isolation.c
index dd1e8c8..71dcd00 100644
--- a/ap_isolation.c
+++ b/ap_isolation.c
@@ -3,20 +3,6 @@
  *
  * Antonio Quartulli <a@unstable.cc>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/backbonetable.c b/backbonetable.c
index 878edc0..2e22e34 100644
--- a/backbonetable.c
+++ b/backbonetable.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich <sw@simonwunderlich.de>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/bat-hosts.c b/bat-hosts.c
index 8be8c75..1e9c21b 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -3,20 +3,6 @@
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/bat-hosts.h b/bat-hosts.h
index 85e75b7..fff81f0 100644
--- a/bat-hosts.h
+++ b/bat-hosts.h
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/batadv_packet.h b/batadv_packet.h
index c99336f..4ebc213 100644
--- a/batadv_packet.h
+++ b/batadv_packet.h
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
diff --git a/batman_adv.h b/batman_adv.h
index 305bf31..e53f2b5 100644
--- a/batman_adv.h
+++ b/batman_adv.h
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
diff --git a/bisect_iv.c b/bisect_iv.c
index 019a35a..7f03823 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/bisect_iv.h b/bisect_iv.h
index 5ac6b9a..cf20196 100644
--- a/bisect_iv.h
+++ b/bisect_iv.h
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/bonding.c b/bonding.c
index f895328..fd95e8d 100644
--- a/bonding.c
+++ b/bonding.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index aac83c5..37acaa7 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich <sw@simonwunderlich.de>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/claimtable.c b/claimtable.c
index fd083c9..2de7c79 100644
--- a/claimtable.c
+++ b/claimtable.c
@@ -3,20 +3,6 @@
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/dat_cache.c b/dat_cache.c
index 21e96d9..4a8a082 100644
--- a/dat_cache.c
+++ b/dat_cache.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/debug.c b/debug.c
index 83130bf..4a3b6cb 100644
--- a/debug.c
+++ b/debug.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/debug.h b/debug.h
index 11a805c..3294361 100644
--- a/debug.h
+++ b/debug.h
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/debugfs.c b/debugfs.c
index 1cea8ac..5a71d65 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -2,20 +2,6 @@
 /* Copyright (C) 2009 Clark Williams <williams@redhat.com>
  * Copyright (C) 2009 Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/debugfs.h b/debugfs.h
index 6e49efa..61384f9 100644
--- a/debugfs.h
+++ b/debugfs.h
@@ -2,20 +2,6 @@
 /* Copyright (C) 2009 Clark Williams <williams@redhat.com>
  * Copyright (C) 2009 Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/distributed_arp_table.c b/distributed_arp_table.c
index 230e0ef..cbfb296 100644
--- a/distributed_arp_table.c
+++ b/distributed_arp_table.c
@@ -3,20 +3,6 @@
  *
  * Antonio Quartulli <a@unstable.cc>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/event.c b/event.c
index 62ccf56..50d1cd0 100644
--- a/event.c
+++ b/event.c
@@ -3,20 +3,6 @@
  *
  * Sven Eckelmann <sven@narfation.org>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/fragmentation.c b/fragmentation.c
index 080de00..d4b0f54 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/functions.c b/functions.c
index a202969..9720257 100644
--- a/functions.c
+++ b/functions.c
@@ -3,20 +3,6 @@
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/functions.h b/functions.h
index b3f2159..23186e5 100644
--- a/functions.h
+++ b/functions.h
@@ -3,20 +3,6 @@
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/gateways.c b/gateways.c
index be45d2e..ccb2b44 100644
--- a/gateways.c
+++ b/gateways.c
@@ -3,20 +3,6 @@
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/genl.c b/genl.c
index 0a2bd92..cd6c652 100644
--- a/genl.c
+++ b/genl.c
@@ -4,18 +4,6 @@
  * Copyright (c) 2007		Andy Lutomirski
  * Copyright (c) 2007		Mike Kershaw
  * Copyright (c) 2008-2009		Luis R. Rodriguez
- * 
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- * 
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 /*
diff --git a/genl.h b/genl.h
index 8f6be80..25ee32a 100644
--- a/genl.h
+++ b/genl.h
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/gw_mode.c b/gw_mode.c
index e67a1d1..7c17bee 100644
--- a/gw_mode.c
+++ b/gw_mode.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/hash.c b/hash.c
index 5f93367..4ff54bc 100644
--- a/hash.c
+++ b/hash.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich, Marek Lindner
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/hash.h b/hash.h
index 75577f8..d000669 100644
--- a/hash.h
+++ b/hash.h
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich, Marek Lindner
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 #ifndef _BATMAN_HASH_H
diff --git a/hop_penalty.c b/hop_penalty.c
index 58067bf..56e1168 100644
--- a/hop_penalty.c
+++ b/hop_penalty.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/icmp_helper.c b/icmp_helper.c
index 69c8505..bfe99f0 100644
--- a/icmp_helper.c
+++ b/icmp_helper.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/icmp_helper.h b/icmp_helper.h
index f377303..a2aefcd 100644
--- a/icmp_helper.h
+++ b/icmp_helper.h
@@ -3,20 +3,6 @@
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/interface.c b/interface.c
index 25b4af9..667a308 100644
--- a/interface.c
+++ b/interface.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/isolation_mark.c b/isolation_mark.c
index aeb2da3..3686317 100644
--- a/isolation_mark.c
+++ b/isolation_mark.c
@@ -3,20 +3,6 @@
  *
  * Antonio Quartulli <a@unstable.cc>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/list.h b/list.h
index e7d72c2..33445c3 100644
--- a/list.h
+++ b/list.h
@@ -3,23 +3,7 @@
  *
  * Copyright (c) 2012-2019, Sven Eckelmann <sven@narfation.org>
  *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
- * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
+ * License-Filename: LICENSES/preferred/MIT
  */
 
 #ifndef __LINUX_LIKE_LIST_H__
diff --git a/log.c b/log.c
index b5f65f7..e950bad 100644
--- a/log.c
+++ b/log.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/loglevel.c b/loglevel.c
index 778c4b4..aff8b82 100644
--- a/loglevel.c
+++ b/loglevel.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/main.c b/main.c
index 199c7a4..278683c 100644
--- a/main.c
+++ b/main.c
@@ -3,20 +3,6 @@
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/main.h b/main.h
index 92d0e61..b43d622 100644
--- a/main.h
+++ b/main.h
@@ -3,20 +3,6 @@
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/mcast_flags.c b/mcast_flags.c
index 8529394..a1fdf31 100644
--- a/mcast_flags.c
+++ b/mcast_flags.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/multicast_forceflood.c b/multicast_forceflood.c
index daaa6d0..fdc5400 100644
--- a/multicast_forceflood.c
+++ b/multicast_forceflood.c
@@ -3,20 +3,6 @@
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/multicast_mode.c b/multicast_mode.c
index fb17586..063166e 100644
--- a/multicast_mode.c
+++ b/multicast_mode.c
@@ -3,20 +3,6 @@
  *
  * Linus Lüssing <linus.luessing@c0d3.blue>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/nc_nodes.c b/nc_nodes.c
index 7c75a91..baf4565 100644
--- a/nc_nodes.c
+++ b/nc_nodes.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/neighbors.c b/neighbors.c
index f725674..1a41d62 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -3,20 +3,6 @@
  *
  * Andrew Lunn <andrew@lunn.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/netlink.c b/netlink.c
index 5b9966c..aa45f4f 100644
--- a/netlink.c
+++ b/netlink.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/netlink.h b/netlink.h
index 5766918..38868b7 100644
--- a/netlink.h
+++ b/netlink.h
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>, Andrew Lunn <andrew@lunn.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/network_coding.c b/network_coding.c
index 01d7515..d22fab0 100644
--- a/network_coding.c
+++ b/network_coding.c
@@ -3,20 +3,6 @@
  *
  * Martin Hundebøll <martin@hundeboll.net>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/orig_interval.c b/orig_interval.c
index d1501af..a90ba27 100644
--- a/orig_interval.c
+++ b/orig_interval.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/originators.c b/originators.c
index 59e3d34..32c1300 100644
--- a/originators.c
+++ b/originators.c
@@ -4,20 +4,6 @@
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/ping.c b/ping.c
index 14fea21..d798a5e 100644
--- a/ping.c
+++ b/ping.c
@@ -3,20 +3,6 @@
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/routing_algo.c b/routing_algo.c
index 4b31821..d4e205d 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/statistics.c b/statistics.c
index f8cb6a1..2a90a1d 100644
--- a/statistics.c
+++ b/statistics.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/sys.c b/sys.c
index b0864cd..39123db 100644
--- a/sys.c
+++ b/sys.c
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/sys.h b/sys.h
index 50f82e0..d4f2fcf 100644
--- a/sys.h
+++ b/sys.h
@@ -3,20 +3,6 @@
  *
  * Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/tcpdump.c b/tcpdump.c
index 1a6df10..8106a64 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -3,20 +3,6 @@
  *
  * Andreas Langer <an.langer@gmx.de>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/tcpdump.h b/tcpdump.h
index 76a41f1..6e9ae01 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -3,20 +3,6 @@
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/throughputmeter.c b/throughputmeter.c
index 5f68a8a..f9d98cf 100644
--- a/throughputmeter.c
+++ b/throughputmeter.c
@@ -3,20 +3,6 @@
  *
  * Antonio Quartulli <a@unstable.cc>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/traceroute.c b/traceroute.c
index 53fa1ae..522d1c9 100644
--- a/traceroute.c
+++ b/traceroute.c
@@ -3,20 +3,6 @@
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/transglobal.c b/transglobal.c
index ba25be4..4de441c 100644
--- a/transglobal.c
+++ b/transglobal.c
@@ -4,20 +4,6 @@
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/translate.c b/translate.c
index 176acc4..a59fc14 100644
--- a/translate.c
+++ b/translate.c
@@ -3,20 +3,6 @@
  *
  * Andreas Langer <an.langer@gmx.de>, Marek Lindner <mareklindner@neomailbox.ch>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
diff --git a/translocal.c b/translocal.c
index 838b90b..f309af5 100644
--- a/translocal.c
+++ b/translocal.c
@@ -4,20 +4,6 @@
  * Andrew Lunn <andrew@lunn.ch>
  * Sven Eckelmann <sven@narfation.org>
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA
- *
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
-- 
2.20.1

