Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  3 Mar 2019 18:02:54 +0100
Message-Id: <20190303170259.31798-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/5] batman-adv: Deprecation of sysfs
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

The old sysfs configuration interface was frowned upon by other kernel
developers. To work around this problem, the sysfs files were replaced by
the batadv generic netlink family. Still they are currently available
as alternative interface.

These files cannot be removed immediately because userspace tools might
still depend on it. Instead schedule for its removal in 2021. To aid
userspace tool developers, warn them when these files are still accessed
and provide an option to build batman-adv without sysfs support.

Kind regards,
	Sven

Sven Eckelmann (5):
  batman-adv: Drop documentation about debugfs files
  batman-adv: Drop documentation about sysfs files
  batman-adv: Make sysfs support optional
  batman-adv: ABI: Mark sysfs files as deprecated
  batman-adv: Warn about sysfs file access

 .../sysfs-class-net-batman-adv                |   2 +
 .../sysfs-class-net-mesh                      |   2 +
 Documentation/networking/batman-adv.rst       | 110 +++++------------
 MAINTAINERS                                   |   4 +-
 Makefile                                      |   3 +
 README.external.rst                           |   1 +
 gen-compat-autoconf.sh                        |   3 +-
 net/batman-adv/Kconfig                        |  12 ++
 net/batman-adv/Makefile                       |   2 +-
 net/batman-adv/bridge_loop_avoidance.c        |   1 -
 net/batman-adv/gateway_client.c               |   1 -
 net/batman-adv/main.c                         |  73 +++++++++++
 net/batman-adv/main.h                         |   2 +
 net/batman-adv/sysfs.c                        | 116 +++++++-----------
 net/batman-adv/sysfs.h                        |  38 +++++-
 15 files changed, 210 insertions(+), 160 deletions(-)
 rename Documentation/ABI/{testing => obsolete}/sysfs-class-net-batman-adv (92%)
 rename Documentation/ABI/{testing => obsolete}/sysfs-class-net-mesh (97%)

-- 
2.20.1

