Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri,  7 Sep 2018 17:59:51 +0800
Message-Id: <20180907095958.30946-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [PATCH v5 0/7] B.A.T.M.A.N. V - fallback to tp meter
 estimation if throughput otherwise not available
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Under normal circumstances B.A.T.M.A.N. V retrieves the neighbor
throughput values to populate its metric tables from the various
drivers such as WiFi throughput tables and Ethernet throughput..
Whenever the interface drivers do not export link throughput 
information manual overrides become necessary. To further 
automate and thus better support these setups, ELP may call the
batman-adv throughput meter to schedule a throughput estimation
to be used to populate the metric table.

v5:
 * fix tp_vars refcount on queue_work() failure
 * squash batadv_tp_start_work() into batadv_tp_start()

v4:
 * read tp measurement result only once

v3:
 * fix ELP tp meter result computation
 * use batadv_has_timed_out() instead of custom implementation
 * set ELP tp meter test duration to 1000ms in patch #6
 * add comment explaining periodic scheduling

v2:
 * added sysfs attribute to configure tp meter test duration
 * fixed null pointer dereference in TP meter packet sending routine
 * fixed storing the measured throughput in the correct variable
 * checkpatch/kerneldoc/sparse/smatch cleanup

Antonio Quartulli (3):
  batman-adv: tp_meter - prevent concurrent tp_meter sessions by using
    workqueue
  batman-adv: tp_meter - don't check for existing session
  batman-adv: tp_meter - add option to perform one-hop test

Marek Lindner (4):
  batman-adv: tp_meter - allow up to 10 queued sessions
  batman-adv: tp_meter - add caller distinction
  batman-adv: ELP - use tp meter to estimate the throughput if otherwise
    not available
  batman-adv: ELP - add throughput meter test duration attribute

 .../ABI/testing/sysfs-class-net-batman-adv    |   7 +
 include/uapi/linux/batadv_packet.h            |   2 +
 net/batman-adv/bat_v.c                        |   1 +
 net/batman-adv/bat_v_elp.c                    |  69 ++-
 net/batman-adv/bat_v_elp.h                    |  21 +
 net/batman-adv/main.c                         |  10 +-
 net/batman-adv/main.h                         |   7 +-
 net/batman-adv/netlink.c                      |   3 +-
 net/batman-adv/routing.c                      |   6 +-
 net/batman-adv/sysfs.c                        |   3 +
 net/batman-adv/tp_meter.c                     | 484 +++++++++++-------
 net/batman-adv/tp_meter.h                     |  11 +-
 net/batman-adv/types.h                        |  36 ++
 13 files changed, 453 insertions(+), 207 deletions(-)

-- 
2.18.0

