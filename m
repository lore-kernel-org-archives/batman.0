Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 14 May 2012 09:17:37 +0200
Message-Id: <1336979858-13928-8-git-send-email-ordex@autistici.org>
In-Reply-To: <1336979858-13928-1-git-send-email-ordex@autistici.org>
References: <1336979858-13928-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 7/8] batman-adv: README cleanups
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

- Add routing_algo

- Remove date from README:
The date has to be updated when a patch touches the README. Therefore, nearly
every feature will modify this date. It can happens quite often that not only
one feature is currently in development or waiting on the mailinglist. This
creates merge conflicts when applying a patchset.

The date itself doesn't provide any additional information when this file is
only available in a release tarball or as part of a SCM repository.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 Documentation/networking/batman-adv.txt |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index 220a58c..75a5923 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -1,5 +1,3 @@
-[state: 21-08-2011]
-
 BATMAN-ADV
 ----------
 
@@ -68,10 +66,11 @@ All  mesh  wide  settings  can be found in batman's own interface
 folder:
 
 # ls /sys/class/net/bat0/mesh/
-# aggregated_ogms        fragmentation          hop_penalty
-# ap_isolation           gw_bandwidth           log_level
-# bonding                gw_mode                orig_interval
-# bridge_loop_avoidance  gw_sel_class           vis_mode
+# aggregated_ogms        gw_bandwidth           log_level
+# ap_isolation           gw_mode                orig_interval
+# bonding                gw_sel_class           routing_algo
+# bridge_loop_avoidance  hop_penalty            vis_mode
+# fragmentation
 
 
 There is a special folder for debugging information:
-- 
1.7.9.4

