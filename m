Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 17 Aug 2013 13:04:45 +0200
Message-Id: <1376737486-1863-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1376737486-1863-1-git-send-email-ordex@autistici.org>
References: <1376737486-1863-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: properly end seq_read session
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <ordex@autistici.org>

A missing skb_abort_seq_read() has to be added in order to
properly close the seq_read session initiated with
skb_prepare_seq_read().

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 net/batman-adv/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 08125f3..51aafd6 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -473,6 +473,7 @@ __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
 		crc = crc32c(crc, data, len);
 		consumed += len;
 	}
+	skb_abort_seq_read(&st);
 
 	return htonl(crc);
 }
-- 
1.8.1.5

