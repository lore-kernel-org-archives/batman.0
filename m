Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 16 Jan 2012 00:36:58 +0100
Message-Id: <1326670618-3950-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: unset the TT_CLIENT_PENDING flag
	if the new local entry already exists
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

When trying to add a new tt_local_entry, if such entry already exists, we have
to ensure that the TT_CLIENT_PENDING flag is not set, otherwise the entry will
be deleted soon.

Reported-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 translation-table.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 27753a0..65de6b7 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -188,6 +188,8 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 
 	if (tt_local_entry) {
 		tt_local_entry->last_seen = jiffies;
+		/* possibly unset the TT_CLIENT_PENDING flag */
+		tt_local_entry->common.flags &= ~TT_CLIENT_PENDING;
 		goto out;
 	}
 
-- 
1.7.3.4

