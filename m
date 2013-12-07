Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat,  7 Dec 2013 11:21:24 +0100
Message-Id: <1386411684-2448-4-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1386411684-2448-1-git-send-email-antonio@meshcoding.com>
References: <1386411684-2448-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: fix typ0s in
	batadv_tt_global_is_isolated()
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

Introduced by 6fa38a2c72cc79dd961a6d9ed00d32e1c308b448
("batman-adv: set the isolation mark in the skb if needed")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 translation-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/translation-table.c b/translation-table.c
index 6fbb6a0..9fee80c 100644
--- a/translation-table.c
+++ b/translation-table.c
@@ -3584,7 +3584,7 @@ int batadv_tt_init(struct batadv_priv *bat_priv)
  * @addr: the mac address of the client
  * @vid: the identifier of the VLAN where this client is connected
  *
- * Return true if the client is marked with the TT_CLIENT_ISOLA flag, flase
+ * Returns true if the client is marked with the TT_CLIENT_ISOLA flag, false
  * otherwise
  */
 bool batadv_tt_global_is_isolated(struct batadv_priv *bat_priv,
-- 
1.8.5.1

