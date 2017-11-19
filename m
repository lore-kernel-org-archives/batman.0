Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:47 +0100
Message-Id: <20171119140553.24435-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/6] batctl: License cleanup
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

the kernel community is currently trying to make the licensing status more
clear in each file. This is mostly done by adding SPDX license identifiers
and defining a set of rules how these license related information has to
be stored.

I've used this opportunity to also go through all files of batctl (for
example with FSFE's `reuse lint`) and to annotate the files according to
the "Linux licensing rules" and FSFE's REUSE practices.

There are two things which could be seen as controversial:

* change of batman_adv.h to the Linux preferred license
  (I am waiting for Acks in the batman-adv patchset)
* explicitly mark remaining files as licensed under the GPL-2.0

Kind regards,
	Sven

Sven Eckelmann (6):
  batctl: Add GPL-2.0 as Linux's LICENSES/preferred/GPL-2.0
  batctl: Add License-Filename to GPL-2.0 files
  batctl: Import Linux's LICENSES/preferred/MIT
  batctl: Add SPDX license identifier above copyright header
  batctl: Mark remaining files as GPL-2.0
  batctl: Change batman_adv.h license to MIT

 .gitattributes             |   3 +
 CHANGELOG.license          |   2 +
 LICENSES/preferred/GPL-2.0 | 352 +++++++++++++++++++++++++++++++++++++++++++++
 LICENSES/preferred/MIT     |  30 ++++
 Makefile                   |   2 +
 README.license             |   2 +
 allocate.h                 |   5 +-
 bat-hosts.c                |   5 +-
 bat-hosts.h                |   5 +-
 bat-hosts.sample           |   3 +
 batman_adv.h               |  27 ++--
 bisect_iv.c                |   5 +-
 bisect_iv.h                |   5 +-
 debug.c                    |   5 +-
 debug.h                    |   5 +-
 debugfs.c                  |   5 +-
 debugfs.h                  |   5 +-
 functions.c                |   5 +-
 functions.h                |   5 +-
 genl.c                     |   1 +
 genl.h                     |   5 +-
 hash.c                     |   5 +-
 hash.h                     |   5 +-
 icmp_helper.c              |   5 +-
 icmp_helper.h              |   5 +-
 interface.c                |   5 +-
 interface.h                |   5 +-
 ioctl.c                    |   5 +-
 ioctl.h                    |   5 +-
 list.h                     |   1 +
 main.c                     |   5 +-
 main.h                     |   5 +-
 man/batctl.8               |   2 +
 netlink.c                  |   5 +-
 netlink.h                  |   5 +-
 packet.h                   |   3 +
 ping.c                     |   5 +-
 ping.h                     |   5 +-
 sys.c                      |   5 +-
 sys.h                      |   5 +-
 tcpdump.c                  |   5 +-
 tcpdump.h                  |   5 +-
 tp_meter.c                 |   5 +-
 tp_meter.h                 |   5 +-
 traceroute.c               |   5 +-
 traceroute.h               |   5 +-
 translate.c                |   5 +-
 translate.h                |   5 +-
 48 files changed, 526 insertions(+), 82 deletions(-)
 create mode 100644 CHANGELOG.license
 create mode 100644 LICENSES/preferred/GPL-2.0
 create mode 100644 LICENSES/preferred/MIT
 create mode 100644 README.license

-- 
2.11.0

