Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 16 May 2010 15:02:12 +0200
Message-Id: <1274014932-2792-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1273868969293@kroah.org>
References: <1273868969293@kroah.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove all rcu head
	initializations
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

From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Remove all rcu head inits. We don't care about the RCU head state before
passing it to call_rcu() anyway. Only leave the "on_stack" variants so
debugobjects can keep track of objects on stack.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Cc: Marek Lindner <lindner_marek@yahoo.de>
Cc: Sven Eckelmann <sven.eckelmann@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
I've tried to check if the initialisation was always done in call_rcu in all
implementations since 2.6.21. This assumption seems to be correct. I've
already applied it to the maint branch and it must only be applied to the
trunk.

 hard-interface.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index c17ad85..bc2bd12 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -341,7 +341,6 @@ static struct batman_if *hardif_add_interface(struct net_device *net_dev)
 	batman_if->if_num = -1;
 	batman_if->net_dev = net_dev;
 	batman_if->if_status = IF_NOT_IN_USE;
-	INIT_RCU_HEAD(&batman_if->rcu);
 	INIT_LIST_HEAD(&batman_if->list);
 
 	check_known_mac_addr(batman_if->net_dev->dev_addr);
-- 
1.7.1

