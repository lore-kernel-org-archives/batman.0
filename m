Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 Oct 2017 14:21:22 +0200
Message-Id: <20171007122122.6470-1-sven@narfation.org>
In-Reply-To: <20171007121853.6278-1-sven@narfation.org>
References: <20171007121853.6278-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Add missing kerneldoc for
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, Sven Eckelmann <sven@narfation.org>, David Ahern <dsahern@gmail.com>

The parameter extack was added to batadv_softif_slave_add without adding
the kernel-doc for it. This caused kernel-doc warnings.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Cc: David Ahern <dsahern@gmail.com>
---
 net/batman-adv/soft-interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 543d2c3e..9f673cdf 100644
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

