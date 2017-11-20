Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Nov 2017 22:02:28 +0100
Message-Id: <20171120210229.9069-2-sven@narfation.org>
In-Reply-To: <20171120210229.9069-1-sven@narfation.org>
References: <20171120210229.9069-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Convert CHANGELOG to
 reStructuredText
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

The current format of the file is not well defined. The reStructuredText
format (as used by other batman-adv related files) has the benefit that it
is similar easy to read and write. And it allows other tools to parse the
content of the file and convert it in a sensible way to a different file
format.

Multiple git repository web-based management software also can directly
render these files as properly formatted HTML output.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 CHANGELOG         | 56 ---------------------------------------------------
 CHANGELOG.license |  2 --
 CHANGELOG.rst     | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 58 deletions(-)
 delete mode 100644 CHANGELOG
 delete mode 100644 CHANGELOG.license
 create mode 100644 CHANGELOG.rst

diff --git a/CHANGELOG b/CHANGELOG
deleted file mode 100644
index af9b676..0000000
--- a/CHANGELOG
+++ /dev/null
@@ -1,56 +0,0 @@
-batctl 2017.3
-
- * bugs squashed:
-   - Fix error messages on traceroute send failures
-
- -- Thu, 28 Sep 2017 13:43:18 +0200
-
-batctl 2017.2
-
- * coding style cleanups and refactoring
-
- -- Fri, 28 Jul 2017 13:42:03 +0200
-
-batctl 2017.1
-
- * (no changes)
-
- -- Tue, 23 May 2017 11:40:21 +0200
-
-batctl 2017.0
-
- * remove root check for read-only sysfs and rtnl functionality
- * coding style cleanups
- * bugs squashed:
-   - fix check for root priviliges when started under modified effective uid
-
- -- Tue, 28 Feb 2017 17:22:49 +0100
-
-batctl 2016.5
-
- * reimplement traceroute/ping commands in userspace without debugfs
- * switch interface manipulation from (legacy) sysfs to rtnetlink
- * coding style cleanups
-
- -- Thu, 15 Dec 2016 18:11:55 +0100
-
-batctl 2016.4:
-
- * integrate support for batman-adv netlink
- * coding style cleanups
- * documentation updates
- * bugs squashed:
-   - fix endless loop in TP meter on some platforms
-   - fix build errors caused by name conflicts
-
- -- Thu, 27 Oct 2016 21:19:38 +0200
-
-batctl 2016.3
-
- * synchronize common headers with batman-adv
- * support multicast logging and debug table
- * split tcpdump OGM packet filter in OGM and OGMv2 filter
- * add infrastructure to communicate with batadv netlink family
- * integrate command to control new kernel throughput meter
-
- -- Thu, 01 Sep 2016 16:18:35 +0200
diff --git a/CHANGELOG.license b/CHANGELOG.license
deleted file mode 100644
index a55d70e..0000000
--- a/CHANGELOG.license
+++ /dev/null
@@ -1,2 +0,0 @@
-SPDX-License-Identifier: GPL-2.0
-License-Filename: LICENSES/preferred/GPL-2.0
diff --git a/CHANGELOG.rst b/CHANGELOG.rst
new file mode 100644
index 0000000..9083816
--- /dev/null
+++ b/CHANGELOG.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+2017.3 (2017-09-28)
+===================
+
+* bugs squashed:
+
+  - Fix error messages on traceroute send failures
+
+
+2017.2 (2017-06-28)
+===================
+
+* coding style cleanups and refactoring
+
+
+2017.1 (2017-05-23)
+====================
+
+* (no changes)
+
+
+2017.0 (2017-02-28)
+===================
+
+* remove root check for read-only sysfs and rtnl functionality
+* coding style cleanups
+* bugs squashed:
+
+  - fix check for root priviliges when started under modified effective uid
+
+
+2016.5 (2016-12-15)
+===================
+
+* reimplement traceroute/ping commands in userspace without debugfs
+* switch interface manipulation from (legacy) sysfs to rtnetlink
+* coding style cleanups
+
+
+2016.4 (2016-10-27)
+===================
+
+* integrate support for batman-adv netlink
+* coding style cleanups
+* documentation updates
+* bugs squashed:
+
+  - fix endless loop in TP meter on some platforms
+  - fix build errors caused by name conflicts
+
+
+2016.3 (2016-09-01)
+===================
+
+* synchronize common headers with batman-adv
+* support multicast logging and debug table
+* split tcpdump OGM packet filter in OGM and OGMv2 filter
+* add infrastructure to communicate with batadv netlink family
+* integrate command to control new kernel throughput meter
-- 
2.11.0

