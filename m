Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 12 Apr 2012 09:07:28 +0200
Message-Id: <1334214449-3996-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1334214449-3996-1-git-send-email-ordex@autistici.org>
References: <1334214449-3996-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 2/3] batman-adv: use static const for STP
	constant address
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

stp_addr is now declared as a simple "uint8_t []", but since it's content is
statically defined, it has to be declared as "static const uint8_t []"

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 soft-interface.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/soft-interface.c b/soft-interface.c
index f8a4a59..b56dafd 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -131,7 +131,8 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 	struct hard_iface *primary_if = NULL;
 	struct bcast_packet *bcast_packet;
 	struct vlan_ethhdr *vhdr;
-	uint8_t stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00, 0x00};
+	static const uint8_t stp_addr[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00,
+						   0x00};
 	unsigned int header_len = 0;
 	int data_len = skb->len, ret;
 	short vid __maybe_unused = -1;
-- 
1.7.9.4

