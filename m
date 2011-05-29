Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 29 May 2011 15:05:34 +0200
Message-Id: <1306674334-17397-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: correct kobject_set_name()
	arguments
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Compiling against kernel version <2.6.25 was failing due to wrong
parameters.

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 compat.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat.h b/compat.h
index 6842a26..0f0e66e 100644
--- a/compat.h
+++ b/compat.h
@@ -131,7 +131,7 @@ static inline struct kobject *kobject_create_and_add(const char *name,
 	if (!kobj)
 		return NULL;
 
-	kobject_set_name(kobj, name);
+	kobject_set_name(kobj, "%s", name);
 	kobj->ktype = &ktype_bat_wrapper;
 	kobj->kset = NULL;
 	kobj->parent = parent;
-- 
1.7.3.4

