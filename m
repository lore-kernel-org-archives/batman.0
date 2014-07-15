Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Tue, 15 Jul 2014 09:41:13 +0200
Message-Id: <1405410077-28764-9-git-send-email-martin@hundeboll.net>
In-Reply-To: <1405410077-28764-1-git-send-email-martin@hundeboll.net>
References: <1405410077-28764-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 09/13] batman-adv: kernel doc fix for send.c
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
 send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/send.c b/send.c
index d27161e..ed77eae 100644
--- a/send.c
+++ b/send.c
@@ -193,7 +193,7 @@ static bool batadv_send_skb_prepare_unicast(struct sk_buff *skb,
  *  unicast 4addr header
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: the skb containing the payload to encapsulate
- * @orig_node: the destination node
+ * @orig: the destination node
  * @packet_subtype: the unicast 4addr packet subtype to use
  *
  * Returns false if the payload could not be encapsulated or true otherwise.
-- 
2.0.1

