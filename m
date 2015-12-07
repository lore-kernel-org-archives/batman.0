Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon,  7 Dec 2015 23:12:14 +0800
Message-Id: <1449501135-30438-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1449501135-30438-1-git-send-email-antonio@meshcoding.com>
References: <1449501135-30438-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: fix erroneous client entry
	duplicate detection
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Marek Lindner <mareklindner@neomailbox.ch>

The translation table implementation, namely batadv_compare_tt(),
is used to compare two client entries and deciding if they are the
holding the same information. Each client entry is identified by
its mac address and its VLAN id (VID).
Consequently, batadv_compare_tt() has to not only compare the mac
addresses but also the VIDs.

Without this fix adding a new client entry that possesses the same
mac address as another client but operates on a different VID will
fail because both client entries will considered identical.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/translation-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index a3fc9033..76f19ba 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -68,13 +68,15 @@ static void batadv_tt_global_del(struct batadv_priv *bat_priv,
 				 unsigned short vid, const char *message,
 				 bool roaming);
 
-/* returns 1 if they are the same mac addr */
+/* returns 1 if they are the same mac addr and vid */
 static int batadv_compare_tt(const struct hlist_node *node, const void *data2)
 {
 	const void *data1 = container_of(node, struct batadv_tt_common_entry,
 					 hash_entry);
+	const struct batadv_tt_common_entry *tt1 = data1;
+	const struct batadv_tt_common_entry *tt2 = data2;
 
-	return batadv_compare_eth(data1, data2);
+	return (tt1->vid == tt2->vid) && batadv_compare_eth(data1, data2);
 }
 
 /**
-- 
2.6.3

