Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 15 Aug 2013 19:45:58 +0200
Message-Id: <1376588758-3625-1-git-send-email-ordex@autistici.org>
In-Reply-To: <20130815131307.GA2042@pandem0nium>
References: <20130815131307.GA2042@pandem0nium>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: print some info for vlan
	debugging
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
Cc: Antonio Quartulli <ordex@autistici.org>

This patch will print some more information when doing
ifconfig bat0 up & down

please report the output.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 soft-interface.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/soft-interface.c b/soft-interface.c
index d018c49..7876476 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -525,6 +525,9 @@ static int batadv_interface_add_vid(struct net_device *dev, __be16 proto,
 
 	vid |= BATADV_VLAN_HAS_TAG;
 
+	printk("batadv_add_vid(): creating vlan %s %d\n", dev->name,
+	       BATADV_PRINT_VID(vid));
+
 	return batadv_softif_create_vlan(bat_priv, vid);
 }
 
@@ -551,9 +554,14 @@ static int batadv_interface_kill_vid(struct net_device *dev, __be16 proto,
 	if (proto != htons(ETH_P_8021Q))
 		return -EINVAL;
 
+	printk("batadv_kill_vid(): %s %d\n", dev->name,
+		BATADV_PRINT_VID(vid | BATADV_VLAN_HAS_TAG));
+
 	vlan = batadv_softif_vlan_get(bat_priv, vid | BATADV_VLAN_HAS_TAG);
-	if (!vlan)
+	if (!vlan) {
+		printk("batadv_kill_vid(): couldn't find vlan to kill\n");
 		return -ENOENT;
+	}
 
 	batadv_softif_destroy_vlan(bat_priv, vlan);
 
-- 
1.8.1.5

