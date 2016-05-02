Return-Path: <kauer@biplane.com.au>
Message-ID: <1462190269.1971.52.camel@biplane.com.au>
From: Karl Auer <kauer@biplane.com.au>
Date: Mon, 02 May 2016 21:57:49 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] mesh losing internal Ilayer3 connectivity
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: BATMAN List <b.a.t.m.a.n@lists.open-mesh.org>

My apologies up front for a newbie question in this apparently very
technical list. If there is a more appropriate list or forum please
direct me to it.

I'm running batman-adv (Chaos Calmer, r47065) on OpenWRT on the GL
-AR150 platform. It all works swimmingly, except that sometimes, for no
apparent reason, layer 3 connectivity across the mesh (inside it) is
lost. All nodes are still up and running and I can log into them via
their APs or their LAN interfaces. batctl on any node still sees all
the other nodes, and batctl can ping them by MAC address. Each node
still has its layer3 address and can ping it locally. The arp data for
the other nodes is correct (at least in my two-node test system). I
don't seem to be able to delete arp entries.

But no node can ping any other node by IP address. Restarting
networking on any or even all nodes doesn't help - all that helps is
rebooting everything.

As long as my mesh is six nodes on a table, rebooting everything is an
option. Once deployed - not so much :-)

It's possible to engineer this failure in a two-node mesh by just
restarting networking a few times quickly.

So I'm wondering a) if this is a known issue b) if this is an obvious
symptom of some stuff-up on my part, c) if there's a quick fix :-) and
d) failing all of the above whether there is some way out of the
situation without having to reboot every time.

The mesh has one node configured as a gateway, connected to an
upstream, and running DHCP on the bat interface. The other nodes are
configured as gateway clients and have nothing connected on their LAN
or WAN ports. All nodes have a static address on the bat0 interface,
all have a static route to the gateway's (inside) IP address. All have
an AP on the same radio as the mesh, with an RFC1918 network on it
masqueraded into the mesh.

And mostly, it works :-)

Yours hopefully, K.

-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Karl Auer (kauer@biplane.com.au)
http://www.biplane.com.au/kauer
http://twitter.com/kauer389

GPG fingerprint: E00D 64ED 9C6A 8605 21E0 0ED0 EE64 2BEE CBCB C38B
Old fingerprint: 3C41 82BE A9E7 99A1 B931 5AE7 7638 0147 2C3C 2AC4



