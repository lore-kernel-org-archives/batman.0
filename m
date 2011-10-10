Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 10 Oct 2011 14:19:48 +0200
Message-Id: <1318249188-14954-1-git-send-email-ordex@autistici.org>
In-Reply-To: <20111010120849.GA10057@ritirata.org>
References: <20111010120849.GA10057@ritirata.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix tt_local_reset_flags()
	function
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

tt_local_num has to be increased only the when flag passed as argument is reset

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

This patch should fix the aforementioned bug. Please the testers to give it a
try :-) We are waiting for feedbacks!

 translation-table.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 7de9960..8451ecd 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -1723,6 +1723,8 @@ static void tt_local_reset_flags(struct bat_priv *bat_priv, uint16_t flags)
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_local_entry, node,
 					 head, hash_entry) {
+			if (!(tt_local_entry->flags & flags))
+				continue;
 			tt_local_entry->flags &= ~flags;
 			atomic_inc(&bat_priv->num_local_tt);
 		}
-- 
1.7.3.4

