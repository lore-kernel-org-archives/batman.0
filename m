Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  8 Aug 2013 01:18:19 +0200
Message-Id: <1375917499-847-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: use proper network order
	conversion
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
Cc: Antonio Quartulli <ordex@autistici.org>

Introduced by eb7643628a608cb338d48d298ce7ca15fadfb239
("batman-adv: set skb priority according to content")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.c b/main.c
index ed97382..58c98b6 100644
--- a/main.c
+++ b/main.c
@@ -283,7 +283,7 @@ void batadv_skb_set_priority(struct sk_buff *skb, int offset)
 					  sizeof(*vhdr), &vhdr_tmp);
 		if (!vhdr)
 			return;
-		prio = htons(vhdr->h_vlan_TCI) & VLAN_PRIO_MASK;
+		prio = ntohs(vhdr->h_vlan_TCI) & VLAN_PRIO_MASK;
 		prio = prio >> VLAN_PRIO_SHIFT;
 		break;
 	case htons(ETH_P_IP):
-- 
1.8.1.5

