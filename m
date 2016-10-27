Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 27 Oct 2016 21:01:38 +0200
Message-Id: <20161027190150.7880-6-sw@simonwunderlich.de>
In-Reply-To: <20161027190150.7880-1-sw@simonwunderlich.de>
References: <20161027190150.7880-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 05/17] batman-adv: Document new nc,
	mcast and tpmeter log levels
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
 Documentation/networking/batman-adv.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/batman-adv.txt b/Documentation/networking/batman-adv.txt
index a918131..ccf9467 100644
--- a/Documentation/networking/batman-adv.txt
+++ b/Documentation/networking/batman-adv.txt
@@ -161,13 +161,16 @@ file in debugfs
 The additional debug output is by default disabled. It can be en-
 abled  during run time. Following log_levels are defined:
 
-0 - All  debug  output  disabled
-1 - Enable messages related to routing / flooding / broadcasting
-2 - Enable messages related to route added / changed / deleted
-4 - Enable messages related to translation table operations
-8 - Enable messages related to bridge loop avoidance
-16 - Enable messaged related to DAT, ARP snooping and parsing
-31 - Enable all messages
+  0 - All  debug  output  disabled
+  1 - Enable messages related to routing / flooding / broadcasting
+  2 - Enable messages related to route added / changed / deleted
+  4 - Enable messages related to translation table operations
+  8 - Enable messages related to bridge loop avoidance
+ 16 - Enable messages related to DAT, ARP snooping and parsing
+ 32 - Enable messages related to network coding
+ 64 - Enable messages related to multicast
+128 - Enable messages related to throughput meter
+255 - Enable all messages
 
 The debug output can be changed at runtime  using  the  file
 /sys/class/net/bat0/mesh/log_level. e.g.
-- 
2.10.1

