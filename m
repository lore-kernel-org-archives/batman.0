Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 18 Oct 2011 23:01:07 +0200
Message-Id: <1318971669-941-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2011-10-18 (more regression
	fixes)
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

Hi David,

we have identified and fixed 2 more critical bugs in the linux-3.1
code base. We are somewhat late in the 3.1 release cycle but hoped
to take advantage of the delayed release to get these patches 
included before the final version is out. If not I will have to
send these patches to stable@ and would like to see these patches
applied to net-next-2.6/3.2. No merge conflicts are to be expected.
Let us know what works best for you.

Thanks,
Marek

The following changes since commit 8b267b312df9343fea3bd679c509b36214b5a854:

  batman-adv: do_bcast has to be true for broadcast packets only (2011-09-22 20:27:10 +0200)

are available in the git repository at:
  git://git.open-mesh.org/linux-merge.git batman-adv/maint

Antonio Quartulli (2):
      batman-adv: fix tt_local_reset_flags() function
      batman-adv: correctly set the data field in the TT_REPONSE packet

 net/batman-adv/translation-table.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)


