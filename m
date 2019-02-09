Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  9 Feb 2019 14:42:02 +0100
Message-Id: <20190209134222.15035-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v5 00/20] batctl: netlink restructuring,
 part 3
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

As mentioned earlier, the netlink config restructuring in batctl will be
splitted in multiple steps. The first step was already merged and the
patch series for the netlink interface in batman-adv was just posted.

The batman-adv weren't directly rejected by Jiro and thus I've started
to convert all settings to netlink while still allowing sysfs as fallback.


v5:
===

* dropped attribute BATADV_ATTR_MULTICAST_MODE for multicast_mode and replaced
  it with (basically inversed) BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED
* Add _ENABLED Postfix for boolean attributes:
  
  -  BATADV_ATTR_AGGREGATED_OGMS_ENABLED
  -  BATADV_ATTR_AP_ISOLATION_ENABLED
  -  BATADV_ATTR_BONDING_ENABLED
  -  BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED
  -  BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED
  -  BATADV_ATTR_FRAGMENTATION_ENABLED
  -  BATADV_ATTR_NETWORK_CODING_ENABLED

v4:
===

* last patch (which adds the netlink implementation of the settings commands)
  was splitted in 16 separate patches
* Cc the (most likely) responsible developers for each setting to more
  directly ask them for feedback

v3:
===

* fix kernel-doc in batman_adv.h
* add three patches to use the netlink interface with the already existing
  setting commands

v2:
===

* drop of generic config command
* reimplementation of the event command

Kind regards,
	Sven

Sven Eckelmann (20):
  batctl: Add support for config mcast group in event monitor
  batctl: Don't allocate new buffer for vlan parent device
  batctl: Automatically translate vlan to mesh_iface
  batctl: Add settings_data hooks for netlink integration
  batctl: Parse the arguments for gw_mode
  batctl: Add netlink simple query helper
  batctl: Support generic netlink for gw_mode command
  batctl: Support generic netlink for loglevel command
  batctl: Support generic netlink for isolation_mark command
  batctl: Support generic netlink for orig_interval command
  batctl: Add helper to read/write boolean configuration values
  batctl: Support generic netlink for aggregation command
  batctl: Support generic netlink for ap_isolation command
  batctl: Support generic netlink for bonding command
  batctl: Support generic netlink for bridge_loop_avoidance command
  batctl: Support generic netlink for distributed_arp_table command
  batctl: Support generic netlink for fragmentation command
  batctl: Support generic netlink for multicast_mode command
  batctl: Support generic netlink for network_coding command
  batctl: Drop settings_data param lists

 aggregation.c           |  46 ++++-
 ap_isolation.c          |  68 ++++++-
 batman_adv.h            | 190 +++++++++++++++++-
 bonding.c               |  45 ++++-
 bridge_loop_avoidance.c |  46 ++++-
 distributed_arp_table.c |  46 ++++-
 event.c                 | 234 ++++++++++++++++++++++
 fragmentation.c         |  46 ++++-
 functions.c             | 160 +++++++++++++---
 functions.h             |  23 ++-
 gateways.c              |  10 +-
 gw_mode.c               | 416 +++++++++++++++++++++++++++++++---------
 isolation_mark.c        | 123 +++++++++++-
 loglevel.c              | 138 ++++++++++---
 main.c                  |  10 +-
 main.h                  |   6 +-
 mcast_flags.c           |  10 +-
 multicast_mode.c        |  66 ++++++-
 netlink.c               | 108 ++++++++++-
 netlink.h               |   2 +
 network_coding.c        |  46 ++++-
 orig_interval.c         |  84 +++++++-
 originators.c           |  10 +-
 routing_algo.c          |   1 -
 sys.c                   | 219 ++++++++++++++++-----
 sys.h                   |  25 ++-
 26 files changed, 1922 insertions(+), 256 deletions(-)

-- 
2.20.1

