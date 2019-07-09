Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH v3 0/6] batctl: Add vid support and hardif settings
Date: Tue,  9 Jul 2019 19:26:45 +0200
Message-Id: <20190709172651.5869-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I've asked a quite while back for some ideas regarding the support for hard
interface settings in batctl [1]. The current consensus seems to be that
a more iw-like interface is prefered.

vlan settings
=============

The requirement to have a VLAN master device on top of the batadv mesh
interface is artificially limiting the capabilities of batctl. Not all
master devices in linux which register a VLAN are from type "vlan" and are
only registering a single VLAN.

For example VLAN aware bridges can create multiple VLANs. These require
that the VLAN is identified using the VID and not the vlan device.

It is now possible to specify the vlan using:

  $ batctl vlan bat0.8 ap_isolation enable
  $ batctl meshif bat0 vid 8 ap_isolation enable


hardif settings
===============

The infrastructure for the new vlan/vid prefix of commands can now be used
to introduce another prefix: "hardif".

B.A.T.M.A.N. V introduced two additional settings which are hard (slave)
interface specific. These can can finally be implemented in batctl. This
will allow to change/read these settings when sysfs support is not enabled
in the kernel.

  $ batctl hardif eth0 throughput_override 15mbit
  $ batctl hardif eth0 elp_interval


Changes
=======

v3
--

* drop prefix "dev" and "slave"

v2
--

* replaced (while still being compatible) -m option with "meshif"/"dev" prefix
* added alternative "slave" for "hardif" prefix
* automatically detect meshif for "hardif"/"slave"
* introduced enum selector_prefix to make code to select correct
  subcommands/code paths better readable
* add helper to automatically guess the type of netdev to allow omission of
  meshif/slave/vlan/... in some situations

v1
--

* initial version

[1] https://www.open-mesh.org/issues/373

Kind regards,
        Sven

Sven Eckelmann (6):
  batctl: Make vlan setting explicit
  batctl: Integrate hardif setting framework
  batctl: Add elp_interval setting command
  batctl: Add throughput_override setting command
  batctl: Replace '-m meshif' option with selector prefix
  batctl: Allow to omit explicit prefix name

 Makefile                |   2 +
 README.rst              |  33 +++++
 aggregation.c           |   2 +-
 ap_isolation.c          |  15 ++-
 bonding.c               |   2 +-
 bridge_loop_avoidance.c |   2 +-
 distributed_arp_table.c |   2 +-
 elp_interval.c          | 111 ++++++++++++++++
 fragmentation.c         |   2 +-
 functions.c             | 119 +++++++++++++++---
 functions.h             |   8 +-
 gw_mode.c               |   2 +-
 hop_penalty.c           |   2 +-
 interface.c             |   2 +-
 isolation_mark.c        |   2 +-
 loglevel.c              |   2 +-
 main.c                  | 271 ++++++++++++++++++++++++++++++++++++----
 main.h                  |  23 +++-
 man/batctl.8            |  60 +++++----
 multicast_fanout.c      |   2 +-
 multicast_forceflood.c  |   2 +-
 multicast_mode.c        |   2 +-
 network_coding.c        |   2 +-
 orig_interval.c         |   2 +-
 ping.c                  |   2 +-
 statistics.c            |   2 +-
 sys.c                   |  73 +++++++++--
 sys.h                   |   5 +-
 throughput_override.c   | 113 +++++++++++++++++
 throughputmeter.c       |   2 +-
 traceroute.c            |   2 +-
 translate.c             |   2 +-
 32 files changed, 770 insertions(+), 103 deletions(-)
 create mode 100644 elp_interval.c
 create mode 100644 throughput_override.c

-- 
2.20.1

