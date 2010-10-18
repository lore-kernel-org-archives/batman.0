Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@ascom.ch>
Date: Mon, 18 Oct 2010 23:44:13 +0200
Message-Id: <1287438253-13064-1-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <201010181211.55541.lindner_marek@yahoo.de>
References: <201010181211.55541.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Adding sysfs ABI documentation
	for hop_penalty
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
 sysfs-class-net-mesh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sysfs-class-net-mesh b/sysfs-class-net-mesh
index 5aa1912..2c03e76 100644
--- a/sysfs-class-net-mesh
+++ b/sysfs-class-net-mesh
@@ -21,6 +21,13 @@ Description:
                 Defines the interval in milliseconds in which batman
                 sends its protocol messages.
 
+What:           /sys/class/net/<mesh_iface>/mesh/hop_penalty
+Date:           Oct 2010
+Contact:        Linus Lüssing <linus.luessing@web.de>
+Description:
+		Defines the penalty which will be applied to an
+		originator message's tq-field on every hop.
+
 What:           /sys/class/net/<mesh_iface>/mesh/vis_mode
 Date:           May 2010
 Contact:        Marek Lindner <lindner_marek@yahoo.de>
-- 
1.7.1

