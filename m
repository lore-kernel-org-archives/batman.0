Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 23 Apr 2013 23:45:24 +0200
Message-Id: <1366753527-17171-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/3] introduce the SYNCHRONIZED TT flags
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

Some TT flags can change at runtime and for this reason all the nodes in the
mesh network must track and possibly update them.
An existing example is the Wifi flag.

This patchset introduces all those needed changes in order to synchronize client
flags that requires such treatment.

Cheers,

This code is based on top of ordex/tt-vlan

Antonio Quartulli (3):
  batman-adv: invoke dev_get_by_index() outside of is_wifi_iface()
  batman-adv: improve TT component to support runtime flag changes
  batman-adv: compute the global/local table CRC using the synch flags

 hard-interface.c    | 33 ++++-----------------------------
 hard-interface.h    |  2 +-
 packet.h            | 14 +++++++++++++-
 translation-table.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 67 insertions(+), 32 deletions(-)

-- 
1.8.1.5

