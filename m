Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Dec 2017 14:39:21 +0100
Message-Id: <20171201133921.8414-1-sven@narfation.org>
In-Reply-To: <20171119140517.24329-8-sven@narfation.org>
References: <20171119140517.24329-8-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 7/9] batman-adv: Mark remaining files as
 GPL-2.0
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

Some files were not explicitly marked with any license. It is therefore
assumed that these are licensed under the GPL-2.0. Make this unambiguous by
adding this information direct to the file using the SPDX license
identifier. The FSFE REUSE *.license annotation file is used for files
which don't allow comments.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
- removed CHANGELOG.license README.external.license
---
 .gitattributes      | 3 +++
 MAINTAINERS.license | 2 ++
 2 files changed, 5 insertions(+)
 create mode 100644 MAINTAINERS.license

diff --git a/.gitattributes b/.gitattributes
index 1d2a7e9..402ecae 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,3 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+# License-Filename: LICENSES/preferred/GPL-2.0
+
 /.gitignore export-ignore
 /.gitattributes export-ignore
 *.c   diff=cpp
diff --git a/MAINTAINERS.license b/MAINTAINERS.license
new file mode 100644
index 0000000..a55d70e
--- /dev/null
+++ b/MAINTAINERS.license
@@ -0,0 +1,2 @@
+SPDX-License-Identifier: GPL-2.0
+License-Filename: LICENSES/preferred/GPL-2.0
-- 
2.11.0

