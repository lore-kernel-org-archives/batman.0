Return-Path: <russell@personaltelco.net>
References: <1392134707-2318-1-git-send-email-antonio@meshcoding.com>
 <1392134707-2318-2-git-send-email-antonio@meshcoding.com>
From: Russell Senior <russell@personaltelco.net>
Date: Tue, 11 Feb 2014 09:13:22 -0800
In-Reply-To: <1392134707-2318-2-git-send-email-antonio@meshcoding.com>
 (Antonio Quartulli's message of "Tue\, 11 Feb 2014 17\:05\:07 +0100")
Message-ID: <86eh398te5.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: free skb on TVLV
	parsing success
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


From: Antonio Quartulli <antonio@open-mesh.com>
When the TVLV parsing routine succeed the skb is left
untouched thus leading to a memory leak.

Fix this by consuming the skb in case of success.

Introduced by 0b6aa0d43767889eeda43a132cf5e73df4e63bf2
("batman-adv: tvlv - basic infrastructure")

Reported-by: Russell Senior <russell@personaltelco.net>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Tested-by: Russell Senior <russell@personaltelco.net>
---
 routing.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/routing.c b/routing.c
index f7579d0..71bf698 100644
--- a/routing.c
+++ b/routing.c
@@ -1063,6 +1063,8 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 
 	if (ret != NET_RX_SUCCESS)
 		ret = batadv_route_unicast_packet(skb, recv_if);
+	else
+		consume_skb(skb);
 
 	return ret;
 }
-- 
1.8.5.3




-- 
Russell Senior, President
russell@personaltelco.net
