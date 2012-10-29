Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 29 Oct 2012 15:38:08 +0100
Message-Id: <1351521488-17271-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: free the dat hash only if not
	NULL
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

It could be the case that the user tries to disable DAT when it is already
disabled. To prevent kernel oops, batadv_dat_hash_free() has to check for the
hash table pointer being different from NULL before to try to free it.

This was introduced by ("batman-adv: Distributed ARP Table - add runtime
switch")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 distributed-arp-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index c933615..0fea29a 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -634,6 +634,9 @@ out:
  */
 static void batadv_dat_hash_free(struct batadv_priv *bat_priv)
 {
+	if (!bat_priv->dat.hash)
+		return;
+
 	__batadv_dat_purge(bat_priv, NULL);
 
 	batadv_hash_destroy(bat_priv->dat.hash);
-- 
1.7.12.4

