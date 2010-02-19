Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 19 Feb 2010 16:18:07 +0100
Message-Id: <1266592691-13090-4-git-send-email-andrew@lunn.ch>
In-Reply-To: <1266592691-13090-3-git-send-email-andrew@lunn.ch>
References: <1266592691-13090-1-git-send-email-andrew@lunn.ch>
	<1266592691-13090-2-git-send-email-andrew@lunn.ch>
	<1266592691-13090-3-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 4/8] Staging: batman-adv: remove obsolete
	variables
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
To: gregkh@suse.de
Cc: devel@linuxdriverproject.org, b.a.t.m.a.n@lists.open-mesh.net, Marek Lindner <lindner_marek@yahoo.de>

From: Marek Lindner <lindner_marek@yahoo.de>

This patch removes a variable that became obsolete since the skb handling
replaced the packet handling thread.

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/routing.c |    2 --
 drivers/staging/batman-adv/routing.h |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/batman-adv/routing.c b/drivers/staging/batman-adv/routing.c
index 8abaa61..7dc9aef 100644
--- a/drivers/staging/batman-adv/routing.c
+++ b/drivers/staging/batman-adv/routing.c
@@ -35,8 +35,6 @@
 
 DECLARE_WAIT_QUEUE_HEAD(thread_wait);
 
-atomic_t exit_cond;
-
 void slide_own_bcast_window(struct batman_if *batman_if)
 {
 	HASHIT(hashit);
diff --git a/drivers/staging/batman-adv/routing.h b/drivers/staging/batman-adv/routing.h
index c217241..939b8d4 100644
--- a/drivers/staging/batman-adv/routing.h
+++ b/drivers/staging/batman-adv/routing.h
@@ -22,7 +22,6 @@
 #include "types.h"
 
 extern wait_queue_head_t thread_wait;
-extern atomic_t exit_cond;
 
 void slide_own_bcast_window(struct batman_if *batman_if);
 void receive_bat_packet(struct ethhdr *ethhdr,
-- 
1.6.6.2

