Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 23 Aug 2012 15:10:15 +0200
Message-Id: <1345727427-20805-7-git-send-email-ordex@autistici.org>
In-Reply-To: <1345727427-20805-1-git-send-email-ordex@autistici.org>
References: <1345727427-20805-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 06/18] batman-adv: remove a misleading comment
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Jonathan Corbet <corbet@lwn.net>

From: Jonathan Corbet <corbet@lwn.net>

As much as I'm happy to see LWN links sprinkled through the kernel by the
dozen, this one in particular reflects a very old state of reality; the
associated comment is now incorrect.  So just delete it.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/main.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 13c88b2..2a1f243 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -58,9 +58,6 @@ static int __init batadv_init(void)
 
 	batadv_iv_init();
 
-	/* the name should not be longer than 10 chars - see
-	 * http://lwn.net/Articles/23634/
-	 */
 	batadv_event_workqueue = create_singlethread_workqueue("bat_events");
 
 	if (!batadv_event_workqueue)
-- 
1.7.9.4

