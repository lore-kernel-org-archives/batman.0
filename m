Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 14 May 2012 09:17:38 +0200
Message-Id: <1336979858-13928-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1336979858-13928-1-git-send-email-ordex@autistici.org>
References: <1336979858-13928-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 8/8] batman-adv: unset the TT_CLIENT_PENDING
	flag if the new local entry already exists
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

When trying to add a new tt_local_entry, if such entry already exists, we have
to ensure that the TT_CLIENT_PENDING flag is not set, otherwise the entry will
be deleted soon.

Reported-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/translation-table.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b3fb597..a66c2dc 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -206,6 +206,8 @@ void tt_local_add(struct net_device *soft_iface, const uint8_t *addr,
 
 	if (tt_local_entry) {
 		tt_local_entry->last_seen = jiffies;
+		/* possibly unset the TT_CLIENT_PENDING flag */
+		tt_local_entry->common.flags &= ~TT_CLIENT_PENDING;
 		goto out;
 	}
 
-- 
1.7.9.4

