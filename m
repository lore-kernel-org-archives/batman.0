Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 11 Jul 2014 14:26:24 +0200
Message-Id: <1405081595-23371-2-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
References: <1405081595-23371-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 02/13] batman-adv: kernel doc fixes for
	bridge_loop_avoidance.c
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

Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
---
 bridge_loop_avoidance.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bridge_loop_avoidance.c b/bridge_loop_avoidance.c
index a957c81..9946006 100644
--- a/bridge_loop_avoidance.c
+++ b/bridge_loop_avoidance.c
@@ -252,7 +252,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 /**
  * batadv_bla_send_claim - sends a claim frame according to the provided info
  * @bat_priv: the bat priv with all the soft interface information
- * @orig: the mac address to be announced within the claim
+ * @mac: the mac address to be announced within the claim
  * @vid: the VLAN ID
  * @claimtype: the type of the claim (CLAIM, UNCLAIM, ANNOUNCE, ...)
  */
@@ -364,6 +364,7 @@ out:
  * @bat_priv: the bat priv with all the soft interface information
  * @orig: the mac address of the originator
  * @vid: the VLAN ID
+ * @own_backbone: set if the requested backbone  is local
  *
  * searches for the backbone gw or creates a new one if it could not
  * be found.
@@ -454,6 +455,7 @@ batadv_bla_update_own_backbone_gw(struct batadv_priv *bat_priv,
 /**
  * batadv_bla_answer_request - answer a bla request by sending own claims
  * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: interface where the request came on
  * @vid: the vid where the request came on
  *
  * Repeat all of our own claims, and finally send an ANNOUNCE frame
@@ -775,6 +777,7 @@ static int batadv_handle_claim(struct batadv_priv *bat_priv,
 /**
  * batadv_check_claim_group
  * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the primary interface of this batman interface
  * @hw_src: the Hardware source in the ARP Header
  * @hw_dst: the Hardware destination in the ARP Header
  * @ethhdr: pointer to the Ethernet header of the claim frame
@@ -850,6 +853,7 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
 /**
  * batadv_bla_process_claim
  * @bat_priv: the bat priv with all the soft interface information
+ * @primary_if: the primary hard interface of this batman soft interface
  * @skb: the frame to be checked
  *
  * Check if this is a claim frame, and process it accordingly.
-- 
2.0.1

