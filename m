Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Apr 2011 21:30:18 +0200
Message-Id: <1303068618-27928-9-git-send-email-sven@narfation.org>
In-Reply-To: <1303068618-27928-1-git-send-email-sven@narfation.org>
References: <1303068618-27928-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] =?utf-8?q?=5BPATCH_8/8=5D_batman-adv=3A_Set_the_tx?=
	=?utf-8?q?queuelen_to_zero_when_creating_soft_interface?=
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

From: Andrew Lunn <andrew@lunn.ch>

Like other virtual interfaces, e.g. br0, we don't need a transmit
queue. Packets should only be queued on real interfaces which are
underneath. In practice this patch makes little difference since the
virtual interfaces can accept packets as fast as they come, but the
patch will avoid bufferbloat questions to the mailling lists in the
future.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/soft-interface.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index a60fd48..1f6f756 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -584,6 +584,7 @@ static void interface_setup(struct net_device *dev)
 	dev->hard_start_xmit = interface_tx;
 #endif
 	dev->destructor = free_netdev;
+	dev->tx_queue_len = 0;
 
 	/**
 	 * can't call min_mtu, because the needed variables
-- 
1.7.4.4

