Return-Path: <andrew@lunn.ch>
Date: Wed, 23 Mar 2011 13:15:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110323121503.GK6239@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] [batman-adv] Set the txqueuelen to zero when
 creating soft interface.
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

From e03cb760a296b55138dd6507b5e676c22cecf37e Mon Sep 17 00:00:00 2001
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 21 Mar 2011 21:31:44 +0100
Subject: [PATCH] [batman-adv] Set the txqueuelen to zero when creating soft interface.

Like other virtual interfaces, e.g. br0, we don't need a transmit
queue. Packets should only be queued on real interfaces which are
underneath. In practice this patch makes little difference since the
virtual interfaces can accept packets as fast as they come, but the
patch will avoid bufferbloat questions to the mailling lists in the
future.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Linus Luesing <linus.luessing@web.de>
---
 soft-interface.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 9ed2614..7230e33 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -524,6 +524,7 @@ static void interface_setup(struct net_device *dev)
 	dev->hard_start_xmit = interface_tx;
 #endif
 	dev->destructor = free_netdev;
+	dev->tx_queue_len = 0;
 
 	/**
 	 * can't call min_mtu, because the needed variables
-- 
1.7.4.1

