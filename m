Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/6] batctl: Use shared batadv genl socket for requests
Date: Mon, 10 May 2021 21:49:39 +0200
Message-Id: <20210510194945.103735-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

It was noticed that quite a lot of functions create their own netlink
socket just to talk to batman-adv. This is related to the old sysfs
compat code which was removed in 2021.0. So restructure the code to
make use of the existing global information in the state object.

Kind regards,
	Sven

Sven Eckelmann (6):
  batctl: Consume genl ACKs after setting reads
  batctl: throughputmeter: Use global genl socket
  batctl: interface: List using shared genl socket
  batctl: Get meshif info using shared genl socket
  batctl: Use common genl socket for netlink_query_common
  batctl: routing_algo: List using shared genl socket

 functions.c       |  15 +++---
 functions.h       |   5 +-
 gateways.c        |   3 +-
 gw_mode.c         |   3 +-
 icmp_helper.c     |  14 +++---
 icmp_helper.h     |   2 +-
 interface.c       |  77 ++++++++++++-----------------
 mcast_flags.c     |   3 +-
 netlink.c         | 121 +++++++++++++++++-----------------------------
 netlink.h         |  12 ++---
 originators.c     |   3 +-
 ping.c            |   7 +--
 routing_algo.c    |  74 +++++++++++++---------------
 sys.c             |   8 ++-
 throughputmeter.c | 105 ++++++++--------------------------------
 traceroute.c      |   7 +--
 translate.c       |   5 +-
 17 files changed, 176 insertions(+), 288 deletions(-)

-- 
2.30.2

