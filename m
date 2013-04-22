Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 22 Apr 2013 10:38:13 +0200
Message-Id: <1366619894-16857-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] pull request net: batman-adv 2013-04-22
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

here we have another (I think the last) fix intended for net/linux-3.9.

This patch fixes a bug in the Translation Table component. In particular, when
batman-adv accesses the "inner Ethernet header", it has have to jump over its
header which can have two different lengths. The current code assumes
that this length is always the same and so leading to a wrong access.
This patch fixes it by making the "jump" generic.

The bug is not very critical because it "only" breaks our "smart rerouting
feature" and does not lead to a crash since the memory it accesses is always
allocated. I would send it to stable, but you can decide whether it is worth or
not.


Please pull or let me know if there is any problem.
Thanks a lot,
	Antonio

The following changes since commit 60d509fa6a9c4653a86ad830e4c4b30360b23f0e:

  Linux 3.9-rc8 (2013-04-21 14:38:45 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to dd981ab091cde09bb9eb23c8d81305ba615ee30c:

  batman-adv: use the proper header len when checking the TTVN (2013-04-22 09:55:23 +0200)

----------------------------------------------------------------
Included changes:
- fix Ethernet header access by jumping the correct batman-adv header

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: use the proper header len when checking the TTVN

 net/batman-adv/routing.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)
