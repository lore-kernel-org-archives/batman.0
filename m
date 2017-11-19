Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 19 Nov 2017 15:05:56 +0100
Message-Id: <20171119140602.24504-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/6] alfred: License cleanup
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

I've used this opportunity to also go through all files of alfred (for
example with FSFE's `reuse lint`) and to annotate the files according to
the "Linux licensing rules" and FSFE's REUSE practices.

There are two things which could be seen as controversial:

* change of batman_adv.h to the Linux preferred license
  (I am waiting for Acks in the batman-adv patchset)
* explicitly mark remaining files as licensed under the GPL-2.0

Kind regards,
	Sven

Sven Eckelmann (6):
  alfred: Rename LICENSE to Linux's LICENSES/preferred/GPL-2.0
  alfred: Add License-Filename to GPL-2.0 files
  alfred: Import Linux's LICENSES/preferred/MIT
  alfred: Add SPDX license identifier above copyright header
  alfred: Mark remaining files as GPL-2.0
  alfred: Change batman_adv.h license to MIT

 .gitattributes                        |  3 +++
 CHANGELOG.license                     |  2 ++
 LICENSE => LICENSES/preferred/GPL-2.0 | 13 +++++++++++++
 LICENSES/preferred/MIT                | 30 ++++++++++++++++++++++++++++++
 Makefile                              |  2 ++
 README.license                        |  2 ++
 alfred.h                              |  5 +++--
 batadv_query.c                        |  5 +++--
 batadv_query.h                        |  5 +++--
 batadv_querynl.c                      |  5 +++--
 batadv_querynl.h                      |  5 +++--
 batman_adv.h                          | 27 +++++++++++++++++----------
 bitops.h                              |  1 +
 client.c                              |  5 +++--
 debugfs.c                             |  5 +++--
 debugfs.h                             |  5 +++--
 gpsd/Makefile                         |  2 ++
 gpsd/alfred-gpsd.c                    |  5 +++--
 gpsd/alfred-gpsd.h                    |  5 +++--
 gpsd/man/alfred-gpsd.8                |  2 ++
 hash.c                                |  5 +++--
 hash.h                                |  5 +++--
 list.h                                |  5 +++--
 main.c                                |  5 +++--
 man/alfred.8                          |  2 ++
 netlink.c                             |  5 +++--
 netlink.h                             |  5 +++--
 netsock.c                             |  5 +++--
 packet.h                              |  5 +++--
 recv.c                                |  5 +++--
 send.c                                |  5 +++--
 server.c                              |  5 +++--
 unix_sock.c                           |  5 +++--
 util.c                                |  5 +++--
 vis/Makefile                          |  2 ++
 vis/man/batadv-vis.8                  |  2 ++
 vis/vis.c                             |  5 +++--
 vis/vis.h                             |  5 +++--
 38 files changed, 155 insertions(+), 60 deletions(-)
 create mode 100644 CHANGELOG.license
 rename LICENSE => LICENSES/preferred/GPL-2.0 (97%)
 create mode 100644 LICENSES/preferred/MIT
 create mode 100644 README.license

-- 
2.11.0

