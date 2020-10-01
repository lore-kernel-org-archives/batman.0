Return-Path: <sd@queasysnail.net>
From: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net 00/12] net: iflink and link-netnsid fixes
Date: Thu,  1 Oct 2020 09:59:24 +0200
Message-Id: <cover.1600770261.git.sd@queasysnail.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>

In a lot of places, we use this kind of comparison to detect if a
device has a lower link:

  dev->ifindex !=3D dev_get_iflink(dev)

This seems to be a leftover of the pre-netns days, when the ifindex
was unique over the whole system. Nowadays, with network namespaces,
it's very easy to create a device with the same ifindex as its lower
link:

    ip netns add main
    ip netns add peer
    ip -net main link add dummy0 type dummy
    ip -net main link add link dummy0 macvlan0 netns peer type macvlan
    ip -net main link show type dummy
        9: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop ...
    ip -net peer link show type macvlan
        9: macvlan0@if9: <BROADCAST,MULTICAST> mtu 1500 qdisc noop ...

To detect if a device has a lower link, we can simply check the
existence of the dev->netdev_ops->ndo_get_iflink operation, instead of
checking its return value. In particular, I attempted to fix one of
these checks in commit feadc4b6cf42 ("rtnetlink: always put IFLA_LINK
for links with a link-netnsid"), but this patch isn't correct, since
tunnel devices can export IFLA_LINK_NETNSID without IFLA_LINK. That
patch needs to be reverted.

This series will fix all those bogus comparisons, and export missing
IFLA_LINK_NETNSID attributes in bridge and ipv6 dumps.

ipvlan and geneve are also missing the get_link_net operation, so
userspace can't know when those device are cross-netns. There are a
couple of other device types that have an ndo_get_iflink op but no
get_link_net (virt_wifi, ipoib), and should probably also have a
get_link_net.

Sabrina Dubroca (12):
  ipvlan: add get_link_net
  geneve: add get_link_net
  Revert "rtnetlink: always put IFLA_LINK for links with a link-netnsid"
  rtnetlink: always put IFLA_LINK for links with ndo_get_iflink
  bridge: always put IFLA_LINK for ports with ndo_get_iflink
  bridge: advertise IFLA_LINK_NETNSID when dumping bridge ports
  ipv6: always put IFLA_LINK for devices with ndo_get_iflink
  ipv6: advertise IFLA_LINK_NETNSID when dumping ipv6 addresses
  net: link_watch: fix operstate when the link has the same index as the
    device
  net: link_watch: fix detection of urgent events
  batman-adv: fix iflink detection in batadv_is_on_batman_iface
  batman-adv: fix detection of lower link in batadv_get_real_netdevice

 drivers/net/can/vxcan.c          |  2 +-
 drivers/net/geneve.c             |  8 ++++++++
 drivers/net/ipvlan/ipvlan_main.c |  9 +++++++++
 drivers/net/veth.c               |  2 +-
 include/net/rtnetlink.h          |  4 ++++
 net/batman-adv/hard-interface.c  |  4 ++--
 net/bridge/br_netlink.c          |  4 +++-
 net/core/link_watch.c            |  4 ++--
 net/core/rtnetlink.c             | 25 ++++++++++++-------------
 net/ipv6/addrconf.c              | 11 ++++++++++-
 10 files changed, 52 insertions(+), 21 deletions(-)

--=20
2.28.0

