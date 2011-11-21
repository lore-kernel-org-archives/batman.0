Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 21 Nov 2011 22:37:59 +0100
Message-Id: <1321911479-23444-1-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1320752062-21776-1-git-send-email-ordex@autistici.org>
References: <1320752062-21776-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: fix two issues in DAT
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

 * use CONFIG_BATMAN_ADV_DAT instead of CONFIG_BATMAN_ADV_BAT
 * use skb_reset_mac_header() to avoid crashes because of null pointers
   within arp_get_type()

I've reviewed the DAT patchset, all of the previous comments have been
integrated well. It also runs well within my VMs (after applying this
patch).

Please integrate this patch into the previous one and resend it. You
may add my Reviewed-By tag.

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
---
 distributed-arp-table.h |    2 +-
 soft-interface.c        |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/distributed-arp-table.h b/distributed-arp-table.h
index 496b7f3..bd32c89 100644
--- a/distributed-arp-table.h
+++ b/distributed-arp-table.h
@@ -28,7 +28,7 @@
 #define ARP_HW_DST(skb) (ARP_HW_SRC(skb) + ETH_ALEN + 4)
 #define ARP_IP_DST(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN * 2 + 4))
 
-#ifdef CONFIG_BATMAN_ADV_BAT
+#ifdef CONFIG_BATMAN_ADV_DAT
 
 uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb);
 bool arp_snoop_outgoing_request(struct bat_priv *bat_priv,
diff --git a/soft-interface.c b/soft-interface.c
index 9107b22..786bc71 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -592,6 +592,8 @@ static int interface_tx(struct sk_buff *skb, struct net_device *soft_iface)
 		goto end;
 	}
 
+	skb_reset_mac_header(skb);
+
 	/**
 	 * if we have a another chosen mesh exit node in range
 	 * it will transport the packets to the mesh
-- 
1.7.7.2

