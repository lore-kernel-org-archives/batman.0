Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 22 Sep 2013 20:26:50 +0200
Message-Id: <1379874410-3354-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: no need for return in void
	functions
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

Only network-coding.h is using "return;" inside void stub
functions. This is not a consistent with the rest of the code,
therefore don't continue to do as such.
(Other stub functions will be cleaned later)

Introduced by 7dd9d8992b0c197ba656a6d9a70966cea10fc2d9
("batman-adv: tvlv - add network coding container")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 network-coding.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/network-coding.h b/network-coding.h
index 8a97b40..d2f110c 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -49,7 +49,6 @@ int batadv_nc_init_debugfs(struct batadv_priv *bat_priv);
 
 static inline void batadv_nc_status_update(struct net_device *net_dev)
 {
-	return;
 }
 
 static inline int batadv_nc_init(struct batadv_priv *bat_priv)
-- 
1.8.1.5

