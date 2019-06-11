Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v5 0/2] batman-adv: Add routable multicast optimizations
Date: Tue, 11 Jun 2019 22:58:39 +0200
Message-Id: <20190611205841.5841-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The following patchset fills the next gaps in the multicast address
rules page by adding support for group-aware optimizations for
multicast addresses of scope greater than link-local. So far, only
link-local addresses were optimized as packets with routable
addresses not only need to be forwarded to local multicast listeners
but also multicast routers.

"Handling rules depending on multicast address:" [0]

Before:

* Ipv4, link-local: supported without bridges
* IPv6, link-local: supported
* IPv4, routable: support planned.
* IPv6, routable: support planned.

After:

* Ipv4, link-local: supported without bridges
* IPv6, link-local: supported
* IPv4, routable: supported without bridges.
* IPv6, routable: supported.

Patch 1 adds the detection of multicast routers and announces
them via two new flags in its multicast TVLV. TVLV receivers will
memorize this and fill lists similar to how we already do for the
WANT_ALL_IPV4/IPV6 flags. Currently the detection for bridged-in
IPv6 multicast routers is not quite what the RFC for multicast router
discovery suggests. But once the MRD implementation in the Linux bridge
has matured a bit, I'm going to swap this simplified approach with
tapping into the bridge once more, asking the bridge for the presence of
multicast routers on the link. (This will then also add support for
"IPv4, routable, with bridges")

Then patch 2 implements the changes to the forwarding plane,
utilizing the new information we have gathered with the second patch.

Regards, Linus

[0]:
https://www.open-mesh.org/projects/batman-adv/wiki/Multicast-optimizations-tech#Handling-rules-depending-on-multicast-address

---

Changelog v5:

* updated commit message of [PATCH 1/2] with
  BATADV_MCAST_WANT_ALL_RTR{4,6} -> BATADV_MCAST_WANT_NO_RTR{4,6}
* now unsetting BATADV_MCAST_WANT_NO_RTR{4,6} in own tvlv flags
  (batadv_mcast_mla_flags_get() ) if BATADV_MCAST_WANT_ALL_IPV{4,6}
  is already set, to be able to reuse this combination to signalize
  want-all-link-local in the future - [PATCH 1/2]
* "routeable" -> "routable"

Changelog v4:

* rebased to master
* BATADV_MCAST_WANT_ALL_RTR{4,6} -> BATADV_MCAST_WANT_NO_RTR{4,6}
  => swapped the name of this flag and according logic in the code in
[PATCH 1/2]
  => swapped the name in the kerneldoc in [PATCH 2/2]

Changelog v3:

* rebased to master + routeable multicast preparations v4
* fixed build errors with CONFIG_IPV6_MROUTE disabled
* fixed build errors with CONFIG_IPV6 disabled

Changelog v2:

* rebased to master
* split patchset in two with the intention to ease reviewing
  (no code changes, just the last two patches here)

* removed unncessarilly added newline in batadv_mcast_flags_log()
  [PATCH 5/6] / [PATCH v2 1/2]
* kerneldoc: @BATADV_MCAST_NO_WANT_ALL_RTR6 -> -"NO_"
  in enum batadv_mcast_flags [PATCH 5/6] / [PATCH v2 1/2]




