Return-Path: <andrew@lunn.ch>
Date: Sat, 12 Dec 2009 11:45:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091212104525.GR29768@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] FWD: [PATCH 227/235] staging: batman-adv meshing
	protocol
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

FYI

GregKH just forwarded the batman-adv submission for mainline to the
linux driver project mailling list. This will probably result in more
eyes on the code.

     Andrew

----- Forwarded message from Greg Kroah-Hartman <gregkh@suse.de> -----

Date: Fri, 11 Dec 2009 14:29:29 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: devel@linuxdriverproject.org
Cc: Andrew Lunn <andrew@lunn.ch>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 227/235] staging: batman-adv meshing protocol
X-Spam-Status: No, score=-2.6 required=4.0 tests=BAYES_00 autolearn=ham
	version=3.2.5

From: Andrew Lunn <andrew@lunn.ch>

B.A.T.M.A.N. (better approach to mobile ad-hoc networking) is
a routing protocol for multi-hop ad-hoc mesh networks. The
networks may be wired or wireless. See
http://www.open-mesh.org/ for more information and user space
tools.

This is the first submission for inclusion in staging.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/Kconfig                        |    2 +
 drivers/staging/Makefile                       |    1 +
 drivers/staging/batman-adv/CHANGELOG           |   37 +
 drivers/staging/batman-adv/Kconfig             |   25 +
 drivers/staging/batman-adv/Makefile            |   22 +
 drivers/staging/batman-adv/README              |  125 +++
 drivers/staging/batman-adv/TODO                |   51 ++
 drivers/staging/batman-adv/aggregation.c       |  232 ++++++
 drivers/staging/batman-adv/aggregation.h       |   37 +
 drivers/staging/batman-adv/bitarray.c          |  177 +++++
 drivers/staging/batman-adv/bitarray.h          |   45 ++
 drivers/staging/batman-adv/compat.h            |   75 ++
 drivers/staging/batman-adv/device.c            |  337 ++++++++
 drivers/staging/batman-adv/device.h            |   36 +
 drivers/staging/batman-adv/hard-interface.c    |  451 +++++++++++
 drivers/staging/batman-adv/hard-interface.h    |   36 +
 drivers/staging/batman-adv/hash.c              |  313 ++++++++
 drivers/staging/batman-adv/hash.h              |   99 +++
 drivers/staging/batman-adv/log.c               |  179 +++++
 drivers/staging/batman-adv/log.h               |   32 +
 drivers/staging/batman-adv/main.c              |  286 +++++++
 drivers/staging/batman-adv/main.h              |  151 ++++
 drivers/staging/batman-adv/packet.h            |   96 +++
 drivers/staging/batman-adv/proc.c              |  950 ++++++++++++++++++++++
 drivers/staging/batman-adv/proc.h              |   49 ++
 drivers/staging/batman-adv/ring_buffer.c       |   52 ++
 drivers/staging/batman-adv/ring_buffer.h       |   23 +
 drivers/staging/batman-adv/routing.c           | 1010 ++++++++++++++++++++++++
 drivers/staging/batman-adv/routing.h           |   34 +
 drivers/staging/batman-adv/send.c              |  473 +++++++++++
 drivers/staging/batman-adv/send.h              |   36 +
 drivers/staging/batman-adv/soft-interface.c    |  349 ++++++++
 drivers/staging/batman-adv/soft-interface.h    |   33 +
 drivers/staging/batman-adv/translation-table.c |  454 +++++++++++
 drivers/staging/batman-adv/translation-table.h |   42 +
 drivers/staging/batman-adv/types.h             |  124 +++
 drivers/staging/batman-adv/vis.c               |  564 +++++++++++++
 drivers/staging/batman-adv/vis.h               |   63 ++
 38 files changed, 7101 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/batman-adv/CHANGELOG
 create mode 100644 drivers/staging/batman-adv/Kconfig
 create mode 100644 drivers/staging/batman-adv/Makefile
 create mode 100644 drivers/staging/batman-adv/README
 create mode 100644 drivers/staging/batman-adv/TODO
 create mode 100644 drivers/staging/batman-adv/aggregation.c
 create mode 100644 drivers/staging/batman-adv/aggregation.h
 create mode 100644 drivers/staging/batman-adv/bitarray.c
 create mode 100644 drivers/staging/batman-adv/bitarray.h
 create mode 100644 drivers/staging/batman-adv/compat.h
 create mode 100644 drivers/staging/batman-adv/device.c
 create mode 100644 drivers/staging/batman-adv/device.h
 create mode 100644 drivers/staging/batman-adv/hard-interface.c
 create mode 100644 drivers/staging/batman-adv/hard-interface.h
 create mode 100644 drivers/staging/batman-adv/hash.c
 create mode 100644 drivers/staging/batman-adv/hash.h
 create mode 100644 drivers/staging/batman-adv/log.c
 create mode 100644 drivers/staging/batman-adv/log.h
 create mode 100644 drivers/staging/batman-adv/main.c
 create mode 100644 drivers/staging/batman-adv/main.h
 create mode 100644 drivers/staging/batman-adv/packet.h
 create mode 100644 drivers/staging/batman-adv/proc.c
 create mode 100644 drivers/staging/batman-adv/proc.h
 create mode 100644 drivers/staging/batman-adv/ring_buffer.c
 create mode 100644 drivers/staging/batman-adv/ring_buffer.h
 create mode 100644 drivers/staging/batman-adv/routing.c
 create mode 100644 drivers/staging/batman-adv/routing.h
 create mode 100644 drivers/staging/batman-adv/send.c
 create mode 100644 drivers/staging/batman-adv/send.h
 create mode 100644 drivers/staging/batman-adv/soft-interface.c
 create mode 100644 drivers/staging/batman-adv/soft-interface.h
 create mode 100644 drivers/staging/batman-adv/translation-table.c
 create mode 100644 drivers/staging/batman-adv/translation-table.h
 create mode 100644 drivers/staging/batman-adv/types.h
 create mode 100644 drivers/staging/batman-adv/vis.c
 create mode 100644 drivers/staging/batman-adv/vis.h

[snip]

