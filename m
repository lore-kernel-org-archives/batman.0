Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed,  9 Dec 2009 21:09:30 +0100
Message-Id: <1260389373-1071-8-git-send-email-andrew@lunn.ch>
In-Reply-To: <1260389373-1071-7-git-send-email-andrew@lunn.ch>
References: <1260389373-1071-1-git-send-email-andrew@lunn.ch>
	<1260389373-1071-2-git-send-email-andrew@lunn.ch>
	<1260389373-1071-3-git-send-email-andrew@lunn.ch>
	<1260389373-1071-4-git-send-email-andrew@lunn.ch>
	<1260389373-1071-5-git-send-email-andrew@lunn.ch>
	<1260389373-1071-6-git-send-email-andrew@lunn.ch>
	<1260389373-1071-7-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 07/10] staging:batman-adv:Updating orig_str
	for debug
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: gregkh@suse.de
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.net

From: marek <marek@45894c77-fb22-0410-b583-ff6e7d5dbf6c>

In commit 1488 the orig_str has been removed from
purge_orig_neighbours(). Apparently, this breaks compilation when
enabling debug-flags, as bat_dbg() is expecting this variable as a
parameter. Actually, this variable has never been initialised also
before commit 1488 (which was probably the reason for mistakenly
removing it).
This tiny patch adds the orig_str again, but initialises it now as
well.

Signed-off-by: Linus Luessing <linus.luessing@web.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
git-svn-id: http://downloads.open-mesh.net/svn/batman/trunk/batman-adv-kernelland@1490 45894c77-fb22-0410-b583-ff6e7d5dbf6c
---
 originator.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/originator.c b/originator.c
index d0640a7..9962af7 100644
--- a/originator.c
+++ b/originator.c
@@ -163,7 +163,7 @@ static bool purge_orig_neigbours(struct orig_node *orig_node,
 				 struct neigh_node **best_neigh_node)
 {
 	struct list_head *list_pos, *list_pos_tmp;
-	char neigh_str[ETH_STR_LEN];
+	char neigh_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
 	struct neigh_node *neigh_node;
 	bool neigh_purged = false;
 
@@ -179,6 +179,7 @@ static bool purge_orig_neigbours(struct orig_node *orig_node,
 				((PURGE_TIMEOUT * HZ) / 1000)))) {
 
 			addr_to_string(neigh_str, neigh_node->addr);
+			addr_to_string(orig_str, orig_node->orig);
 			bat_dbg(DBG_BATMAN, "Neighbour timeout: originator %s, neighbour: %s, last_valid %lu\n", orig_str, neigh_str, (neigh_node->last_valid / HZ));
 
 			neigh_purged = true;
-- 
1.6.5.4

