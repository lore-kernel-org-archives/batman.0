Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri,  6 Sep 2013 15:14:41 +0200
Message-Id: <1378473281-692-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH openwrt-feed only] batman-adv: fix metadata
	stripping
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <ordex@autistici.org>

a new optimisation in openwrt is stripping some metadata information, invluding
the module version which is used by batctl to tell the user which version
batman-adv the node is currently running.

Un-define this constant to prevent the metadata from being stripped

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/main.h b/main.h
index 834b1a0..b329e79 100644
--- a/main.h
+++ b/main.h
@@ -20,6 +20,8 @@
 #ifndef _NET_BATMAN_ADV_MAIN_H_
 #define _NET_BATMAN_ADV_MAIN_H_
 
+#undef CONFIG_MODULE_STRIPPED
+
 #define BATADV_DRIVER_AUTHOR "Marek Lindner <lindner_marek@yahoo.de>, " \
 			     "Simon Wunderlich <siwu@hrz.tu-chemnitz.de>"
 #define BATADV_DRIVER_DESC   "B.A.T.M.A.N. advanced"
-- 
1.8.1.5

