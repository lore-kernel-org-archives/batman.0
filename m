Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Nov 2017 22:02:22 +0100
Message-Id: <20171120210223.9002-2-sven@narfation.org>
In-Reply-To: <20171120210223.9002-1-sven@narfation.org>
References: <20171120210223.9002-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] alfred: Convert CHANGELOG to
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
 CHANGELOG         | 169 ----------------------------------------------------
 CHANGELOG.license |   2 -
 CHANGELOG.rst     | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 171 deletions(-)
 delete mode 100644 CHANGELOG
 delete mode 100644 CHANGELOG.license
 create mode 100644 CHANGELOG.rst

diff --git a/CHANGELOG b/CHANGELOG
deleted file mode 100644
index c7018fb..0000000
--- a/CHANGELOG
+++ /dev/null
@@ -1,169 +0,0 @@
-alfred 2017.3:
-
- * reduction of memory usage when using --update-command
-
- -- Thu, 28 Sep 2017 13:43:18 +0200
-
-alfred 2017.2:
-
- * reduce cpu load when rating multiple master servers
- * coding style cleanups and refactoring
-
- -- Fri, 28 Jul 2017 13:45:50 +0200
-
-alfred 2017.1:
-
- * (no changes)
-
- -- Tue, 23 May 2017 11:40:21 +0200
-
-alfred 2017.0:
-
- * support IPv4 multicast distribution
- * coding style cleanups
-
- -- Tue, 28 Feb 2017 17:22:49 +0100
-
-alfred 2016.5:
-
- * support interface validity checks on systems without debugfs
- * remove debugfs check during batadv-vis startup
- * allow out-of-order txend packets during transmissions
-
- -- Thu, 15 Dec 2016 18:11:55 +0100
-
-alfred 2016.4:
-
- * add expert option to specify sync interval
- * fix various bugs in batadv-vis netlink integration
- * fix build build problems with libnl-tiny
-
- -- Thu, 27 Oct 2016 21:22:32 +0200
-
-alfred 2016.3:
-
- * integrate support for batman-adv netlink
-
- -- Thu, 01 Sep 2016 16:18:35 +0200
-
-alfred 2016.2:
-
- * add support for automatic debugfs mount with enabled 
-   CONFIG_ALFRED_CAPABILITIES
-
- -- Thu, 09 Jun 2016 16:21:19 +0200
-
-alfred 2016.1:
-
- * add support for master servers to receive push_data packets with foreign
-   source addresses
- * various code cleanups
- * bugs squashed:
-   - ignore invalid EUI64 addresses
-
- -- Thu, 21 Apr 2016 14:09:12 +0200
-
-alfred 2016.0:
-
- * various code and documentation cleanups
-
- -- Tue, 19 Jan 2016 16:44:26 +0100
-
-alfred 2015.2:
-
- * mention libcap in the README
- * Fix typos
-
- -- Mon, 23 Nov 2015 20:35:20 +0100
-
-alfred 2015.1:
-
- * add support to run on interfaces with multiple link-local addresses
- * various code cleanups
- * bugs squashed:
-   - reduce of maximum payload size to always fit into UDP datagrams
-
- -- Tue, 04 Aug 2015 14:59:10 +0200
-
-alfred 2015.0:
-
- * add support to call commands after data was updated
- * automatic reduction of process capabilities when not needed anymore
- * allow printing of the data version number in the alfred client mode
- * various code cleanups
- * bugs squashed:
-   - update of the version number when data was updated with different
-     version number
-   - tighten size check on received packet
-
- -- Tue, 28 Apr 2015 20:39:51 +0200
-
-alfred 2014.4.0:
-
- * add support for multiple interfaces per master
- * add support for changing interfaces on the fly
- * changes to support multiple alfred interfaces:
-   - bind alfred to a specific interface
-   - allow configuring the unix socket path
- * enhanced debugging
-
- -- Wed, 31 Dec 2014 00:40:42 +0100
-
-alfred 2014.3.0:
-
- * fix various possible memleak, access errors and strncpy issues
- * handle fcntl return codes
- * fix altitude verification check in gpsd
-
- -- Mon, 21 Jul 2014 16:53:01 +0200
-
-alfred 2014.2.0:
-
- * Handle EPERM errors on every sendto
- * Check for changed interface properties, e.g. recreation or
-   changed MAC- and IPv6 addresses
-
- -- Thu, 15 May 2014 19:41:44 +0200
-
-alfred 2014.1.0:
-
- * don't leak socket fd in batadv-vis
-
- -- Thu, 13 Mar 2014 12:10:26 +0100
-
-alfred 2014.0.0:
-
- * add installation of the alfred-gpsd manpage
- * add -lm to linker flags for libgps in alfred-gpsd
-
- -- Sat, 04 Jan 2014 20:17:07 +0100
-
-alfred 2013.4.0:
-
- * add new json output format for vis
- * add gps location information service for alfred
- * allow network interface to vanish and return without restart
- * allow to switch between master and slave operation without restart
- * renamed vis to batadv-vis to avoid collisions with other vis binaries
- * add manpages
- * various code cleanups
- * bugs squashed:
-
-   * handle failing write() in unix sockets
-   * Fix crash when vis opened empty file
-
- -- Sun, 13 Oct 2013 22:55:43 +0200
-
-alfred 2013.3.0:
-
- * initial release of alfred after beta (synced release cycle with
-   batman-adv)
- * allows to share arbitrary local information over a (mesh) network
- * initial support for vis (previously in-kernel feature of batman-adv
-   to visualize the network) included
- * easy but flexible communication interface to allow data applications
-   of all kinds
- * two-tiered architecture (master and slaves)
- * exchanges data via IPv6 unicast/multicast
-
- -- Sun, 28 Jul 2013 18:56:52 +0200
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
index 0000000..c559f54
--- /dev/null
+++ b/CHANGELOG.rst
@@ -0,0 +1,175 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+2017.3 (2017-09-28)
+===================
+
+* reduction of memory usage when using --update-command
+
+
+2017.2 (2017-07-28)
+===================
+
+* reduce cpu load when rating multiple master servers
+* coding style cleanups and refactoring
+
+
+2017.1 (2017-05-23)
+===================
+
+* (no changes)
+
+
+2017.0 (2017-02-28)
+===================
+
+* support IPv4 multicast distribution
+* coding style cleanups
+
+
+2016.5 (2016-12-15)
+===================
+
+* support interface validity checks on systems without debugfs
+* remove debugfs check during batadv-vis startup
+* allow out-of-order txend packets during transmissions
+
+
+2016.4 2016-10-27)
+===================
+
+* add expert option to specify sync interval
+* fix various bugs in batadv-vis netlink integration
+* fix build build problems with libnl-tiny
+
+
+2016.3 (2016-09-01)
+===================
+
+* integrate support for batman-adv netlink
+
+
+2016.2 (2016-06-09)
+===================
+
+* add support for automatic debugfs mount with enabled
+  CONFIG_ALFRED_CAPABILITIES
+
+
+2016.1 (2016-04-21)
+===================
+
+* add support for master servers to receive push_data packets with foreign
+  source addresses
+* various code cleanups
+* bugs squashed:
+
+  - ignore invalid EUI64 addresses
+
+
+2016.0 (2016-01-19)
+===================
+
+* various code and documentation cleanups
+
+
+2015.2 (2015-11-23)
+===================
+
+* mention libcap in the README
+* Fix typos
+
+
+2015.1 (2015-08-04)
+===================
+
+* add support to run on interfaces with multiple link-local addresses
+* various code cleanups
+* bugs squashed:
+
+  - reduce of maximum payload size to always fit into UDP datagrams
+
+
+2015.0 (2015-04-28)
+===================
+
+* add support to call commands after data was updated
+* automatic reduction of process capabilities when not needed anymore
+* allow printing of the data version number in the alfred client mode
+* various code cleanups
+* bugs squashed:
+
+  - update of the version number when data was updated with different
+    version number
+  - tighten size check on received packet
+
+
+2014.4.0 (2014-12-31)
+=====================
+
+* add support for multiple interfaces per master
+* add support for changing interfaces on the fly
+* changes to support multiple alfred interfaces:
+
+  - bind alfred to a specific interface
+  - allow configuring the unix socket path
+
+* enhanced debugging
+
+
+2014.3.0 (2014-07-21)
+=====================
+
+* fix various possible memleak, access errors and strncpy issues
+* handle fcntl return codes
+* fix altitude verification check in gpsd
+
+
+2014.2.0 (2014-05-15)
+=====================
+
+* Handle EPERM errors on every sendto
+* Check for changed interface properties, e.g. recreation or
+  changed MAC- and IPv6 addresses
+
+
+2014.1.0 (2014-03-13)
+=====================
+
+* don't leak socket fd in batadv-vis
+
+
+2014.0.0 (2014-01-04)
+=====================
+
+* add installation of the alfred-gpsd manpage
+* add -lm to linker flags for libgps in alfred-gpsd
+
+
+2013.4.0 (2013-10-13)
+=====================
+
+* add new json output format for vis
+* add gps location information service for alfred
+* allow network interface to vanish and return without restart
+* allow to switch between master and slave operation without restart
+* renamed vis to batadv-vis to avoid collisions with other vis binaries
+* add manpages
+* various code cleanups
+* bugs squashed:
+
+  - handle failing write() in unix sockets
+  - Fix crash when vis opened empty file
+
+
+2013.3.0 (2013-07-28)
+=====================
+
+* initial release of alfred after beta (synced release cycle with
+  batman-adv)
+* allows to share arbitrary local information over a (mesh) network
+* initial support for vis (previously in-kernel feature of batman-adv
+  to visualize the network) included
+* easy but flexible communication interface to allow data applications
+  of all kinds
+* two-tiered architecture (master and slaves)
+* exchanges data via IPv6 unicast/multicast
-- 
2.11.0

