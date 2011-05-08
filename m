Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  8 May 2011 17:24:37 +0200
Message-Id: <1304868284-9364-2-git-send-email-sven@narfation.org>
In-Reply-To: <1304868284-9364-1-git-send-email-sven@narfation.org>
References: <1304868284-9364-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/8] batman-adv: remove misplaced comment
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ef4a9be..51af91b 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -19,8 +19,6 @@
  *
  */
 
-/* increase the reference counter for this originator */
-
 #include "main.h"
 #include "originator.h"
 #include "hash.h"
-- 
1.7.5.1

