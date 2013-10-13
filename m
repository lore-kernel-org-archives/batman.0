Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sun, 13 Oct 2013 02:50:16 +0200
Message-Id: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv2 0/4] Introduce the SYNCHRONIZED TT flags
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


Hello list,

as some of you may know, each TT client store in a node local/global table is
also accompanied by a set of flags some of which are of global interest (every
node in the network needs to know if this flag is set or not).

However it may happen that a flag may be unset (or set) after that a TT client
has already be announced. With the current implementation there is no way for
the nodes to detect this event and to react accordingly.

With this patchset we introduce all those means needed to synchronize a selected
subset of TT flags among the network.
Flags belonging to this set are the "Synchronized TT flags".

Right now only the WIFI flag belongs to this set, but another on is already
planned to be added soonish.

Cheers,


[This patchset is based on top of origin/simon/network-wide-multiif]


Antonio Quartulli (4):
  batman-adv: don't switch byte order too often if not needed
  batman-adv: invoke dev_get_by_index() outside of is_wifi_iface()
  batman-adv: improve the TT component to support runtime flag changes
  batman-adv: include the synch-flags when compute the global/local
    table CRC

 hard-interface.c    | 31 +++----------------------------
 hard-interface.h    |  1 -
 packet.h            | 17 +++++++++++++++--
 routing.c           |  8 +++++---
 translation-table.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 73 insertions(+), 36 deletions(-)

-- 
1.8.3.2

