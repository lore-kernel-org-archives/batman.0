Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 18 Sep 2013 08:27:37 +0200
Message-Id: <1379485658-2317-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] pull request net: batman-adv 2013-09-18
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

this is a very small (but important) fix intended for net/linux-3.{11,12} (since
3.12-rc1 is out I guess this patch needs to be enqueued for stable in order to
reach 3.11?)

This change fixes a regression introduced in 3.11 that prevents the Bridge Loop
Avoidance component from correctly operate on VLANs.


Please pull or let me know of any problem.
Thank you,
	Antonio


The following changes since commit 1ef68ec462571955f2a667ddf1ffe279848709d7:

  Merge branch 'sfc-3.12' of git://git.kernel.org/pub/scm/linux/kernel/git/bwh/sfc (2013-09-16 21:43:54 -0400)

are available in the git repository at:


  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 4c18c425b2d228415b635e97a64737d7f27c5536:

  batman-adv: set the TAG flag for the vid passed to BLA (2013-09-17 21:15:16 +0200)

----------------------------------------------------------------
Included change:
- fix the Bridge Loop Avoidance component by marking the variables containing
  the VLAN ID with the HAS_TAG flag when needed.

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: set the TAG flag for the vid passed to BLA

 net/batman-adv/soft-interface.c | 2 ++
 1 file changed, 2 insertions(+)
