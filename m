Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:52 +0100
Message-Id: <20171119140553.24435-6-sven@narfation.org>
In-Reply-To: <20171119140553.24435-1-sven@narfation.org>
References: <20171119140553.24435-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 5/6] batctl: Mark remaining files as GPL-2.0
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
Cc: Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, Marek Lindner <mareklindner@neomailbox.ch>, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Andrew Lunn <andrew@lunn.ch>, Antonio Quartulli <a@unstable.cc>

Some files were not explicitly marked with any license. It is therefore
assumed that these are licensed under the GPL-2.0. Make this unambiguous by
adding this information direct to the file using the SPDX license
identifier. The FSFE REUSE *.license annotation file is used for files
which don't allow comments.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Martin Hundebøll <martin@hundeboll.net>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Linus Lüssing <linus.luessing@c0d3.blue>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Antonio Quartulli <a@unstable.cc>

Feel free to request a different license for these files.
---
 .gitattributes    | 3 +++
 CHANGELOG.license | 2 ++
 README.license    | 2 ++
 bat-hosts.sample  | 3 +++
 man/batctl.8      | 2 ++
 5 files changed, 12 insertions(+)
 create mode 100644 CHANGELOG.license
 create mode 100644 README.license

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

