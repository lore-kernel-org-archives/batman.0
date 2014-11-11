Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Tue, 11 Nov 2014 16:22:23 +0100
Message-Id: <1415719343-2989-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix lock class for decoding hash
	in network-coding.c
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

batadv_has_set_lock_class() is called with the wrong hash table as first
argument (probably due to a copy-paste error), which leads to false
positives when running with lockdep.

Introduced-by: 612d2b4fe0a1ff2f8389462a6f8be34e54124c05
('batman-adv: network coding - save overheard and tx packets for decoding')

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 network-coding.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/network-coding.c b/network-coding.c
index bd33894..127cc4d 100644
--- a/network-coding.c
+++ b/network-coding.c
@@ -133,7 +133,7 @@ int batadv_nc_mesh_init(struct batadv_priv *bat_priv)
 	if (!bat_priv->nc.decoding_hash)
 		goto err;
 
-	batadv_hash_set_lock_class(bat_priv->nc.coding_hash,
+	batadv_hash_set_lock_class(bat_priv->nc.decoding_hash,
 				   &batadv_nc_decoding_hash_lock_class_key);
 
 	INIT_DELAYED_WORK(&bat_priv->nc.work, batadv_nc_worker);
-- 
2.1.3

