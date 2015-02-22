Return-Path: <joe@perches.com>
Message-ID: <1424641676.20944.18.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Sun, 22 Feb 2015 13:47:56 -0800
In-Reply-To: <20150220.151843.902196140727344622.davem@davemloft.net>
References: <1424136699.8287.10.camel@perches.com>
 <20150220.151843.902196140727344622.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] [PATCH net-next] batman-adv: Fix use of
	seq_has_overflowed()
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch, antonio@meshcoding.com, linux-kernel@vger.kernel.org

net-next commit 6d91147d183c ("batman-adv: Remove uses of return value
of seq_printf") incorrectly changed the overflow occurred return from
-1 to 1.  Change it back so that the test of batadv_write_buffer_text's
return value in batadv_gw_client_seq_print_text works properly.

Signed-off-by: Joe Perches <joe@perches.com>
---

sorry 'bout that.

I believe this won't have any real effect unless there
are something like 500+ entries in the gateway list.

 net/batman-adv/gateway_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index a0876ea..090828c 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -601,7 +601,7 @@ static int batadv_write_buffer_text(struct batadv_priv *bat_priv,
 		   gw_node->bandwidth_down % 10,
 		   gw_node->bandwidth_up / 10,
 		   gw_node->bandwidth_up % 10);
-	ret = seq_has_overflowed(seq);
+	ret = seq_has_overflowed(seq) ? -1 : 0;
 
 	if (curr_gw)
 		batadv_gw_node_free_ref(curr_gw);


