Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 19 Oct 2010 01:46:30 +0200
Message-Id: <1287445590-18048-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove space before tab in
	bat_sysfs.c
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
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/bat_sysfs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv/bat_sysfs.c b/batman-adv/bat_sysfs.c
index dbb0208..5ea5c11 100644
--- a/batman-adv/bat_sysfs.c
+++ b/batman-adv/bat_sysfs.c
@@ -80,7 +80,7 @@ ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
 }
 
 #define BAT_ATTR_SHOW_UINT(_name)					\
-ssize_t show_##_name(struct kobject *kobj, struct attribute *attr, 	\
+ssize_t show_##_name(struct kobject *kobj, struct attribute *attr,	\
 			    char *buff)					\
 {									\
 	struct bat_priv *bat_priv = kobj_to_batpriv(kobj);		\
-- 
1.7.2.3

