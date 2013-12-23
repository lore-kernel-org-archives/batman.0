Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 23 Dec 2013 01:28:05 +0100
Message-Id: <1387758485-3568-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1387758485-3568-1-git-send-email-antonio@meshcoding.com>
References: <1387758485-3568-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: clean nf state when
	removing protocol header
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

If an interface enslaved into batman-adv is a bridge (or a
virtual interface built on top of a bridge) the nf_bridge
member of the skbs reaching the soft-interface is filled
with the state about "netfilter bridge" operations.

Then, if one of such skbs is locally delivered, the nf_bridge
member should be cleaned up to avoid that the old state
could mess up with other "netfilter bridge" operations when
entering a second bridge.
This is needed because batman-adv is an encapsulation
protocol.

However at the moment skb->nf_bridge is not released at all
leading to bogus "netfilter bridge" behaviours.

Fix this by cleaning the netfilter state of the skb before
it gets delivered to the upper layer in interface_rx().

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 soft-interface.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index 33b6144..08086cf 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -324,6 +324,11 @@ void batadv_interface_rx(struct net_device *soft_iface,
 	skb_pull_rcsum(skb, hdr_size);
 	skb_reset_mac_header(skb);
 
+	/* clean the netfilter state now that the batman-adv header has been
+	 * removed
+	 */
+	nf_reset(skb);
+
 	ethhdr = eth_hdr(skb);
 
 	switch (ntohs(ethhdr->h_proto)) {
-- 
1.8.5.2

