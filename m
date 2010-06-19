Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 19 Jun 2010 02:51:45 +0200
Message-Id: <1276908713-28365-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (2)
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
To: Greg KH <greg@kroah.com>
Cc: b.a.t.m.a.n@lists.open-mesh.net

Hi,

here are patches targetted for 2.6.36. They are made on top of patches you have
already received in 1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de :

 * Staging: batman-adv: remove redundant struct declaration
 * Staging: batman-adv: Move device for icmp injection to debugfs
 * Staging: batman-adv: Move tables from sysfs to debugfs
 * Staging: batman-adv: convert all sysfs files to single value files
 * Staging: batman-adv: Adding netfilter-bridge hooks
 * Staging: batman-adv: Add information about batman-adv sysfs entries
 * Staging: batman-adv: remove superfluous hint to "translation table"
 * Staging: batman-adv: convert vis_interval into define
 * Staging: batman-adv: Convert MAC_FMT to %pM

They also depend on patches not yet applied on 2.6.35, but sent to you:

 * Staging: batman-adv: return -EFAULT on copy_to_user errors
 * Staging: batman-adv: fix function prototype

thanks,
	Sven

 drivers/staging/batman-adv/CHANGELOG           |   12 +
 drivers/staging/batman-adv/README              |    2 +-
 drivers/staging/batman-adv/aggregation.c       |    4 +-
 drivers/staging/batman-adv/bat_debugfs.c       |    2 +
 drivers/staging/batman-adv/bat_sysfs.c         |   54 ++++-
 drivers/staging/batman-adv/bitarray.c          |   10 +-
 drivers/staging/batman-adv/bitarray.h          |    9 +-
 drivers/staging/batman-adv/hard-interface.c    |    4 +-
 drivers/staging/batman-adv/hash.c              |    2 +-
 drivers/staging/batman-adv/hash.h              |    6 -
 drivers/staging/batman-adv/icmp_socket.c       |   45 ++--
 drivers/staging/batman-adv/icmp_socket.h       |    3 +-
 drivers/staging/batman-adv/main.h              |    9 +-
 drivers/staging/batman-adv/originator.c        |   40 ++--
 drivers/staging/batman-adv/originator.h        |    2 -
 drivers/staging/batman-adv/packet.h            |   27 ++-
 drivers/staging/batman-adv/routing.c           |  324 ++++++++++++++++++++----
 drivers/staging/batman-adv/routing.h           |    8 +-
 drivers/staging/batman-adv/send.c              |   23 ++-
 drivers/staging/batman-adv/send.h              |    2 -
 drivers/staging/batman-adv/soft-interface.c    |  159 ++++++------
 drivers/staging/batman-adv/soft-interface.h    |    6 -
 drivers/staging/batman-adv/translation-table.c |    9 +-
 drivers/staging/batman-adv/translation-table.h |    3 -
 drivers/staging/batman-adv/types.h             |   20 ++-
 drivers/staging/batman-adv/vis.c               |    9 +-
 drivers/staging/batman-adv/vis.h               |    3 -
 27 files changed, 562 insertions(+), 235 deletions(-)

Daniel Seither (1):
      Staging: batman-adv: record route for ICMP messages

Linus Lüssing (1):
      Staging: batman-adv: permit setting ogm interval to JITTER*2

Simon Wunderlich (4):
      Staging: batman-adv: Add release information for version 2010.0.0
      Staging: batman-adv: 32bit sequence number and TTL for broadcasts
      Staging: batman-adv: Add bonding functionality
      Staging: batman-adv: bonding and interface alternating

Sven Eckelmann (2):
      Staging: batman-adv: Mark locally used symbols as static
      Staging: batman-adv: Ignore debugfs on kernels without debugfs support

