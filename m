Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu,  8 Jan 2015 16:15:17 +0100
Message-Id: <1420730120-9844-13-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
References: <1420730120-9844-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 12/15] batman-adv: clear control block of
	received socket buffers
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
Cc: netdev@vger.kernel.org, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>

From: Martin Hundebøll <martin@hundeboll.net>

Since other network components (and some drivers) uses the control block
provided in skb's, the network coding feature might wrongly assume that
an SKB has been decoded, and thus not try to code it with another packet
again. This happens for instance when batman-adv is running on a bridge device.

Fix this by clearing the control block for every received SKB.

Introduced by 3c12de9a5c756b23fe7c9ab332474ece1568914c
("batman-adv: network coding - code and transmit packets if possible")
Signed-off-by: Martin Hundebøll <martin@hundeboll.net>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 net/batman-adv/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d4079cd..3bcd847 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -402,6 +402,9 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 		goto err_free;
 	}
 
+	/* reset control block to avoid left overs from previous users */
+	memset(skb->cb, 0, sizeof(struct batadv_skb_cb));
+
 	/* all receive handlers return whether they received or reused
 	 * the supplied skb. if not, we have to free the skb.
 	 */
-- 
2.2.1

