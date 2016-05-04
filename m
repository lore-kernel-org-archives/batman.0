Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Wed,  4 May 2016 21:06:29 +0200
Message-Id: <1462388793-8365-1-git-send-email-sven@open-mesh.com>
In-Reply-To: <4642303.DsCp7UQf8m@bentobox>
References: <4642303.DsCp7UQf8m@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v4 1/5] batman-adv: Add stripped down version
	of MAINTAINERS file
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

From: Sven Eckelmann <sven.eckelmann@open-mesh.com>

The MAINTAINERS file has to modified from time to time when either some
URLs change or some new files are added. These changes can easily be lost
when they actually should be part of a change adding/deleting a file.

Reported-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 MAINTAINERS

diff --git a/MAINTAINERS b/MAINTAINERS
new file mode 100644
index 0000000..7e47274
--- /dev/null
+++ b/MAINTAINERS
@@ -0,0 +1,12 @@
+BATMAN ADVANCED
+M:	Marek Lindner <mareklindner@neomailbox.ch>
+M:	Simon Wunderlich <sw@simonwunderlich.de>
+M:	Antonio Quartulli <a@unstable.cc>
+L:	b.a.t.m.a.n@lists.open-mesh.org (moderated for non-subscribers)
+W:	https://www.open-mesh.org/
+Q:	https://patchwork.open-mesh.org/project/batman/list/
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-class-net-batman-adv
+F:	Documentation/ABI/testing/sysfs-class-net-mesh
+F:	Documentation/networking/batman-adv.txt
+F:	net/batman-adv/
-- 
2.8.1

