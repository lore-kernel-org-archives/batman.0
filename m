Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/4] batctl: Add vid support and hardif settings
Date: Thu, 13 Jun 2019 21:12:13 +0200
Message-Id: <20190613191217.28139-1-sven@narfation.org>
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
interface settings in batctl [1]. But I got no feedback at all. So I've
decided to just implement the first option and use it as chance to improve
the vlan settings.

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
  $ batctl -m bat0 vid 8 ap_isolation enable


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

Kind regards,
	Sven


[1] https://www.open-mesh.org/issues/373

Sven Eckelmann (4):
  batctl: Make vlan setting explicit
  batctl: Integrate hardif setting framework
  batctl: Add elp_interval setting command
  batctl: Add throughput_override setting command

 Makefile              |   2 +
 README.rst            |  33 +++++++++
 ap_isolation.c        |   5 ++
 elp_interval.c        | 111 +++++++++++++++++++++++++++++
 main.c                | 160 +++++++++++++++++++++++++++++++++++-------
 main.h                |  10 ++-
 man/batctl.8          |  12 +++-
 sys.c                 |  57 ++++++++++++---
 sys.h                 |   5 +-
 throughput_override.c | 113 +++++++++++++++++++++++++++++
 10 files changed, 470 insertions(+), 38 deletions(-)
 create mode 100644 elp_interval.c
 create mode 100644 throughput_override.c

-- 
2.20.1

