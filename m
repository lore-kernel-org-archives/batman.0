Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 22:19:20 +0800
Message-Id: <1424269160-29866-1-git-send-email-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: checkpatch - spaces preferred
	around that '*'
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 main.h           | 2 +-
 network-coding.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/main.h b/main.h
index 515bf5a..b6c9ece 100644
--- a/main.h
+++ b/main.h
@@ -44,7 +44,7 @@
 #define BATADV_TT_CLIENT_TEMP_TIMEOUT 600000 /* in milliseconds */
 #define BATADV_TT_WORK_PERIOD 5000 /* 5 seconds */
 #define BATADV_ORIG_WORK_PERIOD 1000 /* 1 second */
-#define BATADV_DAT_ENTRY_TIMEOUT (5*60000) /* 5 mins in milliseconds */
+#define BATADV_DAT_ENTRY_TIMEOUT (5 * 60000) /* 5 mins in milliseconds */
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size)
  */
diff --git a/network-coding.c b/network-coding.c
index 127cc4d..ec6d6e5 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -275,7 +275,7 @@ static bool batadv_nc_to_purge_nc_path_decoding(struct batadv_priv *bat_priv,
 	 * max_buffer time
 	 */
 	return batadv_has_timed_out(nc_path->last_valid,
-				    bat_priv->nc.max_buffer_time*10);
+				    bat_priv->nc.max_buffer_time * 10);
 }
 
 /**
-- 
2.1.4

