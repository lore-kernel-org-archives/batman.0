Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 12 Jul 2012 22:35:21 +0200
Message-Id: <1342125327-11676-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1342125327-11676-1-git-send-email-ordex@autistici.org>
References: <1342125327-11676-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv8 2/8] batman-adv: Distributed ARP Table -
	add a new debug log level
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

A new log level has been added to concentrate messages regarding DAT: ARP
snooping, requests, response and DHT related messages.
The new log level is named BATADV_DBG_DAT

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 README |    3 ++-
 main.h |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/README b/README
index a173d2a..c1d8204 100644
--- a/README
+++ b/README
@@ -203,7 +203,8 @@ abled  during run time. Following log_levels are defined:
 2 - Enable messages related to route added / changed / deleted
 4 - Enable messages related to translation table operations
 8 - Enable messages related to bridge loop avoidance
-15 - enable all messages
+16 - Enable messaged related to DAT, ARP snooping and parsing
+31 - Enable all messages
 
 The debug output can be changed at runtime  using  the  file
 /sys/class/net/bat0/mesh/log_level. e.g.
diff --git a/main.h b/main.h
index 044b9f8..7e64dbd 100644
--- a/main.h
+++ b/main.h
@@ -130,7 +130,8 @@ enum batadv_dbg_level {
 	BATADV_DBG_ROUTES = 1 << 1, /* route added / changed / deleted */
 	BATADV_DBG_TT	  = 1 << 2, /* translation table operations */
 	BATADV_DBG_BLA    = 1 << 3, /* bridge loop avoidance */
-	BATADV_DBG_ALL    = 15,
+	BATADV_DBG_DAT    = 1 << 4, /* snooped arp messages / dat operations */
+	BATADV_DBG_ALL    = 31,
 };
 
 /* Kernel headers */
-- 
1.7.9.4

