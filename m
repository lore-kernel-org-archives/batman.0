Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  7 Mar 2012 00:58:19 +0100
Message-Id: <1331078299-2984-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix PENDING flag behaviour in
	case of multiple roamings
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

In case of multiple romaings always between the same two nodes (going back and
forth from one to the other) within the same originator interval (this is much
more suitable in setups where the orig_interval last longer than one sec), the
flags should not be messed up and should eventually converge to a correct
status. In particular, if we marked a LOCAL client as PENDING due to the
roaming, if the client comes back to us we have to simply reset the PENDING flag
and remove the DEL event from the sending queue. This is possible because the
DEL operation has not been committed and advertised yet.

If we don't do that, the client is deleted and then re-added, this can create
connection problems to the client and would also create useless noise in the
network due to the advertisement overhead.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 9f4d706..4bd9490 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -206,6 +206,15 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 
 	if (tt_local_entry) {
 		tt_local_entry->last_seen = jiffies;
+
+		/* in case of multiple roaming in the same orig interval we
+		 * should correctly handle the client flags: a client which was
+		 * marked as pending can now be unmarked because it came back */
+		if (tt_local_entry->common.flags & TT_CLIENT_PENDING) {
+			tt_local_entry->common.flags &= ~TT_CLIENT_PENDING;
+			goto reinsertion;
+		}
+
 		goto out;
 	}
 
@@ -242,7 +251,7 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 		tt_local_entry_free_ref(tt_local_entry);
 		goto out;
 	}
-
+reinsertion:
 	tt_local_event(bat_priv, addr, tt_local_entry->common.flags);
 
 	/* remove address from global hash if present */
-- 
1.7.3.4

