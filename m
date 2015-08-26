Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 26 Aug 2015 10:31:51 +0200
Message-Id: <1440577911-16107-2-git-send-email-sven@narfation.org>
In-Reply-To: <1440577911-16107-1-git-send-email-sven@narfation.org>
References: <1440577911-16107-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix typo 'wether' ->
	'whether'
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 45952dcb0b68..5dbcb2e2b497 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -908,7 +908,7 @@ end:
  *  appropriate handlers
  * @bat_priv: the bat priv with all the soft interface information
  * @tvlv_handler: tvlv callback function handling the tvlv content
- * @ogm_source: flag indicating wether the tvlv is an ogm or a unicast packet
+ * @ogm_source: flag indicating whether the tvlv is an ogm or a unicast packet
  * @orig_node: orig node emitting the ogm packet
  * @src: source mac address of the unicast packet
  * @dst: destination mac address of the unicast packet
@@ -961,7 +961,7 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
  * batadv_tvlv_containers_process - parse the given tvlv buffer to call the
  *  appropriate handlers
  * @bat_priv: the bat priv with all the soft interface information
- * @ogm_source: flag indicating wether the tvlv is an ogm or a unicast packet
+ * @ogm_source: flag indicating whether the tvlv is an ogm or a unicast packet
  * @orig_node: orig node emitting the ogm packet
  * @src: source mac address of the unicast packet
  * @dst: destination mac address of the unicast packet
-- 
2.5.0

