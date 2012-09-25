Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 25 Sep 2012 17:57:15 +0200
Message-Id: <1348588637-18441-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2012-09-25
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

here are two fixes (the last set) we would to propose for net/linux-3.6.

The one from Def fixes a wrong behaviour of batman-adv in case of virtual
interface mac address change, while the other from Linüs fixes a problem in the
route selection which can lead to a continuous route flapping under certain
conditions.

We would also like to enqueue both patches for sending to stable-3.5.

During merge with net/master you will hit a conflict. I'm going to send some
instructions on how to solve it.

Thank you very much,
		Antonio



The following changes since commit 2b018d57ff18e5405823e5cb59651a5b4d946d7b:

  pppoe: drop PPPOX_ZOMBIEs in pppoe_release (2012-09-22 15:49:31 -0400)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 7caf69fb9c5017df01945a1861c042f6aa08edeb:

  batman-adv: Fix symmetry check / route flapping in multi interface setups (2012-09-23 23:12:49 +0200)

----------------------------------------------------------------
Included fixes:
- fix the behaviour of batman-adv in case of virtual interface MAC change event
- fix symmetric link check in neighbour selection

----------------------------------------------------------------
Def (1):
      batman-adv: Fix change mac address of soft iface.

Linus Lüssing (1):
      batman-adv: Fix symmetry check / route flapping in multi interface setups

 net/batman-adv/bat_iv_ogm.c     | 13 +++++++------
 net/batman-adv/soft-interface.c |  7 +++++--
 2 files changed, 12 insertions(+), 8 deletions(-)
