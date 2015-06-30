Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 30 Jun 2015 04:01:02 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150630020101.GD2897@odroid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Caller or callee setting skb->network_header?
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
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org

Hi,

For an .ndo_start_xmit handler, can the callee rely on the caller
setting the skb network header?

Or should the callee set it before performing any
skb_network_header()/ip_hdr()/ipv6_hdr()/... calls?

Cheers, Linus

PS: Currently looking at batman-adv's ndo_start_xmit handler
"interface_tx()", whether an skb_set_network_header() should be
added there as it uses ip_hdr()/ipv6_hdr() later
(-> batadv_mcast_forw_mode_check_ipv{4,6}()). Testing this in
VMs it seemed to be set correctly by the caller, but wanted to
check whether this can or shouldn't be relied on.
