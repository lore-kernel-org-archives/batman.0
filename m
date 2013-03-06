Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed,  6 Mar 2013 11:33:00 +0100
Message-Id: <1362565981-31117-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: invoke post_func only if the
	attribute has been changed
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

In the sysfs boolean attribute handling mechanism, the
post_func passed as argument to the store procedure had to
be invoked if and only if the value of the attribute has
been switched. This avoids to invoke the post_func many
times while it does not expect so.

Cc: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

* compiled test only *
will do more tests later, hoping that the concept is not entirely wrong :)

 sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index 15a22ef..c9b5257 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -149,7 +149,7 @@ static int batadv_store_bool_attr(char *buff, size_t count,
 	}
 
 	if (atomic_read(attr) == enabled)
-		return count;
+		return 0;
 
 	batadv_info(net_dev, "%s: Changing from: %s to: %s\n", attr_name,
 		    atomic_read(attr) == 1 ? "enabled" : "disabled",
@@ -169,7 +169,7 @@ __batadv_store_bool_attr(char *buff, size_t count,
 
 	ret = batadv_store_bool_attr(buff, count, net_dev, attr->name,
 				     attr_store);
-	if (post_func && ret)
+	if (post_func && ret > 0)
 		post_func(net_dev);
 
 	return ret;
-- 
1.8.1.5

