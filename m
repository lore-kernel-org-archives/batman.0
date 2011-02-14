Return-Path: <jj@chaosbits.net>
Date: Mon, 14 Feb 2011 23:38:18 +0100 (CET)
From: Jesper Juhl <jj@chaosbits.net>
Message-ID: <alpine.LNX.2.00.1102142335331.4530@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [B.A.T.M.A.N.] [PATCH][trivial] Batman: Remove two duplicate
	includes.
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
Cc: trivial@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>, "David S. Miller" <davem@davemloft.net>

Remove duplicate inclusion of "send.h" and "routing.h" from net/batman-adv/soft-interface.c

Patch is against linux-next as of today.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 soft-interface.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index bd088f8..7e37077 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -29,14 +29,12 @@
 #include "hash.h"
 #include "gateway_common.h"
 #include "gateway_client.h"
-#include "send.h"
 #include "bat_sysfs.h"
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/etherdevice.h>
 #include <linux/if_vlan.h>
 #include "unicast.h"
-#include "routing.h"
 
 
 static int bat_get_settings(struct net_device *dev, struct ethtool_cmd *cmd);


-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Plain text mails only, please.
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html

