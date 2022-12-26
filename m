Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v3 0/5] Implementation of a Stateless Multicast Packet Type
Date: Mon, 26 Dec 2022 21:42:32 +0100
Message-Id: <20221226204237.10403-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

The following patchset implements a stateless, TVLV capable batman-adv
multicast packet type.

The new batman-adv multicast packet type allows to contain several
originator destination MAC addresses within a TVLV. Routers on the way wi=
ll
potentially split the batman-adv multicast packet and adjust its tracker
TVLV contents.

Routing decisions are still based on the selected BATMAN IV or BATMAN V
routing algorithm. So this new batman-adv multicast packet type retains
the same loop-free properties.

The purpose of this new packet type is to allow to forward an IP
multicast packet with less transmissions / overhead than the=20
multicast-via-multiple-unicasts approach. Or to reach a lot more
destinations (currently up to 196, depending on the payload size, see=20
Wiki documentation for details) than with the default multicast fanout
for the via-unicasts approach.

This will allow using applications like mDNS again in several Freifunk
communities. And with less transmissions will also make more bulky
multicast applications, like media streaming (to an assessable amount of
receivers) a lot more feasible.

This approach is way simpler than the original multicast (tracker) packet
approach we envisioned years ago. As it involves no maintenance of an
extra, state based multicast routing table. However the TVLV capability
should allow to extend things later, to split control and data plane a bi=
t=20
more for instance, to further increase the number of destinations, to
further reduce overhead.

A compact overview can be found in the Wiki here, including limitations:

https://www.open-mesh.org/projects/batman-adv/wiki/Multicast-Packet-Type

Regards, Linus

___

Changelog v3:
* PATCH 1/5:
  * remove now obsolete includes
* PATCH 2/5:
  * fix batadv_tvlv_handler_register() in network-coding.c
  * add missing include for linux/skbuff.h
  * move variable declarations out of the switch case
    in batadv_tvlv_call_handler()
* PATCH 3/5:
  * remove unnecessary include of multicast.h in routing.c
  * add a few missing includes to multicast_forw.c
    (linux/byteorder/generic.h, linux/errno.h, linux/gfp.h, linux/stddef.=
h
     uapi/linux/batadv_packet.h, multicast.h)
* PATCH 4/5:
  * add missing rcu_read_unlock() in error case before returning in
    batadv_mcast_forw_push_dests_list()
  * remove unnecessary include of soft-interface.h in multicast_forw.c
  * add a few missing includes to multicast_forw.c
    (linux/bug.h, linux/build_bug.h, linux/limits.h, linux/rculist.h,
     linux/rcupdate.h, linux/string.h)
  * make batadv_mcast_forw_mode_by_count() static
  * fix return types in the declaration of
    batadv_mcast_forw_packet_hdrlen() and batadv_mcast_forw_push()
    in multicast.h
  * fix typo in commit message: "that the are capable of"
    -> "that the*y* are capable of"
* PATCH 5/5:
  * make batadv_mcast_forw_shrink_pack_dests() adhere to 80 characters
    per line for consistency
  * add a "continue" statement after the jump label in
    batadv_mcast_forw_shrink_pack_dests() to silence the sparse error
    "error: label at end of compound statement"

Changelog v2:=20
* Add "[PATCH v2 0/5]" prefix to title of cover letter, so that
  Patchwork can hopefully find it - no other changes
