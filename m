Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 20 Sep 2014 18:22:05 +0200
Message-Id: <1411230125-21848-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: avoid NULL dereferences
	and fix if check
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

Gateway having bandwidth_down equal to zero are not accepted
at all and so never added to the Gateway list.
For this reason checking the bandwidth_down member in
batadv_gw_out_of_range() is useless.

This is probably a copy/paste error and this check was supposed
to be "!gw_node" only. Moreover, the way the check is written
now may also lead to a NULL dereference.

Fix this by rewriting the if-condition properly.

Introduced by 0853ec7fafe0a195754454832993c6b35e22b842
("batman-adv: tvlv - gateway download/upload bandwidth container")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
Reported-by: David Binderman <dcb314@hotmail.com>
---

This patch makes "batman-adv: avoid NULL dereferences and clarify if check"
obsolete.


 gateway_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gateway_client.c b/gateway_client.c
index bcc3e0c..27649e8 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -811,7 +811,7 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 		goto out;
 
 	gw_node = batadv_gw_node_get(bat_priv, orig_dst_node);
-	if (!gw_node->bandwidth_down == 0)
+	if (!gw_node)
 		goto out;
 
 	switch (atomic_read(&bat_priv->gw_mode)) {
-- 
1.8.5.5

