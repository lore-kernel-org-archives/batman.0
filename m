Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 22 Aug 2012 00:40:05 +0200
Message-Id: <1345588805-27249-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: swap lines to get in sync with
	networking branch
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

due to a merge conflict resolution handled differently in the networking branch,
we now have a small divergence between our next branch and what we already have
in net/batman-adv/ in the kernel. Since we cannot ask the kernel guys to "swap
two lines", with this patch we fix the problem in our repo

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---

- this patch is for next


 soft-interface.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/soft-interface.c b/soft-interface.c
index 1aee7db..7b683e0 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -277,8 +277,8 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	struct vlan_ethhdr *vhdr;
 	struct batadv_header *batadv_header = (struct batadv_header *)skb->data;
 	short vid __maybe_unused = -1;
-	bool is_bcast;
 	__be16 ethertype = __constant_htons(BATADV_ETH_P_BATMAN);
+	bool is_bcast;
 
 	is_bcast = (batadv_header->packet_type == BATADV_BCAST);
 
-- 
1.7.9.4

