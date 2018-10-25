Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 25 Oct 2018 18:22:03 +0200
Message-Id: <20181025162245.19389-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v3 00/42] batctl: pre-netlink restructuring,
 part 1
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

the batctl command already has support to get (previously debugfs) tables
via netlink. It does this while still being able to fall back to the old
debugfs tables on kernels which don't support the new generic netlink
family.

Something similar should be done in the future for the settings which
are currently part of sysfs. But we can already see that the current
integration of netlink in batctl only done in a single file - netlink.c
But this file is already starting to be so big that working with it
is rather cumbersome.

So as first steps:

* restructure command registration
* move commands in separate files (which should store their actual implementation)
* add a new helper command to receive multicast group messages from the kernel

More things will follow in the future.

Changes:

v3:

* correctly split ap_isolation and bonding patch
* fix copyright headers for new files
* move more routing_algo specific code to its command specific file
* fix build problems with musl in OpenWrt 18.06
* switch Makefile's OBJ + OBJ_BISECT to obj-y and obj-n
* add way to "freely" disable some commands for size optimization reasons

  - it is for example now possible to reduce the size of the batctl on
    mips_24kc_musl from 64604 bytes to 14252 bytes when only the interface
    commands are required (I know, stupid example)
  - the binary to generate the debug tables output for the same architectur
    used 26988 bytes
    
v2:

* Add missing orig_interval.c


Kind regards,
	Sven

Sven Eckelmann (42):
  batctl: Drop unused define SOCKET_PATH_FMT
  batctl: Use common code organization for statistics
  batctl: Drop legacy vis_* related warning messages
  batctl: Move loglevel command to separate file
  batctl: Move log command to separate file
  batctl: Move gw_mode command to separate file
  batctl: Move routing_algo command to separate file
  batctl: Rename tp_meter to throughputmeter
  batctl: Introduce datastructure for subcommands
  batctl: Add per command flags
  batctl: Use command structure for remaining subcommands
  batctl: Use getopt to parse main options
  batctl: Store usage line next to command
  batctl: Prepare command infrastructure for shared functions
  batctl: Add type to command to structure usage output
  batctl: Convert debug table to command infrastructure
  batctl: Convert sysfs settings to command infrastructure
  batctl: Move backbonetable debug table to own file
  batctl: Move claimtable debug table to own file
  batctl: Move dat_cache debug table to own file
  batctl: Move gateways debug table to own file
  batctl: Move mcast_flags debug table to own file
  batctl: Move nc_nodes debug table to own file
  batctl: Move neighbors debug table to own file
  batctl: Move originators debug table to own file
  batctl: Move transglobal debug table to own file
  batctl: Move translocal debug table to own file
  batctl: Move aggregation setting to own file
  batctl: Move ap_isolation setting to own file
  batctl: Move bonding setting to own file
  batctl: Move bridge_loop_avoidance setting to own file
  batctl: Move distributed_arp_table setting to own file
  batctl: Move fragmentation setting to own file
  batctl: Move isolation_mark setting to own file
  batctl: Move multicast_mode setting to own file
  batctl: Move network_coding setting to own file
  batctl: Move orig_interval setting to own file
  batctl: Use external netlink socket for debug tables
  batctl: Move routing_algo specific code it command source file
  batctl: Add command to monitor for netlink events
  batctl: Simplify enabling for bisect_iv subcommand
  batctl: Allow to enable/disable subcommands

 Makefile                        |   91 ++-
 translate.h => aggregation.c    |   15 +-
 ap_isolation.c                  |   33 +
 backbonetable.c                 |  126 ++++
 bisect_iv.c                     |    6 +-
 bisect_iv.h                     |    4 -
 traceroute.h => bonding.c       |   15 +-
 bridge_loop_avoidance.c         |   33 +
 claimtable.c                    |  131 ++++
 dat_cache.c                     |  147 +++++
 debug.c                         |  218 +------
 debug.h                         |   38 +-
 distributed_arp_table.c         |   33 +
 event.c                         |  246 ++++++++
 ping.h => fragmentation.c       |   15 +-
 functions.c                     |   28 +-
 functions.h                     |    1 -
 gateways.c                      |  175 +++++
 gw_mode.c                       |  171 +++++
 interface.c                     |   23 +-
 ioctl.h                         |   28 -
 isolation_mark.c                |   35 +
 log.c                           |   73 +++
 loglevel.c                      |  147 +++++
 main.c                          |  274 ++++----
 main.h                          |   65 +-
 man/batctl.8                    |    4 +
 mcast_flags.c                   |  180 ++++++
 multicast_mode.c                |   33 +
 interface.h => nc_nodes.c       |   14 +-
 neighbors.c                     |  142 +++++
 netlink.c                       | 1332 ++++-----------------------------------
 netlink.h                       |   55 +-
 network_coding.c                |   33 +
 orig_interval.c                 |   35 +
 originators.c                   |  228 +++++++
 ping.c                          |   10 +-
 routing_algo.c                  |  263 ++++++++
 ioctl.c => statistics.c         |   10 +-
 sys.c                           |  432 +------------
 sys.h                           |   39 +-
 tcpdump.c                       |    5 +-
 tcpdump.h                       |    2 -
 tp_meter.c => throughputmeter.c |   10 +-
 tp_meter.h                      |   28 -
 traceroute.c                    |   10 +-
 transglobal.c                   |  162 +++++
 translate.c                     |    8 +-
 translocal.c                    |  158 +++++
 49 files changed, 3156 insertions(+), 2208 deletions(-)
 rename translate.h => aggregation.c (67%)
 create mode 100644 ap_isolation.c
 create mode 100644 backbonetable.c
 rename traceroute.h => bonding.c (68%)
 create mode 100644 bridge_loop_avoidance.c
 create mode 100644 claimtable.c
 create mode 100644 dat_cache.c
 create mode 100644 distributed_arp_table.c
 create mode 100644 event.c
 rename ping.h => fragmentation.c (67%)
 create mode 100644 gateways.c
 create mode 100644 gw_mode.c
 delete mode 100644 ioctl.h
 create mode 100644 isolation_mark.c
 create mode 100644 log.c
 create mode 100644 loglevel.c
 create mode 100644 mcast_flags.c
 create mode 100644 multicast_mode.c
 rename interface.h => nc_nodes.c (73%)
 create mode 100644 neighbors.c
 create mode 100644 network_coding.c
 create mode 100644 orig_interval.c
 create mode 100644 originators.c
 create mode 100644 routing_algo.c
 rename ioctl.c => statistics.c (90%)
 rename tp_meter.c => throughputmeter.c (97%)
 delete mode 100644 tp_meter.h
 create mode 100644 transglobal.c
 create mode 100644 translocal.c

-- 
2.11.0

