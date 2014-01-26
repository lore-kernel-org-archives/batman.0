Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 26 Jan 2014 15:24:16 +0100
Message-Id: <1390746256-551-1-git-send-email-antonio@meshcoding.com>
In-Reply-To: <52E51A04.8020800@meshcoding.com>
References: <52E51A04.8020800@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: release vlan object after
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>

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
---
 translation-table.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index 3fca99d..097ca01 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2248,6 +2248,7 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan_tmp;
 	struct batadv_orig_node_vlan *vlan;
+	uint32_t crc;
 	int i;
 
 	/* check if each received CRC matches the locally stored one */
@@ -2267,7 +2268,10 @@ static bool batadv_tt_global_check_crc(struct batadv_orig_node *orig_node,
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

