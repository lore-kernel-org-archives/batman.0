Return-Path: <mschiffer@universe-factory.net>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Date: Thu, 17 Mar 2016 17:45:30 +0100
Message-Id: <cover.1458231707.git.mschiffer@universe-factory.net>
Subject: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

Hi,
this is the second take of my netlink API patches. As mentioned before, the
netlink API is superior to the current debugfs API in many aspects:

* debugfs is broken (see PATCH 1 for details)
* Netlink is namespace-aware, and can be used in unprivileged containers
  without problems
* Netlink packets are more machine-readable than text files, and can be
  easily extended without potentially breaking userspace
* On older kernels, seq_file can't fall back to vmalloc if kmalloc fails,
  which often leads to OOM when reading "originators" in large meshes, as
  the whole file must fit into a single buffer

Of course, are also a few downsides; when the data is too big to fit into
a single netlink packet, the provided data may be inconsistent (entries may
be missing or duplicated.) This will happen in large meshes only, and be
improbable in any case.

The patches have been developed on top of the netns patchset, but should
be applicable independently (maybe with minor changes.)

All netlink queries returning lists of any kind can only be used with
NLM_F_DUMP queries, so that arbitrarity large responses are possible (split
across multiple packets if necessary.)

At the moment, the following debugfs files have corresponding netlink APIs:

* routing_algos
* neighbors
* originators
* transtable_global
* transtable_local
* (hardinterfaces for a softif can be queried)

The following files are still missing:

* gateways
* bla_claim_table
* bla_backbone_table
* dat_cache
* nc_nodes

Obviously, documentation is also a TODO. Comments about the API design are
very welcome...

Regards,
Matthias


Matthias Schiffer (5):
  batman-adv: add generic netlink query API to replace debugfs files
  batman-adv: netlink: add translation table query
  batman-adv: netlink: add originator and neighbor table queries
  batman-adv: add B.A.T.M.A.N. IV bat_{orig,neigh}_dump implementations
  batman-adv: add B.A.T.M.A.N. V bat_{orig,neigh}_dump implementations

 Makefile                           |   1 +
 include/uapi/linux/batman_adv.h    | 101 ++++++++++++
 net/batman-adv/Makefile            |   1 +
 net/batman-adv/bat_iv_ogm.c        | 268 ++++++++++++++++++++++++++++++++
 net/batman-adv/bat_v.c             | 250 ++++++++++++++++++++++++++++++
 net/batman-adv/main.c              |  48 ++++++
 net/batman-adv/main.h              |   1 +
 net/batman-adv/netlink.c           | 276 +++++++++++++++++++++++++++++++++
 net/batman-adv/netlink.h           |  36 +++++
 net/batman-adv/originator.c        | 142 +++++++++++++++++
 net/batman-adv/originator.h        |   2 +
 net/batman-adv/packet.h            |  36 -----
 net/batman-adv/translation-table.c | 305 +++++++++++++++++++++++++++++++++++++
 net/batman-adv/translation-table.h |   2 +
 net/batman-adv/types.h             |   7 +
 15 files changed, 1440 insertions(+), 36 deletions(-)
 create mode 100644 include/uapi/linux/batman_adv.h
 create mode 100644 net/batman-adv/netlink.c
 create mode 100644 net/batman-adv/netlink.h

-- 
2.7.3

