Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 22 Sep 2013 20:18:27 +0200
Message-Id: <1379873908-1766-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 1/2 next] batman-adv: fix orig capabilities
	numbering
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

Let's start the capabilities from bit 0.

Introduced by 2b1c07b918d2acc41555bbde9d538179acb308b4
("batman-adv: tvlv - add distributed arp table container")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/types.h b/types.h
index f323822..8465a55 100644
--- a/types.h
+++ b/types.h
@@ -246,7 +246,7 @@ struct batadv_orig_node {
  * @BATADV_ORIG_CAPA_HAS_NC: orig node has network coding enabled
  */
 enum batadv_orig_capabilities {
-	BATADV_ORIG_CAPA_HAS_DAT = BIT(1),
+	BATADV_ORIG_CAPA_HAS_DAT = BIT(0),
 	BATADV_ORIG_CAPA_HAS_NC = BIT(2),
 };
 
-- 
1.8.1.5

