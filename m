Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 23 Nov 2018 17:13:40 +0100
Message-Id: <20181123161359.13342-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v2 00/19] batman-adv: netlink restructuring,
 part 2
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
Cc: Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org, Sven Eckelmann <sven@narfation.org>

Hi,

Jiri Pirko called the batman-adv configuration interface a while back "a
huge mistake" [1] and suggested genl as alternative. The first
reimplementation [2] (based on the team/devlink design) was rejected. This
second implementation is now using a nl80211-like design. The objects
which can now be modified/queried are:

* mesh/soft-interface (BATADV_CMD_GET_MESH/BATADV_CMD_SET_MESH)
* slave/hard-interface (BATADV_CMD_GET_HARDIF/BATADV_CMD_SET_HARDIF)
* vlan (BATADV_CMD_GET_VLAN/BATADV_CMD_SET_VLAN)

Such a set messages automatically triggers a *_SET_* "reply" via the config
multicast group. The same behavior was also added to the sysfs interface.

Luckily, Jiri Pirko told us that he will have a look at patches. I would
also like to ask the other developers to check whether their configuration
values are represented correctly. And please also check whether the current
implementation might collide with some other features which you might have
in your pipeline.

v2:
* rewrite everything in a more nl80211-like message/attribute format.

Kind regards,
        Sven

[1] https://www.open-mesh.org/issues/300
[2] https://patchwork.open-mesh.org/cover/17610/

Sven Eckelmann (19):
  batman-adv: Move common genl doit code pre/post hooks
  batman-adv: Prepare framework for mesh genl config
  batman-adv: Prepare framework for hardif genl config
  batman-adv: Prepare framework for vlan genl config
  batman-adv: Add aggregated_ogms mesh genl configuration
  batman-adv: Add ap_isolation mesh/vlan genl configuration
  batman-adv: Add bonding mesh genl configuration
  batman-adv: Add bridge_loop_avoidance mesh genl configuration
  batman-adv: Add distributed_arp_table mesh genl configuration
  batman-adv: Add fragmentation mesh genl configuration
  batman-adv: Add gateway mesh genl configuration
  batman-adv: Add hop_penalty mesh genl configuration
  batman-adv: Add log_level mesh genl configuration
  batman-adv: Add multicast_mode mesh genl configuration
  batman-adv: Add network_coding mesh genl configuration
  batman-adv: Add orig_interval mesh genl configuration
  batman-adv: Add elp_interval hardif genl configuration
  batman-adv: Add throughput_override hardif genl configuration
  batman-adv: Trigger genl notification on sysfs config change

 include/uapi/linux/batman_adv.h |  188 +++++-
 net/batman-adv/gateway_client.c |    1 -
 net/batman-adv/gateway_common.c |    1 +
 net/batman-adv/gateway_common.h |    6 -
 net/batman-adv/netlink.c        | 1074 +++++++++++++++++++++++++++----
 net/batman-adv/netlink.h        |    6 +
 net/batman-adv/soft-interface.c |    2 +-
 net/batman-adv/sysfs.c          |   64 +-
 8 files changed, 1195 insertions(+), 147 deletions(-)

-- 
2.19.1

