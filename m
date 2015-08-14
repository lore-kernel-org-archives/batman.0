Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Fri, 14 Aug 2015 17:23:49 +0200
Message-Id: <1439565830-9776-2-git-send-email-linus.luessing@c0d3.blue>
In-Reply-To: <1439565830-9776-1-git-send-email-linus.luessing@c0d3.blue>
References: <1439565830-9776-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint 2/3] batman-adv: Remove unnecessary
 braces for test_bit() in NC
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

Fixes: dfb27e75 ("batman-adv: Fix broken NC capability check")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/network-coding.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-coding.c
index 55a0b28..1a1f7e6 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -894,7 +894,7 @@ void batadv_nc_update_nc_node(struct batadv_priv *bat_priv,
 		goto out;
 
 	/* check if orig node is network coding enabled */
-	if (!(test_bit(BATADV_ORIG_CAPA_HAS_NC, &orig_node->capabilities)))
+	if (!test_bit(BATADV_ORIG_CAPA_HAS_NC, &orig_node->capabilities))
 		goto out;
 
 	/* accept ogms from 'good' neighbors and single hop neighbors */
-- 
1.7.10.4

