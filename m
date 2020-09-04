Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH maint v2 0/4] batman-adv: mcast: TT/BLA fixes
Date: Fri,  4 Sep 2020 20:27:59 +0200
Message-Id: <20200904182803.8428-1-linus.luessing@c0d3.blue>
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

Hi,

These are four fixes for issues which occur when using the batman-adv
multicast-to-unicast feature.

The first one fixes an issue of an intermediate node snitching
multicast-to-unicast packets and either dropping it or rerouting it to
another node. Which causes lost packets on some and duplicate packets on
other nodes.

Patches 2 to 4 fix issues when using the multicast-to-unicast conversion
while BLA is enabled and some nodes are sharing the same LAN side. Here
it either causes "just" duplicates in the "good" scenario (Patch 4/4).
But can also cause multiple BLA backbones to send a frame from the mesh
into the same, shared LAN segment (Patch 3). Or in the worst case, even
reflect packets back to the host in the shared LAN, which completely
confuses switches/bridges and ICMPv6 Neighbor Discovery.

Changelog v2:
* Adding "Fixes:" lines

Regards, Linus

