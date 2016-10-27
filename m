Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 27 Oct 2016 21:01:37 +0200
Message-Id: <20161027190150.7880-5-sw@simonwunderlich.de>
In-Reply-To: <20161027190150.7880-1-sw@simonwunderlich.de>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 04/17] batman-adv: Add dat, mcast,
	nc and neighbor debugfs files to README
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 Documentation/networking/batman-adv.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index 8afa991..a918131 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -80,9 +80,10 @@ folder:
 There is a special folder for debugging information:
 
 # ls /sys/kernel/debug/batman_adv/bat0/
-# bla_backbone_table  log                 transtable_global
-# bla_claim_table     originators         transtable_local
-# gateways            socket
+# bla_backbone_table  log          neighbors          transtable_local
+# bla_claim_table     mcast_flags  originators
+# dat_cache           nc           socket
+# gateways            nc_nodes     transtable_global
 
 Some of the files contain all sort of status information  regard-
 ing  the  mesh  network.  For  example, you can view the table of
-- 
2.10.1

