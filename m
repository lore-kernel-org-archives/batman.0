Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 Jul 2016 21:30:21 +0200
Message-Id: <1468697424-10701-2-git-send-email-sven@narfation.org>
In-Reply-To: <1468697424-10701-1-git-send-email-sven@narfation.org>
References: <1468697424-10701-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Add B.A.T.M.A.N. V sysfs
	files to README
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Documentation/networking/batman-adv.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index 8a8d3d9..d414e60 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -32,7 +32,7 @@ compatible interfaces. Once found, it will create  subfolders  in
 the /sys directories of each supported interface, e.g.
 
 # ls /sys/class/net/eth0/batman_adv/
-# iface_status  mesh_iface
+# elp_interval  iface_status  mesh_iface  throughput_override
 
 If an interface does not have the "batman_adv" subfolder it prob-
 ably is not supported. Not supported  interfaces  are:  loopback,
-- 
2.8.1

