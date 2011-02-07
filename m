Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  8 Feb 2011 00:59:20 +0100
Message-Id: <1297123161-25612-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2011-02-08
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

I would like to propose following patch for net-2.6.git/2.6.38 which fixes a
possible kernel oops in the unicast fragmentation code.

thanks,
	Sven

The following changes since commit 1181e1daace88018b2ff66592aa10a4791d705ff:

  batman-adv: Make vis info stack traversal threadsafe (2011-01-30 10:32:08 +0100)

are available in the git repository at:
  git://git.open-mesh.org/ecsv/linux-merge.git batman-adv/merge

Sven Eckelmann (1):
      batman-adv: Linearize fragment packets before merge

 net/batman-adv/unicast.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)
