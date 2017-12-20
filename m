Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 20 Dec 2017 12:01:10 +0100
Message-Id: <20171220110124.13117-6-sw@simonwunderlich.de>
In-Reply-To: <20171220110124.13117-1-sw@simonwunderlich.de>
References: <20171220110124.13117-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 05/19] batman-adv: Add license header to
 Kconfig
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

The last remaining file without license notice and/or SPDX license
identifier under net/batman-adv/ is the Kconfig. It should have been
licensed under the same conditions as the rest of batman-adv and the
Makefile which uses the CONFIG_* variables from Kconfig.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index b73b96a2854b..c44f6515be5e 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -1,3 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2007-2017  B.A.T.M.A.N. contributors:
+#
+# Marek Lindner, Simon Wunderlich
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+
 #
 # B.A.T.M.A.N meshing protocol
 #
-- 
2.11.0

