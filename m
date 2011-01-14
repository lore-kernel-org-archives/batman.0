Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Fri, 14 Jan 2011 01:59:54 +0100
Message-Id: <1294966794-17780-12-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1294966794-17780-1-git-send-email-linus.luessing@ascom.ch>
References: <1294966794-17780-1-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH 11/11] batman-adv: Adding sysfs ABI
	documentation for ndp_interval
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>

Signed-off-by: Linus Lüssing <linus.luessing@ascom.ch>
---
 sysfs-class-net-batman-adv |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/batman-adv/sysfs-class-net-batman-adv b/batman-adv/sysfs-class-net-batman-adv
index 38dd762..585e43a 100644
--- a/batman-adv/sysfs-class-net-batman-adv
+++ b/batman-adv/sysfs-class-net-batman-adv
@@ -12,3 +12,10 @@ Date:           May 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
 Description:
                 Indicates the status of <iface> as it is seen by batman.
+
+What:           /sys/class/net/<mesh_iface>/batman-adv/ndp_interval
+Date:           Jan 2011
+Contact:        Linus Lüssing <linus.luessing@web.de>
+Description:
+                Defines the interval in milliseconds in which batman
+                sends its probing packets for link quality measurements.
-- 
1.7.1

