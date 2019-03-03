Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Mar 2019 15:52:05 +0100
Message-Id: <20190303145207.19864-3-sven@narfation.org>
In-Reply-To: <20190303145207.19864-1-sven@narfation.org>
References: <20190303145207.19864-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/4] alfred: Drop license boilerplate
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

All files got a SPDX-License-Identifier with commit ea81a05080bd
("alfred: Add SPDX license identifier above copyright header"). All the
required information about the license conditions can be found in
LICENSES/.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile           | 14 --------------
 alfred.h           | 14 --------------
 batadv_query.c     | 14 --------------
 batadv_query.h     | 14 --------------
 batadv_querynl.c   | 14 --------------
 batadv_querynl.h   | 14 --------------
 batman_adv.h       | 18 ------------------
 bitops.h           | 18 +-----------------
 client.c           | 14 --------------
 debugfs.c          | 14 --------------
 debugfs.h          | 14 --------------
 gpsd/Makefile      | 14 --------------
 gpsd/alfred-gpsd.c | 14 --------------
 gpsd/alfred-gpsd.h | 14 --------------
 hash.c             | 14 --------------
 hash.h             | 14 --------------
 list.h             | 14 --------------
 main.c             | 14 --------------
 netlink.c          | 14 --------------
 netlink.h          | 14 --------------
 netsock.c          | 14 --------------
 packet.h           | 18 ------------------
 recv.c             | 14 --------------
 send.c             | 14 --------------
 server.c           | 14 --------------
 unix_sock.c        | 14 --------------
 util.c             | 14 --------------
 vis/Makefile       | 14 --------------
 vis/vis.c          | 14 --------------
 vis/vis.h          | 14 --------------
 30 files changed, 1 insertion(+), 431 deletions(-)

diff --git a/Makefile b/Makefile
index 0a54c1b..8840961 100755
--- a/Makefile
+++ b/Makefile
@@ -4,20 +4,6 @@
 #
 # Copyright (C) 2012-2019  B.A.T.M.A.N. contributors
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
 
 # alfred build
diff --git a/alfred.h b/alfred.h
index 47c6937..072f6b7 100644
--- a/alfred.h
+++ b/alfred.h
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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
 
diff --git a/batadv_query.c b/batadv_query.c
index 7486bf4..fb72e77 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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
 
diff --git a/batadv_query.h b/batadv_query.h
index fd7eb2e..7e93791 100644
--- a/batadv_query.h
+++ b/batadv_query.h
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
 #ifndef _BATADV_QUERY_H
diff --git a/batadv_querynl.c b/batadv_querynl.c
index 20ab8b3..d5e9402 100644
--- a/batadv_querynl.c
+++ b/batadv_querynl.c
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
 
diff --git a/batadv_querynl.h b/batadv_querynl.h
index 565c0e1..e2066c2 100644
--- a/batadv_querynl.h
+++ b/batadv_querynl.h
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
diff --git a/bitops.h b/bitops.h
index c4dc5af..ead4a4f 100644
--- a/bitops.h
+++ b/bitops.h
@@ -4,23 +4,7 @@
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
 
 #ifndef __LINUX_LIKE_BITOPS_H__
diff --git a/client.c b/client.c
index c3bd0cb..85a05ce 100644
--- a/client.c
+++ b/client.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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
 
diff --git a/gpsd/Makefile b/gpsd/Makefile
index 33129c1..81bf254 100755
--- a/gpsd/Makefile
+++ b/gpsd/Makefile
@@ -4,20 +4,6 @@
 #
 # Copyright (C) 2013-2019  B.A.T.M.A.N. contributors
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
 
 # alfred-gpsd build
diff --git a/gpsd/alfred-gpsd.c b/gpsd/alfred-gpsd.c
index 1db9ff9..6e9137c 100644
--- a/gpsd/alfred-gpsd.c
+++ b/gpsd/alfred-gpsd.c
@@ -3,20 +3,6 @@
  *
  * Andrew Lunn, Simon Wunderlich
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
 
diff --git a/gpsd/alfred-gpsd.h b/gpsd/alfred-gpsd.h
index 83c16b0..1abde35 100644
--- a/gpsd/alfred-gpsd.h
+++ b/gpsd/alfred-gpsd.h
@@ -3,20 +3,6 @@
  *
  * Andrew Lunn, Simon Wunderlich
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
index 778a7f4..02ac15e 100644
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
index d3fedb1..f5a8fb5 100644
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
diff --git a/list.h b/list.h
index f6c0cae..0fa634f 100644
--- a/list.h
+++ b/list.h
@@ -3,20 +3,6 @@
  *
  * Linus Torvalds, ...
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
index 6378c49..f633462 100644
--- a/main.c
+++ b/main.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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
index ffc29f2..eac8245 100644
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
index fcea003..26ad1e8 100644
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
 
diff --git a/netsock.c b/netsock.c
index 927e5cc..fcbc20b 100644
--- a/netsock.c
+++ b/netsock.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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
 
diff --git a/packet.h b/packet.h
index e2112e4..564afad 100644
--- a/packet.h
+++ b/packet.h
@@ -3,24 +3,6 @@
  *
  * Simon Wunderlich, Sven Eckelmann
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
- *
  * License-Filename: LICENSES/preferred/MIT
  */
 
diff --git a/recv.c b/recv.c
index a2e0602..e7c2c24 100644
--- a/recv.c
+++ b/recv.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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
 
diff --git a/send.c b/send.c
index f7f37d8..d4043bc 100644
--- a/send.c
+++ b/send.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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
 
diff --git a/server.c b/server.c
index 4cbbc7b..18109cc 100644
--- a/server.c
+++ b/server.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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
 
diff --git a/unix_sock.c b/unix_sock.c
index 25348e8..1d17cee 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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
 
diff --git a/util.c b/util.c
index ed7407b..e14350e 100644
--- a/util.c
+++ b/util.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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
 
diff --git a/vis/Makefile b/vis/Makefile
index 50e6112..53d1f44 100755
--- a/vis/Makefile
+++ b/vis/Makefile
@@ -4,20 +4,6 @@
 #
 # Copyright (C) 2013-2019  B.A.T.M.A.N. contributors
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
 
 # batadv-vis build
diff --git a/vis/vis.c b/vis/vis.c
index 3953475..beaeca1 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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
 
diff --git a/vis/vis.h b/vis/vis.h
index f0d568d..49d5ec8 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -3,20 +3,6 @@
  *
  * Simon Wunderlich
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

