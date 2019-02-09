Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:40:50 +0100
Message-Id: <20190209134109.14908-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 00/19] batman-adv: netlink restructuring,
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

Thanks to Linus and Simon for their feedback. The discussed changes were now
integrated.


v5:
===

* renamed main functions to add attributes

  - batadv_netlink_mesh_put_ap_isolation ->
    batadv_netlink_mesh_fill_ap_isolation
  - batadv_netlink_mesh_put -> batadv_netlink_mesh_fill
  - batadv_netlink_hardif_put -> batadv_netlink_hardif_fill
  - batadv_netlink_vlan_put -> batadv_netlink_vlan_fill

* dropped attribute BATADV_ATTR_MULTICAST_MODE_ENABLED and replaced it with
  (basically inversed) BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED

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
  batman-adv: Add multicast forceflood mesh genl configuration
  batman-adv: Add network_coding mesh genl configuration
  batman-adv: Add orig_interval mesh genl configuration
  batman-adv: Add elp_interval hardif genl configuration
  batman-adv: Add throughput_override hardif genl configuration
  batman-adv: Trigger genl notification on sysfs config change

 include/uapi/linux/batman_adv.h |  190 +++++-
 net/batman-adv/gateway_client.c |    1 -
 net/batman-adv/gateway_common.c |    1 +
 net/batman-adv/gateway_common.h |    6 -
 net/batman-adv/netlink.c        | 1080 +++++++++++++++++++++++++++----
 net/batman-adv/netlink.h        |    6 +
 net/batman-adv/soft-interface.c |    2 +-
 net/batman-adv/sysfs.c          |   64 +-
 8 files changed, 1203 insertions(+), 147 deletions(-)

-- 
2.20.1

