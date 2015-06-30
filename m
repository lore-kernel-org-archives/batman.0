Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 30 Jun 2015 23:45:26 +0200
Message-Id: <1435700726-6607-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix potentially broken skb
 network header access
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

The two commits noted below added calls to ip_hdr() and ipv6_hdr(). They
need a correctly set skb network header.

Unfortunately we cannot rely on the device drivers to set it for us.
Therefore setting it in the beginning of the according ndo_start_xmit
handler.

Fixes: 405cc1e5 ("batman-adv: Modified forwarding behaviour for multicast packets")
Fixes: 1c090349 ("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---

Three notes:

* Pending question on netdev, we should probably wait a few more days
  before applying this patch.

* Back in Nov. 2014 for the original multicast bridge patchset Simon
  suggested moving the skb_set_network_header() call to within the according
  multicast functions:
  https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-November/012573.html

  I would like to submit patches for master afterwards
  though to change some raw skb->data access and hdr_size math to
  skb_network_header() calls as I think they might be easier to read and safer.
  (for skb->data you always have to go back the whole call chain and check
   for any skb pulls etc. to know where skb->data points to, same for hdr_size
   to know it's value as it's passed through mutliple layers of functions)

  So I thought it'd be good to have the skb_set_network_header() in a good
  place for that already.

* The "network_offset += VETH_HLEN" is not strictly necessary since the
  multicast optimizations won't apply for vlans yet and the ip_hdr()/ipv6_hdr()
  calls are never reached in that case. But again, I thought it would be cleaner
  that way.

 soft-interface.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/soft-interface.c b/soft-interface.c
index 7841a4b..eb87fd9 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -178,6 +178,7 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	int gw_mode;
 	enum batadv_forw_mode forw_mode;
 	struct batadv_orig_node *mcast_single_orig = NULL;
+	int network_offset = ETH_HLEN;
 
 	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto dropped;
@@ -190,14 +191,18 @@ static int batadv_interface_tx(struct sk_buff *skb,
 	case ETH_P_8021Q:
 		vhdr = vlan_eth_hdr(skb);
 
-		if (vhdr->h_vlan_encapsulated_proto != ethertype)
+		if (vhdr->h_vlan_encapsulated_proto != ethertype) {
+			network_offset += VLAN_HLEN;
 			break;
+		}
 
 		/* fall through */
 	case ETH_P_BATMAN:
 		goto dropped;
 	}
 
+	skb_set_network_header(skb, network_offset);
+
 	if (batadv_bla_tx(bat_priv, skb, vid))
 		goto dropped;
 
-- 
1.7.10.4

