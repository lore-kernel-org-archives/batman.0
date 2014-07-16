Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 16 Jul 2014 12:23:10 +0200
Message-Id: <1405506190-9733-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove obsolete variable
	primary_iface from orig_node
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

This variable became obsolete when changing to the new bonding mechanism
based on the multi interface optimization. Since its not used anywhere,
remove it.

Reported-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/types.h b/types.h
index 8854c05..462a70c 100644
--- a/types.h
+++ b/types.h
@@ -199,7 +199,6 @@ struct batadv_orig_bat_iv {
 /**
  * struct batadv_orig_node - structure for orig_list maintaining nodes of mesh
  * @orig: originator ethernet address
- * @primary_addr: hosts primary interface address
  * @ifinfo_list: list for routers per outgoing interface
  * @last_bonding_candidate: pointer to last ifinfo of last used router
  * @batadv_dat_addr_t:  address of the orig node in the distributed hash
@@ -244,7 +243,6 @@ struct batadv_orig_bat_iv {
  */
 struct batadv_orig_node {
 	uint8_t orig[ETH_ALEN];
-	uint8_t primary_addr[ETH_ALEN];
 	struct hlist_head ifinfo_list;
 	struct batadv_orig_ifinfo *last_bonding_candidate;
 #ifdef CONFIG_BATMAN_ADV_DAT
-- 
1.9.1

