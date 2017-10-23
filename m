Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 Oct 2017 17:37:02 +0200
Message-Id: <20171023153704.32120-2-sw@simonwunderlich.de>
In-Reply-To: <20171023153704.32120-1-sw@simonwunderlich.de>
References: <20171023153704.32120-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Add missing kerneldoc for
 extack
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The parameter extack was added to batadv_softif_slave_add without adding
the kernel-doc for it. This caused kernel-doc warnings.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/soft-interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 543d2c3e0f0d..9f673cdfecf8 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -863,6 +863,7 @@ static int batadv_softif_init_late(struct net_device *dev)
  * batadv_softif_slave_add - Add a slave interface to a batadv_soft_interface
  * @dev: batadv_soft_interface used as master interface
  * @slave_dev: net_device which should become the slave interface
+ * @extack: extended ACK report struct
  *
  * Return: 0 if successful or error otherwise.
  */
-- 
2.11.0

