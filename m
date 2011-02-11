Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Feb 2011 00:21:39 +0100
Message-Id: <1297466503-13246-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2011-02-12
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi,

I would like propose following changes for net-next-2.6.git. Two of them are
minor code style changes and the other two change minor issues in the
routing/fragmentation code.

thanks,
	Sven

The following changes since commit 091b948306d2628320e77977eb7ae4a757b12180:

  batman-adv: Merge README of v2011.0.0 release (2011-01-31 14:57:13 +0100)

are available in the git repository at:
  git://git.open-mesh.org/ecsv/linux-merge.git batman-adv/next

Linus Lüssing (2):
      batman-adv: Remove duplicate types.h inclusions
      batman-adv: Disallow originator addressing within mesh layer

Marek Lindner (1):
      batman-adv: Split combined variable declarations

Sven Eckelmann (1):
      batman-adv: Use successive sequence numbers for fragments

 net/batman-adv/icmp_socket.c       |    1 -
 net/batman-adv/icmp_socket.h       |    2 --
 net/batman-adv/main.c              |    1 -
 net/batman-adv/routing.c           |    1 -
 net/batman-adv/routing.h           |    2 --
 net/batman-adv/send.c              |    1 -
 net/batman-adv/send.h              |    2 --
 net/batman-adv/soft-interface.c    |    1 -
 net/batman-adv/translation-table.c |    1 -
 net/batman-adv/translation-table.h |    2 --
 net/batman-adv/unicast.c           |   19 +++++++------------
 11 files changed, 7 insertions(+), 26 deletions(-)
