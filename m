Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  9 Jan 2014 15:53:00 +0100
Message-Id: <1389279182-3256-12-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1389279182-3256-1-git-send-email-antonio@meshcoding.com>
References: <1389279182-3256-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 11/13] batman-adv: extend the ap_isolation
	mechanism
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Change the AP isolation mechanism to not only "isolate" WIFI
clients but also all those marked with the more generic
"isolation flag" (BATADV_TT_CLIENT_ISOLA).

The result is that when AP isolation is on any unicast
packet originated by an "isolated" client and directed to
another "isolated" client is dropped at the source node.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/translation-table.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index eeceb13..a874d08 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1869,6 +1869,11 @@ _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
 	    tt_global_entry->common.flags & BATADV_TT_CLIENT_WIFI)
 		ret = true;
 
+	/* check if the two clients are marked as isolated */
+	if (tt_local_entry->common.flags & BATADV_TT_CLIENT_ISOLA &&
+	    tt_global_entry->common.flags & BATADV_TT_CLIENT_ISOLA)
+		ret = true;
+
 	return ret;
 }
 
-- 
1.8.5.2

