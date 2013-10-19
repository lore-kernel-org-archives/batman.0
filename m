Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 19 Oct 2013 23:29:00 +0200
Message-Id: <1382218140-1359-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix small glitch in comment
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

Introduced by e4ff5c153dab054a6cd1c4132f87bc5e77127456
("batman-adv: add sysfs framework for VLAN")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---

sorry for not having sent this before..

 sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sysfs.c b/sysfs.c
index 096b511..6335433 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -54,7 +54,7 @@ static struct batadv_priv *batadv_vlan_kobj_to_batpriv(struct kobject *obj)
 	if (!strcmp(BATADV_SYSFS_IF_MESH_SUBDIR, obj->name))
 		return batadv_kobj_to_batpriv(obj);
 
-	/* ..while the attributed for the tagged vlans are located in
+	/* ..while the attributes for the tagged vlans are located in
 	 * the in the corresponding "vlan%VID" subfolder
 	 */
 	return batadv_kobj_to_batpriv(obj->parent);
-- 
1.8.4

