Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 30 Aug 2011 15:38:02 +0200
Message-Id: <1314711482-24862-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1314703953-20190-1-git-send-email-lindner_marek@yahoo.de>
References: <1314703953-20190-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: readme update (mention of new
	log level)
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 This makes the previous patch obsolete.

 README |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 1e000ee..7bbcea1 100644
--- a/README
+++ b/README
@@ -218,15 +218,16 @@ abled  during run time. Following log_levels are defined:
 
 0 - All  debug  output  disabled
 1 - Enable messages related to routing / flooding / broadcasting
-2 - Enable route or tt entry added / changed / deleted
-3 - Enable all messages
+2 - Enable messages related to route added / changed / deleted
+4 - Enable messages related to translation table operations
+7 - Enable all messages
 
 The debug output can be changed at runtime  using  the  file
 /sys/class/net/bat0/mesh/log_level. e.g.
 
 # echo 2 > /sys/class/net/bat0/mesh/log_level
 
-will enable debug messages for when routes or TTs change.
+will enable debug messages for when routes change.
 
 
 BATCTL
-- 
1.7.5.3

