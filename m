Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat,  4 Feb 2012 16:52:12 +0100
Message-Id: <1328370732-25571-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batctl: use ETH_ALEN instead of hardcoded
	numeric constants
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

In tcpdump.h the numeric constants 6 is usedinstead of the more portable (and
readable) define ETH_ALEN. This patch substitute any hardcoded value with such
define.

Reported-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 tcpdump.h |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcpdump.h b/tcpdump.h
index 2a2cc0a..96989b4 100644
--- a/tcpdump.h
+++ b/tcpdump.h
@@ -21,6 +21,7 @@
 
 
 #include <netpacket/packet.h>
+#include <net/ethernet.h>
 #include "list-batman.h"
 
 #ifndef ARPHRD_IEEE80211_PRISM
@@ -65,11 +66,11 @@ struct vlanhdr {
 struct ieee80211_hdr {
 	u_int16_t frame_control;
 	u_int16_t duration_id;
-	u_int8_t addr1[6];
-	u_int8_t addr2[6];
-	u_int8_t addr3[6];
+	u_int8_t addr1[ETH_ALEN];
+	u_int8_t addr2[ETH_ALEN];
+	u_int8_t addr3[ETH_ALEN];
 	u_int16_t seq_ctrl;
-	u_int8_t addr4[6];
+	u_int8_t addr4[ETH_ALEN];
 } __attribute__ ((packed));
 
 struct radiotap_header {
-- 
1.7.3.4

