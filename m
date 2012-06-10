Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 10 Jun 2012 22:05:40 +0800
Message-Id: <1339337141-3938-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: fix SIF show / store uint
	regression
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Regression was introduced with commit: 98881e49

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 bat_sysfs.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index e0272fe..e1ba286 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -135,8 +135,9 @@ ssize_t batadv_store_##_name(struct kobject *kobj,			\
 	if (!hard_iface)						\
 		return 0;						\
 									\
-	length = __store_uint_attr(buff, count, _min, _max, _post_func,	\
-				   attr, &hard_iface->_name, net_dev);	\
+	length = __batadv_store_uint_attr(buff, count, _min, _max,	\
+					  _post_func, attr,		\
+					  &hard_iface->_name, net_dev);	\
 									\
 	hardif_free_ref(hard_iface);					\
 	return length;							\
-- 
1.7.9.1

