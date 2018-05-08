Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed,  9 May 2018 00:41:24 +0800
Message-Id: <20180508164130.8633-1-mareklindner@neomailbox.ch>
Subject: [B.A.T.M.A.N.] [RFC 0/6] B.A.T.M.A.N. V - fallback to tp meter
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
automate and thus better support these setups, ELP may call
the batman-adv throughput meter to schedule a throughput
estimation to be used to populate the metric table. 

Antonio Quartulli (3):
  batman-adv: tp_meter - prevent concurrent tp_meter sessions by using
    workqueue
  batman-adv: tp_meter - don't check for existing session
  batman-adv: to_meter - add option to perform one-hop test

Marek Lindner (3):
  batman-adv: tp_meter - allow up to 10 queued sessions
  batman-adv: tp_meter - add caller distinction
  batman-adv: ELP - use tp meter to estimate the throughput if otherwise
    not available

 include/uapi/linux/batadv_packet.h |   1 +
 net/batman-adv/bat_v_elp.c         |  62 ++++-
 net/batman-adv/bat_v_elp.h         |  19 ++
 net/batman-adv/main.c              |  10 +-
 net/batman-adv/main.h              |   7 +-
 net/batman-adv/netlink.c           |   3 +-
 net/batman-adv/routing.c           |   5 +-
 net/batman-adv/tp_meter.c          | 431 +++++++++++++++++------------
 net/batman-adv/tp_meter.h          |  11 +-
 net/batman-adv/types.h             |  32 ++-
 10 files changed, 393 insertions(+), 188 deletions(-)

-- 
2.17.0

