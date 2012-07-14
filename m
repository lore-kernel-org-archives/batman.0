Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 14 Jul 2012 19:15:36 +0200
Message-Id: <1342286144-24490-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv10 0/8] Distributed ARP Table
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
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

Hello people,

****
This is the **nineth** version of this patchset.

v8:
- introduce batman-adv private local storage for arp entries
- unicast ARP request are correctly handled now
- debug messages improved
- requests coming in unicast now get replied with unicast (no 4addr)

v9:
- added kernel-doc
- fixed counters
- added new counter: BATADV_CNT_DAT_CACHED_REPLY_TX
- ensure arp reply has been sent before dropping incoming arp request

v10:
- several fixes on kernel-doc style
- readded wrongly removed blankline
****

This patches are based on top of speedy join patches:
 batman-adv: detect not yet announced clients
 batman-adv: change interface_rx to get orig node


Cheers,
	Antonio


Antonio Quartulli (7):
  batman-adv: add UNICAST_4ADDR packet type
  batman-adv: Distributed ARP Table - add a new debug log level
  batman-adv: Distributed ARP Table - create DHT helper functions
  batman-adv: Distributed ARP Table - implement local storage
  batman-adv: Distributed ARP Table - add ARP parsing functions
  batman-adv: Distributed ARP Table - add snooping functions for ARP
    messages
  batman-adv: Distributed ARP Table - add compile option

Martin Hundebøll (1):
  batman-adv: Add get_ethtool_stats() support for DAT

 Makefile                |    2 +
 Makefile.kbuild         |    1 +
 README                  |    3 +-
 README.external         |    1 +
 compat.c                |   10 +
 compat.h                |    1 +
 debugfs.c               |   15 +
 distributed-arp-table.c | 1094 +++++++++++++++++++++++++++++++++++++++++++++++
 distributed-arp-table.h |  132 ++++++
 gen-compat-autoconf.sh  |    1 +
 hard-interface.c        |    3 +
 main.c                  |    9 +
 main.h                  |   12 +-
 originator.c            |    2 +
 packet.h                |   30 +-
 routing.c               |   37 +-
 send.c                  |    4 +
 soft-interface.c        |   23 +-
 types.h                 |   45 ++
 unicast.c               |  137 +++++-
 unicast.h               |   24 +-
 21 files changed, 1553 insertions(+), 33 deletions(-)
 create mode 100644 distributed-arp-table.c
 create mode 100644 distributed-arp-table.h

-- 
1.7.9.4

