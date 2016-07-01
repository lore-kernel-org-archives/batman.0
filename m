Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  1 Jul 2016 15:08:56 +0200
Message-Id: <1467378549-9646-5-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
References: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 04/17] batman-adv: document sysfs files in
	alphabetical order
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

From: Marek Lindner <mareklindner@neomailbox.ch>

Also update obsolete email address.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 Documentation/ABI/testing/sysfs-class-net-batman-adv | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-batman-adv b/Documentation/ABI/testing/sysfs-class-net-batman-adv
index 518f6a1..77d3083 100644
--- a/Documentation/ABI/testing/sysfs-class-net-batman-adv
+++ b/Documentation/ABI/testing/sysfs-class-net-batman-adv
@@ -1,13 +1,4 @@
 
-What:		/sys/class/net/<iface>/batman-adv/throughput_override
-Date:		Feb 2014
-Contact:	Antonio Quartulli <antonio@meshcoding.com>
-description:
-		Defines the throughput value to be used by B.A.T.M.A.N. V
-		when estimating the link throughput using this interface.
-		If the value is set to 0 then batman-adv will try to
-		estimate the throughput by itself.
-
 What:           /sys/class/net/<iface>/batman-adv/elp_interval
 Date:           Feb 2014
 Contact:        Linus Lüssing <linus.luessing@web.de>
@@ -28,3 +19,12 @@ Description:
                 The /sys/class/net/<iface>/batman-adv/mesh_iface file
                 displays the batman mesh interface this <iface>
                 currently is associated with.
+
+What:           /sys/class/net/<iface>/batman-adv/throughput_override
+Date:           Feb 2014
+Contact:        Antonio Quartulli <a@unstable.cc>
+description:
+                Defines the throughput value to be used by B.A.T.M.A.N. V
+                when estimating the link throughput using this interface.
+                If the value is set to 0 then batman-adv will try to
+                estimate the throughput by itself.
-- 
2.8.1

