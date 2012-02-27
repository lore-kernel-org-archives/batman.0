Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 27 Feb 2012 11:29:53 +0100
Message-Id: <1330338593-17809-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix wrong dhcp option list
	browsing
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

In is_type_dhcprequest(), while parsing a DHCP message, if the entry we found in
the option list is neither a padding nor the dhcp-type, we have to ignore it and
jump as many bytes as its length + 1. The "+ 1" byte is given by the subtype
field itself that has to be jumped too.

Reported-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 gateway_client.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gateway_client.c b/gateway_client.c
index 65a77a1..1f7e92d 100644
--- a/gateway_client.c
+++ b/gateway_client.c
@@ -563,10 +563,10 @@ static bool is_type_dhcprequest(struct sk_buff *skb, int header_len)
 			p++;
 
 			/* ...and then we jump over the data */
-			if (pkt_len < *p)
+			if (pkt_len < 1 + (*p))
 				goto out;
-			pkt_len -= *p;
-			p += (*p);
+			pkt_len -= 1 + (*p);
+			p += 1 + (*p);
 		}
 	}
 out:
-- 
1.7.3.4

