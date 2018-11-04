Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Nov 2018 20:33:12 +0100
Message-Id: <20181104193314.18104-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 0/2] batman-adv: netlink restructuring, part 2
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
Cc: Jiri Pirko <jiri@mellanox.com>, Sven Eckelmann <sven@narfation.org>

Hi,

Jiri Pirko called the batman-adv configuration interface a while back "a
huge mistake" [1] and suggested genl as alternative. But it is not
completely clear what he meant by that. I had a look at the implementation
in team and devlink (he is maintainer of both). Unfortunately, both work in
slightly different ways. But they seem to have in common that there are
different classes of configuration options/params which then have their own
set of commands. But each set of command works for multiple options/params.

I have tried to replicate something similar with this implementation. It
might be important to point out that it requires multiple messages when
trying to change multiple options (e.g. modification of gw_bandwidth_down
and gw_bandwidth_up require two messages). This should be more like devlink
and not like team. But it directly sends the new options back via
genlmsg_multicast to all subscribers of the "config" mcast group. There is
also currently no nesting of attributes.

The code is basically around the triplet name-type-value. All three are
required for set operations, name is required for get operations and
nothing of the triplet is required for dump operations (because it will
create messages containing this triplet). The different classes of options
also require as input:

* mesh interface (the batadv device)
  - meshif_index
* hard interface specific  (the enslaved devices)
  - meshif_index
  - hardif_index
* vlan specific (vlan on top of the mesh interface)
  - meshif_index
  - vlan id

Luckily, Jiri Pirko told us that he will have a look at patches. Here are
two patches with an initial implementation. I might have to split them
futher - maybe three patches for the infrastructure part and a couple for
the import of the sysfs options in the new infrastructure. I am happy to
receive suggestions how I should split them.

There is also some potential in reducing the shared code for the .doit
commands by moving the BATADV_ATTR_MESH_IFINDEX -> bat_priv code to .pre
and .post handlers.

Kind regards,
	Sven

[1] https://www.open-mesh.org/issues/300

Sven Eckelmann (2):
  batman-adv: Add infrastructure for netlink config manipulation
  batman-adv: Convert existing sysfs options to netlink

 include/uapi/linux/batman_adv.h |   55 +
 net/batman-adv/Makefile         |    1 +
 net/batman-adv/netlink.c        |   50 +-
 net/batman-adv/netlink.h        |    6 +
 net/batman-adv/netlink_cfg.c    | 2096 +++++++++++++++++++++++++++++++
 net/batman-adv/netlink_cfg.h    |   78 ++
 6 files changed, 2280 insertions(+), 6 deletions(-)
 create mode 100644 net/batman-adv/netlink_cfg.c
 create mode 100644 net/batman-adv/netlink_cfg.h

-- 
2.19.1

