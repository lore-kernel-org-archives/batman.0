Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  7 Jul 2018 22:01:19 +0200
Message-Id: <20180707200121.2684-2-sven@narfation.org>
In-Reply-To: <20180707200121.2684-1-sven@narfation.org>
References: <20180707200121.2684-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: Unify include guards style
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

All other include guards in batman-adv use the style:

* _NET_BATMAN_ADV_$(FILENAME)_
* uppercase only
* "." & "-" replaced with "_"

Use this also in the B.A.T.M.A.N. IV/V OGM implementation headers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.h | 6 +++---
 net/batman-adv/bat_v_ogm.h  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.h b/net/batman-adv/bat_iv_ogm.h
index 317cafd3..3dc6a7a4 100644
--- a/net/batman-adv/bat_iv_ogm.h
+++ b/net/batman-adv/bat_iv_ogm.h
@@ -16,11 +16,11 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef _BATMAN_ADV_BATADV_IV_OGM_H_
-#define _BATMAN_ADV_BATADV_IV_OGM_H_
+#ifndef _NET_BATMAN_ADV_BAT_IV_OGM_H_
+#define _NET_BATMAN_ADV_BAT_IV_OGM_H_
 
 #include "main.h"
 
 int batadv_iv_init(void);
 
-#endif /* _BATMAN_ADV_BATADV_IV_OGM_H_ */
+#endif /* _NET_BATMAN_ADV_BAT_IV_OGM_H_ */
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index ed36c5e7..e5be14c9 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -16,8 +16,8 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef _BATMAN_ADV_BATADV_V_OGM_H_
-#define _BATMAN_ADV_BATADV_V_OGM_H_
+#ifndef _NET_BATMAN_ADV_BAT_V_OGM_H_
+#define _NET_BATMAN_ADV_BAT_V_OGM_H_
 
 #include "main.h"
 
@@ -34,4 +34,4 @@ void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface);
 int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
 
-#endif /* _BATMAN_ADV_BATADV_V_OGM_H_ */
+#endif /* _NET_BATMAN_ADV_BAT_V_OGM_H_ */
-- 
2.18.0

