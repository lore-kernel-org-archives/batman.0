Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 19 Jan 2019 16:56:07 +0100
Message-Id: <20190119155626.6414-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC v4 00/19] batman-adv: netlink restructuring,
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
second implementation is now using a nl80211-like design. The objects which
can now be modified/queried are:

* mesh/soft-interface (BATADV_CMD_GET_MESH/BATADV_CMD_SET_MESH)
* slave/hard-interface (BATADV_CMD_GET_HARDIF/BATADV_CMD_SET_HARDIF)
* vlan (BATADV_CMD_GET_VLAN/BATADV_CMD_SET_VLAN)

Such a set messages automatically triggers a *_SET_* "reply" via the config
multicast group. The same behavior was also added to the sysfs interface.

I would like to ask the other developers to check whether their
configuration values are represented correctly. And please also check
whether the current implementation might collide with some other features
which you might have in your pipeline.

Unfortunately, Linus Luessing is the only batman-adv developer who provided
feedback.

There were also two topics which were not yet really discussed and thus
these requests (from Linus) were not yet implemented:

* convert BATADV_ATTR_MULTICAST_MODE_ENABLED to an u32 and let don't handle
  it like a boolean. Instead use it to select how multicast traffic has to
  be handled:
  
  - 0: ignore multicast optimization and just flood it like broadcast
    traffic
  - 1: enabled multicast optimization
  - 2: undefined but also some kind of multicast optimization
  - 3: undefined but also some kind of multicast of optimization
  - ...

* convert BATADV_ATTR_AGGREGATION_OGM_ENABLED to u32 and use it
  to mark which type of traffic should be aggregated:

  - bit 0: enable aggregation of OGM(2)s
  - bit 1: yet undefined packet type which allows some kind of aggregation
  - bit 2: yet undefined packet type which allows some kind of aggregation
  - ...

v4:
===

Incorporate various feedback from

* Linus Luessing:

  - Fix typos/spelling/grammar problems:

    + "already allow" -> "already allows"
    + "mesh mesh" -> "mesh"
    + "safed" -> "saved"

  - Let batadv_get_softif_from_info actually return net_device instead of
    net_device private data (batadv_priv)
  - store genl_info_net(info) in temporary variable to avoid line breaks
    in function parameters
  - document that batadv_get_*_from_info functions increase the reference
    counter of the returned object
  - directly drop reference counter to hard_dev net_device in
    batadv_get_hardif_from_info instead of doing that in batadv_post_doit
  - fix NULL pointer deref of primary_if when batadv device doesn't have
    any slave device
  - rewrite user_ptr[1] flags precheck in batadv_pre_doit to count the
    number of set bits (to only allow one of the flags which use
    user_ptr[1])

* Jiri Pirko:

  - Add _ENABLED Postfix for boolean attributes:
  
    + BATADV_ATTR_AGGREGATED_OGMS_ENABLED
    + BATADV_ATTR_AP_ISOLATION_ENABLED
    + BATADV_ATTR_BONDING_ENABLED
    + BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED
    + BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED
    + BATADV_ATTR_FRAGMENTATION_ENABLED
    + BATADV_ATTR_MULTICAST_MODE_ENABLED
    + BATADV_ATTR_NETWORK_CODING_ENABLED

v3:
===

* correctly assign kernel-doc for BATADV_GW_MODE_CLIENT
* fix validation check for gw.sel_class
* fix setting of BATADV_ATTR_ORIG_INTERVAL
* Cc the (most likely) responsible developers for each setting to more
  directly ask them for feedback

v2:
===

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

 include/uapi/linux/batman_adv.h |  189 +++++-
 net/batman-adv/gateway_client.c |    1 -
 net/batman-adv/gateway_common.c |    1 +
 net/batman-adv/gateway_common.h |    6 -
 net/batman-adv/netlink.c        | 1080 +++++++++++++++++++++++++++----
 net/batman-adv/netlink.h        |    6 +
 net/batman-adv/soft-interface.c |    2 +-
 net/batman-adv/sysfs.c          |   64 +-
 8 files changed, 1202 insertions(+), 147 deletions(-)

-- 
2.20.1

