Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:57 +0100
Message-Id: <20171119140602.24504-2-sven@narfation.org>
In-Reply-To: <20171119140602.24504-1-sven@narfation.org>
References: <20171119140602.24504-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/6] alfred: Rename LICENSE to Linux's
 LICENSES/preferred/GPL-2.0
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

The alfred project shares files with other projects hosted on open-mesh.org
and kernel.org. These other projects use the filename
LICENSES/preferred/GPL-2.0 for the GPL-2.0 license. It is therefore
required to also use the same name for the license file when these files
reference this in their license header.

The SPDX header was imported from Linux but the actual GPL-2.0 text was
downloaded from https://www.gnu.org/licenses/gpl-2.0.txt

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 LICENSE => LICENSES/preferred/GPL-2.0 | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 rename LICENSE => LICENSES/preferred/GPL-2.0 (97%)

diff --git a/LICENSE b/LICENSES/preferred/GPL-2.0
similarity index 97%
rename from LICENSE
rename to LICENSES/preferred/GPL-2.0
index d159169..3bb0d18 100644
--- a/LICENSE
+++ b/LICENSES/preferred/GPL-2.0
@@ -1,3 +1,16 @@
+Valid-License-Identifier: GPL-2.0
+Valid-License-Identifier: GPL-2.0+
+SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
+Usage-Guide:
+  To use this license in source code, put one of the following SPDX
+  tag/value pairs into a comment according to the placement
+  guidelines in the licensing rules documentation.
+  For 'GNU General Public License (GPL) version 2 only' use:
+    SPDX-License-Identifier: GPL-2.0
+  For 'GNU General Public License (GPL) version 2 or any later version' use:
+    SPDX-License-Identifier: GPL-2.0+
+License-Text:
+
                     GNU GENERAL PUBLIC LICENSE
                        Version 2, June 1991
 
-- 
2.11.0

