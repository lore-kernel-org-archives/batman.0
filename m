Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 27 May 2013 21:43:00 +0200
Message-Id: <1369683792-531-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv3 00/12] make the Translation Table component
	VLAN-aware
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
Cc: Antonio Quartulli <ordex@autistici.org>

Hello people,

with this patchset I want to introduce a new feature in the TT code which makes
it VLAN aware. This means that now clients belonging to different VLANs created
on top of a generic bat0 are treated differently.

One of the major reason for bringing this change is to allow BLA to selectively
ignore TT entries belonging to a given VLAN.
To allow the latter behaviour, the CRC logic has been divided on a per-VLAN
basis. This means that the local TT table is logically divided in sub-tables
containing all the entries belonging to the same VLAN and the CRC is then
computed on each of them.
As a natural consequence, each node now stores a set of local CRCs instead of
one only. Due to this also the way the TVLV-TT object is built and announced has
been changed.


This patchset gives the possibility to:
- enable AP isolation only on a selected VLAN rather than on all the traffic
- make DAT work correctly when the same IP subnet is used on different VLANs
- make BLA refuse global entries from certain VLANs
- leave the possibility to future developers to implement more VLAN specific
  attributes


This patchset is based on top of: "batman-adv: fix typo in kernel doc"

Changes from v2:
- CRC logic divided on a VLAN-basis
- BLA can now select the TT entries to ignore based on the VLAN

Changes from v1:
- improved kernel doc
- created batadv_get_vid() function
- improved documentation for CRC computation
- added compat code for kfree_rcu (struct batadv_priv_vlan)


Cheers,

Antonio Quartulli (12):
  batman-adv: implement batadv_tt_entries
  batman-adv: avoid cast by using void pointer as argument
  batman-adv: add the VLAN ID attribute to the TT entry
  batman-adv: use vid when computing local and global TT CRC
  batman-adv: print the VID together with the TT entries
  batman-adv: make the GW module correctly talk to the new VLAN-TT
  batman-adv: make the Distributed ARP Table vlan aware
  batman-adv: add per VLAN interface attribute framework
  batman-adv: make the AP isolation attribute VLAN specific
  batman-adv: make the backbone gw check VLAN specific
  batman-adv: make the TT global purge routine VLAN specific
  batman-adv: make the TT RC logic VLAN specific

 bridge_loop_avoidance.c |   58 ++-
 bridge_loop_avoidance.h |   10 +-
 compat.c                |   18 +
 compat.h                |   25 ++
 distributed-arp-table.c |  125 ++++--
 gateway_client.c        |   18 +-
 main.c                  |   72 +++-
 main.h                  |   13 +-
 originator.c            |  100 ++++-
 originator.h            |    7 +
 packet.h                |   30 +-
 routing.c               |   28 +-
 send.c                  |    8 +-
 send.h                  |   16 +-
 soft-interface.c        |  158 ++++++-
 sysfs.c                 |  140 ++++++
 sysfs.h                 |   10 +
 translation-table.c     | 1080 +++++++++++++++++++++++++++++++++++------------
 translation-table.h     |   23 +-
 types.h                 |   66 ++-
 20 files changed, 1599 insertions(+), 406 deletions(-)

-- 
1.8.1.5

