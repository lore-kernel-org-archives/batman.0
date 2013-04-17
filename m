Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 17 Apr 2013 23:03:15 +0200
Message-Id: <1366232596-23172-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2013-04-17
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi David,

here you have a patch intended for net/linux-3.9 (if it can still make it..).
It is fixing a MAC address check routine which does not behave
correctly in case of multiple mesh interfaces in the same node.

This patch will generate some conflicts the next time you will merge net in
net-next and will also break it (this happens because the function this patch is
changing is used by some patches existing in net-next only).

I will send some instruction on how to solve the merge conflicts and a patch to
fix net-next soon.


Please pull or let me know if there is any problem.

Thanks a lot,
	Antonio



The following changes since commit 361cd29cf9363505c2a35bbf9a034a22feebfb07:

  qlcnic: fix beaconing test for 82xx adapter (2013-04-17 01:15:29 -0400)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to fe8a93b95145c66adf196eea4a919dfe0b7c57db:

  batman-adv: make is_my_mac() check for the current mesh only (2013-04-17 22:31:22 +0200)

----------------------------------------------------------------
Included changes:
- fix MAC address check in case of multiple mesh interfaces

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: make is_my_mac() check for the current mesh only

 net/batman-adv/main.c              |  5 ++++-
 net/batman-adv/main.h              |  2 +-
 net/batman-adv/routing.c           | 38 ++++++++++++++++++++------------------
 net/batman-adv/translation-table.c |  2 +-
 net/batman-adv/vis.c               |  4 ++--
 5 files changed, 28 insertions(+), 23 deletions(-)
