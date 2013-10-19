Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 19 Oct 2013 17:04:14 +0200
Message-Id: <1382195054-1943-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix typ0s in comment and
	kerneldoc
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>

Introduced by 21a57f6e7a3b4455dfe68ee07a7b901d9e7f200b
("batman-adv: make the TT CRC logic VLAN specific")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 5750c88..4add57d 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2181,7 +2181,7 @@ static int batadv_tt_global_valid(const void *entry_ptr,
 }
 
 /**
- * batadv_tt_tvlv_generate - fill the tvlv buff it with the tt entries from the
+ * batadv_tt_tvlv_generate - fill the tvlv buff with the tt entries from the
  *  specified tt hash
  * @bat_priv: the bat priv with all the soft interface information
  * @hash: hash table containing the tt entries
@@ -2359,7 +2359,7 @@ static int batadv_send_tt_request(struct batadv_priv *bat_priv,
 	tvlv_tt_data->num_vlan = htons(num_vlan);
 
 	/* send all the CRCs within the request. This is needed by intermediate
-	 * node to ensure they have the correct table before replying
+	 * nodes to ensure they have the correct table before replying
 	 */
 	tt_vlan_req = (struct batadv_tvlv_tt_vlan_data *)(tvlv_tt_data + 1);
 	for (i = 0; i < num_vlan; i++) {
-- 
1.8.4

