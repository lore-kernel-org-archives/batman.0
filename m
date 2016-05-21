Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sat, 21 May 2016 20:17:56 +0800
Message-Id: <20160521121756.27450-2-a@unstable.cc>
In-Reply-To: <20160521121756.27450-1-a@unstable.cc>
References: <20160521121756.27450-1-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: move include line at the
	same place as other files
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
Cc: Antonio Quartulli <a@unstable.cc>

main.h is always included after the #ifdef guard except for
bat_v_elp.h. Move it at the right place.

Cc: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/bat_v_elp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index cc130b2..be17c0b 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -15,11 +15,11 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "main.h"
-
 #ifndef _NET_BATMAN_ADV_BAT_V_ELP_H_
 #define _NET_BATMAN_ADV_BAT_V_ELP_H_
 
+#include "main.h"
+
 struct sk_buff;
 struct work_struct;
 
-- 
2.8.3

