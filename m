Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  6 Aug 2013 10:09:52 +0200
Message-Id: <1375776594-301-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/2] TT-VLAN: BLA2 integration
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

this is the last patchset of the TT-VLAN series and requires the last one to be
applied (per-VLAN TT CRC).

In a few words...
These changes enable BLA2 to filter only those TT entries belonging to the VLAN
where BLA discovered other backbone nodes. The current code instead assumes that
_all_ the local clients are shared among the backbones, despite of the VLAN used
to interconnect them.

Example.
Imagine 2 nodes having several vlans over the wired connection.
Node1 having eth0.1 and eth0.2
Node2 having eth0.1 and eth0.3

Node1 and Node2 are connected using a cable and so they hear each other on
eth0.1.
Clients connected to eth0.2 and eth0.3 are reachable only through the respective
nodes therefore, if Node1 wanted to talk to a client connected to eth0.3 needs
to know that it is served by Node2.

In the current implementation this is not possible because BLA would consider
all the clients reachable through any node of the LAN and will reject all the
global TT entries from any other backbone, so losing this TT information.

With this patchset, instead, BLA will detect that the backbone
connection is only over eth0.1 and so will continue to store all the global
clients belonging to the other VLANs.


I hope the example did not create more confusion :)

Cheers,


Antonio Quartulli (2):
  batman-adv: make the TT global purge routine VLAN specific
  batman-adv: make the backbone gw check VLAN specific

 bridge_loop_avoidance.c | 23 +++++++++++---------
 bridge_loop_avoidance.h | 10 +++++----
 originator.c            |  2 +-
 routing.c               |  2 +-
 translation-table.c     | 58 ++++++++++++++++++++++---------------------------
 translation-table.h     |  2 +-
 6 files changed, 48 insertions(+), 49 deletions(-)

-- 
1.8.1.5

