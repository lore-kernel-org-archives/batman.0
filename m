Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 23 Apr 2013 16:34:28 +0200
Message-Id: <1366727676-23233-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/7] make the Translation Table component
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

This change gives the possibility to:
- enable AP isolation only on a selected VLAN rather than on all the traffic
- make DAT work correctly when the same IP subnet is used on different VLANs
- leave the possibility to future developers to implement more VLAN specific
  attributes

This code is based on top of hundeboll/fragmentation.


Cheers,

Antonio Quartulli (7):
  batman-adv: add the VLAN ID attribute to the TT entry
  batman-adv: use vid when computing local and global TT CRC
  batman-adv: print the VID together with the TT entries
  batman-adv: make the GW module correctly talk to the new VLAN-TT
  batman-adv: make the Distributed ARP Table vlan aware
  batman-adv: add per VLAN interface attribute framework
  batman-adv: make the AP isolation attribute VLAN specific

 distributed-arp-table.c | 129 ++++++++++++------
 gateway_client.c        |  10 +-
 main.c                  |  46 ++++++-
 main.h                  |  11 +-
 packet.h                |  12 ++
 routing.c               |  27 +++-
 send.c                  |   8 +-
 send.h                  |  16 ++-
 soft-interface.c        |  99 ++++++++++++--
 sysfs.c                 | 140 ++++++++++++++++++++
 sysfs.h                 |  10 ++
 translation-table.c     | 343 +++++++++++++++++++++++++++++++++++-------------
 translation-table.h     |  25 ++--
 types.h                 |  27 ++++
 14 files changed, 732 insertions(+), 171 deletions(-)

-- 
1.8.1.5

