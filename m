Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 17 Feb 2014 21:48:42 +0100
Message-Id: <1392670129-2498-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
References: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 03/10] batman-adv: release vlan object after
	checking the CRC
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

There is a refcounter unbalance in the CRC checking routine
invoked on OGM reception. A vlan object is retrieved (thus
its refcounter is increased by one) but it is never properly
released. This leads to a memleak because the vlan object
will never be free'd.

Fix this by releasing the vlan object after having read the
CRC.

Reported-by: Russell Senior <russell@personaltelco.net>
Reported-by: Daniel <daniel@makrotopia.org>
Reported-by: cmsv <cmsv@wirelesspt.net>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 net/batman-adv/translation-table.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index beba13f..c21c557 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2262,6 +2262,7 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
 	struct batadv_orig_node_vlan *vlan;
+	uint32_t crc;
 	int i;
 
 	/* check if each received CRC matches the locally stored one */
@@ -2281,7 +2282,10 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 		if (!vlan)
 			return false;
 
-		if (vlan->tt.crc != ntohl(tt_vlan_tmp->crc))
+		crc = vlan->tt.crc;
+		batadv_orig_node_vlan_free_ref(vlan);
+
+		if (crc != ntohl(tt_vlan_tmp->crc))
 			return false;
 	}
 
-- 
1.8.5.3

