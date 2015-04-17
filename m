Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Apr 2015 18:34:18 +0200
Message-Id: <1429288461-26260-3-git-send-email-sven@narfation.org>
In-Reply-To: <1429288461-26260-1-git-send-email-sven@narfation.org>
References: <13114664.Eg4ODy7KEo@bentobox>
 <1429288461-26260-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH-next 3/6] batman-adv: Use kasprintf
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

From: Himangi Saraogi <himangi774@gmail.com>

kasprintf combines kmalloc and sprintf, and takes care of the size
calculation itself.

The semantic patch that makes this change is as follows:

// <smpl>
@@
expression a,flag;
expression list args;
statement S;
@@

  a =
-  \(kmalloc\|kzalloc\)(...,flag)
+  kasprintf(flag,args)
  <... when != a
  if (a == NULL || ...) S
  ...>
- sprintf(a,args);
// </smpl>

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 sysfs.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index a63c3eb..a75dc12 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -899,32 +899,24 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 
 	bat_kobj = &bat_priv->soft_iface->dev.kobj;
 
-	uevent_env[0] = kmalloc(strlen(BATADV_UEV_TYPE_VAR) +
-				strlen(batadv_uev_type_str[type]) + 1,
-				GFP_ATOMIC);
+	uevent_env[0] = kasprintf(GFP_ATOMIC,
+				  "%s%s", BATADV_UEV_TYPE_VAR,
+				  batadv_uev_type_str[type]);
 	if (!uevent_env[0])
 		goto out;
 
-	sprintf(uevent_env[0], "%s%s", BATADV_UEV_TYPE_VAR,
-		batadv_uev_type_str[type]);
-
-	uevent_env[1] = kmalloc(strlen(BATADV_UEV_ACTION_VAR) +
-				strlen(batadv_uev_action_str[action]) + 1,
-				GFP_ATOMIC);
+	uevent_env[1] = kasprintf(GFP_ATOMIC,
+				  "%s%s", BATADV_UEV_ACTION_VAR,
+				  batadv_uev_action_str[action]);
 	if (!uevent_env[1])
 		goto out;
 
-	sprintf(uevent_env[1], "%s%s", BATADV_UEV_ACTION_VAR,
-		batadv_uev_action_str[action]);
-
 	/* If the event is DEL, ignore the data field */
 	if (action != BATADV_UEV_DEL) {
-		uevent_env[2] = kmalloc(strlen(BATADV_UEV_DATA_VAR) +
-					strlen(data) + 1, GFP_ATOMIC);
+		uevent_env[2] = kasprintf(GFP_ATOMIC,
+					  "%s%s", BATADV_UEV_DATA_VAR, data);
 		if (!uevent_env[2])
 			goto out;
-
-		sprintf(uevent_env[2], "%s%s", BATADV_UEV_DATA_VAR, data);
 	}
 
 	ret = kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
-- 
2.1.4

