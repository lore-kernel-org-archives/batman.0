Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed,  3 Feb 2016 10:18:25 +0800
Message-Id: <1454465917-13332-5-git-send-email-a@unstable.cc>
In-Reply-To: <1454465917-13332-1-git-send-email-a@unstable.cc>
References: <1454465917-13332-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 04/16] batman-adv: Drop invalid kerneldoc for
	variable batadv_vlan_attrs
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

From: Sven Eckelmann <sven@narfation.org>

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/sysfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index fe87777fda8a..33772d9bd613 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -620,9 +620,7 @@ static struct batadv_attribute *batadv_mesh_attrs[] = {
 
 BATADV_ATTR_VLAN_BOOL(ap_isolation, S_IRUGO | S_IWUSR, NULL);
 
-/**
- * batadv_vlan_attrs - array of vlan specific sysfs attributes
- */
+/* array of vlan specific sysfs attributes */
 static struct batadv_attribute *batadv_vlan_attrs[] = {
 	&batadv_attr_vlan_ap_isolation,
 	NULL,
-- 
2.7.0

