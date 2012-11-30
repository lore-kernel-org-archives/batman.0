Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Fri, 30 Nov 2012 16:08:29 +0100
Message-Id: <cover.1354287613.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/6] CATWOMAN: Network coding in batman-adv
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

I hereby bring you network coding in batman-adv. (Changed accoring
to Antonios partlial review). This allows a relay to send two packets
(to two destinations) in a single transmission. Tests[1] have shown
an increase in throughput up to 1.6 under the right circumstances.

For this to work, you will need to compile batman-adv with
CONFIG_BATMAN_ADV_NC=y and a wireless interface with working
promiscuous mode. The rest is taken care of by batman-adv and the
following patches.

[1] http://www.open-mesh.org/projects/open-mesh/wiki/2011-08-18-network-coding-first-steps

Martin Hundebøll (6):
  batman-adv: Add the initial code for network coding.
  batman-adv: Detect coding nodes and remove these after timeout
  batman-adv: Buffer unicast packets before forward.
  batman-adv: Code and transmit packets if possible.
  batman-adv: Save overheard and tx packets for decoding.
  batman-adv: Receive coded packets and decode them.

 Makefile               |    2 +
 Makefile.kbuild        |    1 +
 bat_iv_ogm.c           |    5 +
 compat.c               |   10 +
 compat.h               |    1 +
 debugfs.c              |   18 +
 gen-compat-autoconf.sh |    1 +
 main.c                 |    6 +
 main.h                 |   13 +-
 network-coding.c       | 1817 ++++++++++++++++++++++++++++++++++++++++++++++++
 network-coding.h       |  123 ++++
 originator.c           |    6 +
 packet.h               |   33 +
 routing.c              |   26 +-
 send.c                 |    5 +
 soft-interface.c       |   14 +
 sysfs-class-net-mesh   |    8 +
 sysfs.c                |    6 +
 types.h                |  123 ++++
 19 files changed, 2209 insertions(+), 9 deletions(-)
 create mode 100644 network-coding.c
 create mode 100644 network-coding.h

-- 
1.8.0.1

