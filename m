Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Dec 2017 14:40:42 +0100
Message-Id: <20171201134042.8531-1-sven@narfation.org>
In-Reply-To: <20171119140553.24435-1-sven@narfation.org>
References: <20171119140553.24435-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2 5/6] batctl: Mark remaining files as
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
- Removed CHANGELOG.license README.license
---
 .gitattributes   | 3 +++
 bat-hosts.sample | 3 +++
 man/batctl.8     | 2 ++
 3 files changed, 8 insertions(+)

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
diff --git a/bat-hosts.sample b/bat-hosts.sample
index 6042b35..ba0d776 100644
--- a/bat-hosts.sample
+++ b/bat-hosts.sample
@@ -1 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# License-Filename: LICENSES/preferred/GPL-2.0
+
 0:d2:58:ca:91:e8	example
diff --git a/man/batctl.8 b/man/batctl.8
index 9ee0e31..7cf66ca 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -1,3 +1,5 @@
+.\" SPDX-License-Identifier: GPL-2.0
+.\" License-Filename: LICENSES/preferred/GPL-2.0
 .\"                                      Hey, EMACS: -*- nroff -*-
 .\" First parameter, NAME, should be all caps
 .\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
-- 
2.11.0

