Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:00 +0100
Message-Id: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 00/23] Introducing a new routing protocol:
	B.A.T.M.A.N. V
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Hello list,

this is the first _RFC_ introducing a new routing protocol in the batman-adv
kernel module, namely B.A.T.M.A.N. V.

Basically this is the result of three major ideas:
1) separate link cost estimation and routing information spreading
   (B.A.T.M.A.N. IV performs the two operations by using OGMs only)
2) introduce a throughput based metric (B.A.T.M.A.N. IV metric is mainly
   based on packet loss)
3) create a new protocol that groups all the knowledge gained so far

For what concerns point 1) in this patchset we introduce the Echo Locating
Protocol (aka ELP), which is a standalone component aimed to only estimate
link costs. ELP was originally written by Linus Lüssing.

For point 2) we have already proposed an extension of the cfg80211 module (not
yet merged) which allows any kernel module to retrieve the expected throughput
towards another peer over a wireless link. ELP is the component in charge of
interacting with cfg80211 to retrieve the expected throughput.
For wired connections ELP directly reads the bandwidth advertised by the
Ethernet card (not optimal in case of complex topologies - but it is a first
attempt).

Point 3) gets concrete under the new OGMv2 protocol, which is the core of
B.A.T.M.A.N. V.


The documentation is not yet ready to be linked, because the draft we have on
the wiki needs to be adapted to reflect the last changes (in particular about
the metric change from TQ to expected throughput).

In the various patches some kerneldoc is still missing: I am working on that
now. But I wanted to throw the patchset out as soon as possible to let anybody
review this code (this is why this is an RFC).


Notes:
=======
1) yes,_this_patchset_is_not_yet_checkpatch_clean_
2) patch 1/23 is already pending on the ml as RFC but I am resending it here
since it is part of the whole batman v picture.



Cheers,


Antonio Quartulli (18):
  batman-adv: invoke ogm_schedule() only when the interface is activated
  batman-adv: OGMv2 - add basic infrastructure
  batman-adv: OGMv2 - implement originators logic
  batman-adv: OGMv2 - purge obsolete potential routers
  batman-adv: split name from variable for uint mesh attributes
  batman-adv: add throughput attribute to hard_ifaces
  batman-adv: add base throughput attribute
  batman-adv: add last_unicast_tx to struct neigh_node_elp
  batman-adv: ELP - compute the metric based on the estimated throughput
  batman-adv: ELP - send unicast ELP packets for throughput sampling
  batman-adv: ELP - read estimated throughput from cfg80211
  batman-adv: ELP - implement dead neigh node detection
  batman-adv: ELP - use phydev to determine link characteristics
  batman-adv: add bat_neigh_free() API
  batman-adv: B.A.T.M.A.N. V - implement bat_neigh_free() API
  batman-adv: B.A.T.M.A.N. V - implement neigh_is_equiv_or_better API
  batman-adv: B.A.T.M.A.N. V - implement bat_neigh_cmp API
  batman-adv: B.A.T.M.A.N. V - implement bat_orig_print API

Linus Luessing (5):
  batman-adv: Add hard_iface specific sysfs wrapper macros for UINT
  batman-adv: ELP - adding basic infrastructure
  batman-adv: ELP - creating neighbor structures
  batman-adv: ELP - exporting neighbor list via debugfs
  batman-adv: ELP - adding sysfs parameter for elp interval

 Makefile                   |   2 +
 Makefile.kbuild            |   3 +
 README.external            |   1 +
 bat_algo.h                 |  26 +-
 bat_iv_ogm.c               |   2 +-
 bat_v.c                    | 266 +++++++++++++++++
 bat_v_elp.c                | 718 +++++++++++++++++++++++++++++++++++++++++++++
 bat_v_elp.h                |  39 +++
 bat_v_ogm.c                | 716 ++++++++++++++++++++++++++++++++++++++++++++
 bat_v_ogm.h                |  32 ++
 compat.h                   |  20 ++
 debugfs.c                  |  17 ++
 distributed-arp-table.c    |   4 +-
 fragmentation.c            |   8 +-
 gen-compat-autoconf.sh     |   1 +
 hard-interface.c           |  24 +-
 icmp_socket.c              |   2 +-
 main.c                     |  32 +-
 main.h                     |  16 +
 network-coding.c           |  20 +-
 originator.c               |  69 +++--
 originator.h               |   2 +
 packet.h                   |  50 ++++
 send.c                     |  46 ++-
 send.h                     |  10 +-
 sysfs-class-net-batman-adv |   8 +-
 sysfs.c                    |  87 +++++-
 types.h                    | 113 +++++++
 28 files changed, 2260 insertions(+), 74 deletions(-)
 create mode 100644 bat_v.c
 create mode 100644 bat_v_elp.c
 create mode 100644 bat_v_elp.h
 create mode 100644 bat_v_ogm.c
 create mode 100644 bat_v_ogm.h

-- 
1.8.5.3

