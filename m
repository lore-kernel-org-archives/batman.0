Return-Path: <bittorf@bluebottle.com>
Date: Thu, 12 Sep 2013 11:36:41 +0200
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20130912093641.GX1558@medion.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] fool batman by simulating a layer3 mesh
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

discussed in IRC, i'am searched for a better way to
load-balance a batman network. not the whole shaping/splashing
should run on one (central) node, so we needed something to stick it
to the node/AP which the user is connected to. than we have also
the ability to show a good page when the network is b0rken.

short overview:

NODE-1 (master/gateway)
ipv4: 192.168.1.1/16
dhcp: 192.168.1.x / gateway: 192.168.0.1
gateway: e.g. pppoe

NODE-2
ipv4: 192.168.2.1/16
dhcp: 192.168.2.x / gateway: 192.168.0.1
gateway: 192.168.1.1

NODE-3
ipv4: 192.168.3.1/16
dhcp: 192.168.3.x / gateway: 192.168.0.1
gateway: 192.168.1.1

the trick is, that every node offers DHCP which
does not interfere with other nodes AND offers a
gateway which is always the same: 192.168.0.1

if a user roams he simply moves on layer 1/2 and
its further working ok. important: the MAC of the
gateway should not change otherwise it's not working
for some seconds till the ARP times out. this can
be circumvented via kmod-macvlan:

ip link add link br-mybridge gateway0 address '02:00:c0:ca:c0:1a' type macvlan
ip address add 192.168.0.1/16 dev gateway0
ip link set dev gateway0 up

then the IP 192.168.0.1 is always reachable with the same MAC.
thats it. we can use the "normal" iptables/tc stuff like in
olsrd-networks...

giving out such dhcp-leases needs a fix to /etc/init.d/dhcp
which is available soon on OpenWrt mailinglist.

bye, bastian

PS:
thanks for the discussion and help, escpecially to T_X, ordex and marec
