Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 11 Mar 2013 23:12:27 +0100
Message-Id: <1363039948-27190-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2013-03-11
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

This is a single fix intended for net/linux-3.9 brought by Marek Lindner.
It ensures that the incoming originator message parsing routine does not
try to read beyond the packet boundary causing it to process random data.

This bug is in since a while..Please, consider sending this patch to stable.


Please pull or let me know if there is any problem!
Thank you,
	Antonio



The following changes since commit 7c6baa304b841673d3a55ea4fcf9a5cbf7a1674b:

  Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2013-03-11 07:54:29 -0700)

are available in the git repository at:


  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to b47506d91259c29b9c75c404737eb6525556f9b4:

  batman-adv: verify tt len does not exceed packet len (2013-03-11 22:59:47 +0100)

----------------------------------------------------------------
Included changes ares:
- fix packet parsing routine to avoid to read beyond the packet boundary

----------------------------------------------------------------
Marek Lindner (1):
      batman-adv: verify tt len does not exceed packet len

 net/batman-adv/bat_iv_ogm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
