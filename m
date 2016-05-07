Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun,  8 May 2016 07:25:15 +0800
Message-Id: <1462663515-20691-2-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1462663515-20691-1-git-send-email-mareklindner@neomailbox.ch>
References: <1462663515-20691-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: update elp interval
	documentation
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 Documentation/ABI/testing/sysfs-class-net-batman-adv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-batman-adv b/Documentation/ABI/testing/sysfs-class-net-batman-adv
index ef630a6..24c845e 100644
--- a/Documentation/ABI/testing/sysfs-class-net-batman-adv
+++ b/Documentation/ABI/testing/sysfs-class-net-batman-adv
@@ -4,7 +4,7 @@ Date:           Feb 2014
 Contact:        Linus Lüssing <linus.luessing@web.de>
 Description:
                 Defines the interval in milliseconds in which batman
-                sends its probing packets for link quality measurements.
+                emits probing packets for neighbor sensing (ELP).
 
 What:           /sys/class/net/<iface>/batman-adv/iface_status
 Date:           May 2010
-- 
2.8.0.rc3

