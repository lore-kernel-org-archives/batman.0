Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Thu, 16 Jan 2014 00:10:43 +0100
Message-Id: <1389827444-3911-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] pull request [net]: batman-adv 2014-01-16
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

Hello David,

here you have a very small fix intended for net/linux-3.13.

This patch is fixing the batman-adv overhead computation
(by Marek Lindner).
The result of such operation is used to initialize the
hard_header_len member of the soft-interface netdev object.


Please pull or let me know of any problem!

Thanks a lot,
	Antonio



The following changes since commit 51bb352f15595f2dee42b599680809de3d08999d:

  qlge: Fix vlan netdev features. (2014-01-14 19:02:35 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 1df0cbd509bc21b0c331358c1f9d9a6fc94bada8:

  batman-adv: fix batman-adv header overhead calculation (2014-01-15 23:54:20 +0100)

----------------------------------------------------------------
Included change:
- properly compute the batman-adv header overhead. Such
  result is later used to initialize the hard_header_len
  member of the soft-interface netdev object

----------------------------------------------------------------
Marek Lindner (1):
      batman-adv: fix batman-adv header overhead calculation

 net/batman-adv/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

