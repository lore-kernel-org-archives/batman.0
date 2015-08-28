Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Fri, 28 Aug 2015 11:12:26 +0200
Message-Id: <1440753156-7808-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 20150828
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello David,

this is our very last batch of patches intended for net-next/linux-4.3

It includes again 2 non-critical fixes which we couldn't send to net
and then the rest is just code restyling and beautification. No
major behavioural change was introduced.

Please pull or let me know of any problem!

Thanks a lot,
	Antonio


The following changes since commit 1dd34b5ad8aebaff17b625fc0126e18243008a3f:

  bpf: fix bpf_skb_set_tunnel_key() helper (2015-08-26 17:38:13 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to ed29266347025a19ee689807b07d121f0a7441f1:

  batman-adv: turn batadv_neigh_node_get() into local function (2015-08-27 20:15:34 +0200)

----------------------------------------------------------------
Included changes:
- code beautification
- remove obsolete 'deleted' attribute for bat-gw node
- increase internal version number
- prevent potential access to netdev object after deregistration
- set needed_head/tail_room for batman virtual interface

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: don't access unregistered net_device object

Marek Lindner (5):
      batman-adv: move hardif refcount inc to batadv_neigh_node_new()
      batman-adv: remove redundant hard_iface assignment
      batman-adv: move neigh_node list add into batadv_neigh_node_new()
      batman-adv: rearrange batadv_neigh_node_new() arguments to follow convention
      batman-adv: turn batadv_neigh_node_get() into local function

Simon Wunderlich (3):
      batman-adv: remove obsolete deleted attribute for gateway node
      batman-adv: fix gateway client style issues
      batman-adv: Start new development cycle

Sven Eckelmann (1):
      batman-adv: Add lower layer needed_(head|tail)room to own ones

 net/batman-adv/bat_iv_ogm.c     | 30 +-------------
 net/batman-adv/gateway_client.c | 50 ++++++-----------------
 net/batman-adv/gateway_client.h |  2 +-
 net/batman-adv/hard-interface.c | 44 +++++++++++++++++++-
 net/batman-adv/main.c           |  2 +-
 net/batman-adv/main.h           |  2 +-
 net/batman-adv/originator.c     | 90 ++++++++++++++++++++++++-----------------
 net/batman-adv/originator.h     |  9 ++---
 net/batman-adv/soft-interface.c |  2 -
 net/batman-adv/types.h          |  2 -
 10 files changed, 117 insertions(+), 116 deletions(-)
