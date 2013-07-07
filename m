Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  7 Jul 2013 09:19:56 +0200
Message-Id: <1373181596-3700-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix argument alignment
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Introduced by e4ff5c153dab054a6cd1c4132f87bc5e77127456
("batman-adv: add sysfs framework for VLAN")

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sysfs.c b/sysfs.c
index cd60fba..6ec145d 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -196,7 +196,7 @@ ssize_t batadv_store_vlan_##_name(struct kobject *kobj,			\
 
 #define BATADV_ATTR_VLAN_SHOW_BOOL(_name)				\
 ssize_t batadv_show_vlan_##_name(struct kobject *kobj,			\
-			    struct attribute *attr, char *buff)		\
+				 struct attribute *attr, char *buff)	\
 {									\
 	struct batadv_priv *bat_priv = batadv_vlan_kobj_to_batpriv(kobj);\
 	struct batadv_softif_vlan *vlan = batadv_kobj_to_vlan(bat_priv,	\
-- 
1.8.1.5

