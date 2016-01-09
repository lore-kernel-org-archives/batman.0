Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Sat,  9 Jan 2016 21:20:16 +0800
Message-Id: <1452345621-15908-12-git-send-email-a@unstable.cc>
In-Reply-To: <1452345621-15908-1-git-send-email-a@unstable.cc>
References: <1452345621-15908-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 11/16] batman-adv: Split a condition check
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Markus Elfring <elfring@users.sourceforge.net>, Marek Lindner <mareklindner@neomailbox.ch>

From: Markus Elfring <elfring@users.sourceforge.net>

Let us split a check for a condition at the beginning of the
batadv_is_ap_isolated() function so that a direct return can be performed
in this function if the variable "vlan" contained a null pointer.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/translation-table.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5852fda9f175..a22080c53401 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3339,7 +3339,10 @@ bool batadv_is_ap_isolated(struct batadv_priv *bat_priv, u8 *src, u8 *dst,
 	bool ret = false;
 
 	vlan = batadv_softif_vlan_get(bat_priv, vid);
-	if (!vlan || !atomic_read(&vlan->ap_isolation))
+	if (!vlan)
+		return false;
+
+	if (!atomic_read(&vlan->ap_isolation))
 		goto out;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, dst, vid);
-- 
2.7.0

