Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  8 Jan 2015 16:15:07 +0100
Message-Id: <1420730120-9844-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
References: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 02/15] batman-adv: remove obsolete variable
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Simon Wunderlich <sw@simonwunderlich.de>

This variable became obsolete when changing to the new bonding mechanism
based on the multi interface optimization. Since its not used anywhere,
remove it.

Reported-by: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8854c05..462a70c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
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
2.2.1

