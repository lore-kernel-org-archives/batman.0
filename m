Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri,  1 Apr 2011 08:49:18 +0200
Message-Id: <1301640559-4152-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Add missing static for
	softif_neigh_deselect
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

053e6e6c30c161c218eacf2eb2eb4c7ecc0f387c forgot to mark the only locally
used function softif_neigh_deselect as static.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 soft-interface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/soft-interface.c b/soft-interface.c
index 599b668..58ce440 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -123,7 +123,7 @@ static void softif_neigh_select(struct bat_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->softif_neigh_lock);
 }
 
-void softif_neigh_deselect(struct bat_priv *bat_priv)
+static void softif_neigh_deselect(struct bat_priv *bat_priv)
 {
 	softif_neigh_select(bat_priv, NULL);
 }
-- 
1.7.4.1

