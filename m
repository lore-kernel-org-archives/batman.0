Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 17 Sep 2010 17:40:56 +0200
Message-Id: <1284738065-8715-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCHv2 0/9] RCU locking patches
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

i tried to prevent the race condition [1] that I mentioned yesterday. The
patchset was also slightly extended to use a refcnt a little bit more.

Best regards,
	Sven

[1] 201009170317.28338.sven.eckelmann@gmx.de

Sven Eckelmann (9):
      batman-adv: Introduce if_list_lock to protect if_list
      batman-adv: Protect update side of gw_list
      batman-adv: Always protect list_for_each_entry_rcu with RCU
      batman-adv: Remove unneeded rcu_read_lock
      batman-adv: Use synchronize_rcu instead of call_rcu
      batman-adv: Use refcnt to track usage count of gw_node
      batman-adv: Use refcnt to track usage count of batman_if
      batman-adv: count election of gateway as reference
      batman-adv: count batman_if list queries as reference

 batman-adv/bat_sysfs.c      |   37 ++++++++++++++++++-------
 batman-adv/gateway_client.c |   64 ++++++++++++++++++++++++++++++-------------
 batman-adv/hard-interface.c |   59 +++++++++++++++++++++++++++++-----------
 batman-adv/hard-interface.h |   13 +++++++++
 batman-adv/originator.c     |    2 -
 batman-adv/routing.c        |    2 +
 batman-adv/types.h          |    4 +-
 7 files changed, 132 insertions(+), 49 deletions(-)
