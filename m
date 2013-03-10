Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 10 Mar 2013 01:19:43 +0100
Message-Id: <1362874783-8220-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: correct super define in network
	coding header
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

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 network-coding.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/network-coding.h b/network-coding.h
index 352c693..4fa6d0c 100644
--- a/network-coding.h
+++ b/network-coding.h
@@ -17,8 +17,8 @@
  * 02110-1301, USA
  */
 
-#ifndef _NET_BATMAN_ADV_NETWORK_CODING_H
-#define _NET_BATMAN_ADV_NETWORK_CODING_H
+#ifndef _NET_BATMAN_ADV_NETWORK_CODING_H_
+#define _NET_BATMAN_ADV_NETWORK_CODING_H_
 
 #ifdef CONFIG_BATMAN_ADV_NC
 
@@ -120,4 +120,4 @@ static inline int batadv_nc_init_debugfs(struct batadv_priv *bat_priv)
 
 #endif /* ifdef CONFIG_BATMAN_ADV_NC */
 
-#endif /* _NET_BATMAN_ADV_NETWORK_CODING_H */
+#endif /* _NET_BATMAN_ADV_NETWORK_CODING_H_ */
-- 
1.8.1.5

