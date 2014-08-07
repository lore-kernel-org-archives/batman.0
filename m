Return-Path: <sakiwit@gmail.com>
From: Jean Sacren <sakiwit@gmail.com>
Date: Thu,  7 Aug 2014 06:50:46 -0600
Message-Id: <1407415846-10277-4-git-send-email-sakiwit@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH net 2/3] batman: fix duplicate #include of
	multicast.h
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
To: netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

The header multicast.h was included twice, so delete one of them.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
---
 net/batman-adv/multicast.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 96b66fd30f96..ab6bb2af1d45 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -19,9 +19,8 @@
 #include "multicast.h"
 #include "originator.h"
 #include "hard-interface.h"
 #include "translation-table.h"
-#include "multicast.h"
 
 /**
  * batadv_mcast_mla_softif_get - get softif multicast listeners
  * @dev: the device to collect multicast addresses from
