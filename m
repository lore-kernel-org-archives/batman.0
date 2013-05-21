Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 21 May 2013 21:53:54 +0200
Message-Id: <1369166035-585-1-git-send-email-ordex@autistici.org>
In-Reply-To: <pull request for net: batman-adv 2013-05-21>
References: <pull request for net: batman-adv 2013-05-21>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] (no subject)
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

this is another small patch for net/linux-3.10. It is preventing a double free
of the bat_counters in case of mesh initialisation failure.

Sorry for sending such small pull requests (I guess this is not that bad since
they target net :-)), but these are small glitches we are finding while testing
new features.

Please pull or let me know if there is any problem.

Thanks a lot,
	Antonio


The following changes since commit 3ccfc1b1d2fa78f8ece83646027982916fcc794b:

  Merge branch 'for-davem' of git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless (2013-05-20 14:05:22 -0700)

are available in the git repository at:


  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to f69ae770e74df420fbcf93aae81b30a5dcc73b7d:

  batman-adv: Avoid double freeing of bat_counters (2013-05-21 21:34:36 +0200)

----------------------------------------------------------------
Included change:
- fix double free in case of failure during mesh initialisation

----------------------------------------------------------------
Martin Hundebøll (1):
      batman-adv: Avoid double freeing of bat_counters

 net/batman-adv/main.c           | 1 +
 net/batman-adv/soft-interface.c | 1 +
 2 files changed, 2 insertions(+)

