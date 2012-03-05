Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  5 Mar 2012 08:51:51 +0100
Message-Id: <1330933911-6320-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: avoid ap_isolated check for
	broadcast packet
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

in case of a broadcast packet, the result of the ap_isolated check is always
false (since we have no ff:ff:ff:ff:ff:ff client to check for TT_CLIENT_WIFI),
therefore we can avoid searching the translation table and we can return false
directly

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

- Yes, it's just an optimisation that aims to avoid accessing the hash table
  when we already know that it is not needed.


 translation-table.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/translation-table.c b/translation-table.c
index 9a07882..2e16882 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -2034,6 +2034,11 @@ bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t *dst)
 	if (!atomic_read(&bat_priv->ap_isolation))
 		return false;
 
+	/* if we are dealing with a broadcast packet, we can avoid to search the
+	 * translation table */
+	if (is_broadcast_ether_addr(dst))
+		return false;
+
 	tt_local_entry = tt_local_hash_find(bat_priv, dst);
 	if (!tt_local_entry)
 		goto out;
-- 
1.7.3.4

