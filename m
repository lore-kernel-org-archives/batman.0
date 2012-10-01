Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon,  1 Oct 2012 09:57:34 +0200
Message-Id: <1349078263-5834-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv12 0/9] Distributed ARP Table
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

Hello list,

this is the twelfth version of the patchset introducing DAT: the Distributed ARP
Table. The code has been reviewed and slightly adjusted once more. Some more
kernel-doc has been added and some minor fixes have been pulled in.

Thanks Marek for your patience in reviewing the code once more :-) And thanks
everybody for all the support during the development. I _hope_ this is the
_good_ version!


Cheers,
	Antonio

****
This is the **12th** version of this patchset.

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

v11:
- added kernel-doc for struct unicast_4addr_packet

v12:
- more kernel-doc
- modified code for the CONFIG_BATMAN_ADV_DAT=n case
- some other minor fixes
****


Antonio Quartulli (8):
  batman-adv: add UNICAST_4ADDR packet type
  batman-adv: Distributed ARP Table - add a new debug log level
  batman-adv: Distributed ARP Table - create DHT helper functions
  batman-adv: Distributed ARP Table - implement local storage
  batman-adv: Distributed ARP Table - add ARP parsing functions
  batman-adv: Distributed ARP Table - add snooping functions for ARP
    messages
  batman-adv: Distributed ARP Table - add compile option
  batman-adv: Distributed ARP Table - add runtime switch

Martin Hundebøll (1):
  batman-adv: Add get_ethtool_stats() support for DAT

 Makefile                |    2 +
 Makefile.kbuild         |    1 +
 README                  |    3 +-
 README.external         |    1 +
 compat.c                |   10 +
 compat.h                |    1 +
 debugfs.c               |   25 ++
 distributed-arp-table.c | 1073 +++++++++++++++++++++++++++++++++++++++++++++++
 distributed-arp-table.h |  168 ++++++++
 gen-compat-autoconf.sh  |    1 +
 hard-interface.c        |    3 +
 main.c                  |    9 +
 main.h                  |   13 +-
 originator.c            |    2 +
 packet.h                |   43 +-
 routing.c               |   41 +-
 send.c                  |    4 +
 soft-interface.c        |   28 +-
 sysfs.c                 |    8 +
 types.h                 |   72 ++++
 unicast.c               |  134 +++++-
 unicast.h               |   36 +-
 22 files changed, 1649 insertions(+), 29 deletions(-)
 create mode 100644 distributed-arp-table.c
 create mode 100644 distributed-arp-table.h

-- 
1.7.12

