Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Thu,  2 Mar 2017 10:44:09 +0100
Message-Id: <20170302094409.20995-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] RFC: batman-adv: Increase hashtable size for
	the global translation table
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

With the addition of multicast optimization features in batman-adv
not only unicast but also multicast addresses are now fed into the
translatation table. This approximately increases the number of
entries by a factor of roughly 2 to 3.

Also, the number of client devices in some known, public mesh networks
has grown to nearly 4000.

Therefore this patch inceases the global translation table size from
1024 to 16384 to reduce load in larger mesh networks.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

---
ToDo (maybe): Gather some statistics on how much this might reduce load
in some particular networks.

This might be a hotfix for some larger Freifunk mesh networks which are
experiencing a significantly higher load level since they switched to
a recent batman-adv version. Validating whether the hashtable size might
be the reason is currently being investigated.

On the long run we should switch to the resizable hash table implementation
the kernel now provides since not that long ago.
---
 net/batman-adv/translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e75b493..e87825c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1462,7 +1462,7 @@ static int batadv_tt_global_init(struct batadv_priv *bat_priv)
 	if (bat_priv->tt.global_hash)
 		return 0;
 
-	bat_priv->tt.global_hash = batadv_hash_new(1024);
+	bat_priv->tt.global_hash = batadv_hash_new(16384);
 
 	if (!bat_priv->tt.global_hash)
 		return -ENOMEM;
-- 
2.1.4

