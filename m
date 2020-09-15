Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH maint v5 0/3] batman-adv: mcast: BLA fixes
Date: Tue, 15 Sep 2020 09:54:07 +0200
Message-Id: <20200915075410.13932-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

These are three fixes for issues which occur when using the batman-adv
multicast-to-unicast feature.

They fix issues when using the multicast-to-unicast conversion
while BLA is enabled and some nodes are sharing the same LAN side. Here
it either causes "just" duplicates in the "good" scenario (Patch 3/3).
But can also cause multiple BLA backbones to send a frame from the mesh
into the same, shared LAN segment (Patch 2/3). Or in the worst case, even
reflect packets back to the host in the shared LAN, which completely
confuses switches/bridges and ICMPv6 Neighbor Discovery (Patch 1/3).

Regards, Linus

---

Changelog v6:
* Patch 3/3:
  - removed "is_for_same_orig" variable again and call "continue" directl=
y

Changelog v5:
* Patch 3/3:
  - added missing "*" in kernel doc for batadv_bla_check_duplist()

Changelog v4:
* Patch 1/3:
  - fixed build with CONFIG_BATMAN_ADV_MCAST=3Dn
    -> dummy for batadv_mcast_forw_send_orig()
* Patch 2/3:
  - fixed parameters for batadv_bla_rx() with CONFIG_BATMAN_ADV_BLA=3Dn
    (bool is_bcast -> int packet_type)

Changelog v3:
* removed 1/4, as it was already applied
* renamed title (excluded TT, as already applied)

* Patch 1/3:
  - moved bla-backbone check into multicast code:
    -> to stay on the safe side for net, to touch less other code
       paths - the issue was observed specifically for multicast
       and the fix was tested for that
  - added a note regarding implications for mcast-fanout
* Patch 2/3:
  - previous approach was broken, it would break the DHCPv6 gateway
    code; instead distinguish by batadv 3 vs. 4 addr unicast header
  - added some more code comments
  - updated commit message with new approach
* Patch 3/3:
  - made code a bit more verbose and explicit
  - added some more code comments
  - added missing kernel doc for "orig" parameter to
    new batadv_bla_check_duplist()

Changelog v2:
* Adding "Fixes:" lines
