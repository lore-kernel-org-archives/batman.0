Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:06:01 +0100
Message-Id: <20171119140602.24504-6-sven@narfation.org>
In-Reply-To: <20171119140602.24504-1-sven@narfation.org>
References: <20171119140602.24504-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 5/6] alfred: Mark remaining files as GPL-2.0
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
Cc: Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>, Jonathan Haws <jhaws@sdl.usu.edu>, Andrew Lunn <andrew@lunn.ch>, Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>

Some files were not explicitly marked with any license. It is therefore
assumed that these are licensed under the GPL-2.0. Make this unambiguous by
adding this information direct to the file using the SPDX license
identifier. The FSFE REUSE *.license annotation file is used for files
which don't allow comments.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Jonathan Haws <jhaws@sdl.usu.edu>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>

Feel free to request a different license for these files.
---
 .gitattributes         | 3 +++
 CHANGELOG.license      | 2 ++
 README.license         | 2 ++
 gpsd/man/alfred-gpsd.8 | 2 ++
 man/alfred.8           | 2 ++
 vis/man/batadv-vis.8   | 2 ++
 6 files changed, 13 insertions(+)
 create mode 100644 CHANGELOG.license
 create mode 100644 README.license

diff --git a/.gitattributes b/.gitattributes
index eeef3e0..3a9a74f 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,2 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# License-Filename: LICENSES/preferred/GPL-2.0
+
 /.gitignore export-ignore
 /.gitattributes export-ignore
diff --git a/CHANGELOG.license b/CHANGELOG.license
new file mode 100644
index 0000000..a55d70e
--- /dev/null
+++ b/CHANGELOG.license
@@ -0,0 +1,2 @@
+SPDX-License-Identifier: GPL-2.0
+License-Filename: LICENSES/preferred/GPL-2.0
diff --git a/README.license b/README.license
new file mode 100644
index 0000000..a55d70e
--- /dev/null
+++ b/README.license
@@ -0,0 +1,2 @@
+SPDX-License-Identifier: GPL-2.0
+License-Filename: LICENSES/preferred/GPL-2.0
diff --git a/gpsd/man/alfred-gpsd.8 b/gpsd/man/alfred-gpsd.8
index 3799293..87879ee 100644
--- a/gpsd/man/alfred-gpsd.8
+++ b/gpsd/man/alfred-gpsd.8
@@ -1,3 +1,5 @@
+.\" SPDX-License-Identifier: GPL-2.0
+.\" License-Filename: LICENSES/preferred/GPL-2.0
 .\"                                      Hey, EMACS: -*- nroff -*-
 .\" First parameter, NAME, should be all caps
 .\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
diff --git a/man/alfred.8 b/man/alfred.8
index a2c3d4c..7e31e12 100644
--- a/man/alfred.8
+++ b/man/alfred.8
@@ -1,3 +1,5 @@
+.\" SPDX-License-Identifier: GPL-2.0
+.\" License-Filename: LICENSES/preferred/GPL-2.0
 .\"                                      Hey, EMACS: -*- nroff -*-
 .\" First parameter, NAME, should be all caps
 .\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
diff --git a/vis/man/batadv-vis.8 b/vis/man/batadv-vis.8
index 20dead7..94be0e9 100644
--- a/vis/man/batadv-vis.8
+++ b/vis/man/batadv-vis.8
@@ -1,3 +1,5 @@
+.\" SPDX-License-Identifier: GPL-2.0
+.\" License-Filename: LICENSES/preferred/GPL-2.0
 .\"                                      Hey, EMACS: -*- nroff -*-
 .\" First parameter, NAME, should be all caps
 .\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
-- 
2.11.0

