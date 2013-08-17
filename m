Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 17 Aug 2013 13:04:44 +0200
Message-Id: <1376737486-1863-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request net: 2013-08-17b
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

here is the correct pull request for net/linux-3.11.

As described earlier this patchset contains a change which properly ends a
seq_read cycle and another change that takes care of aborting TX operations if
the skb preparation should faile.

Please pull or let me know if there is any problem.

(about merge of net into net-next?)

Thanks a lot!
	Antonio


The following changes since commit 0f7dd1aa8f959216f1faa71513b9d3c1a9065e5a:

  Merge tag 'clk-fixes-for-linus' of git://git.linaro.org/people/mturquette/linux (2013-08-16 10:00:18 -0700)

are available in the git repository at:


  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to d823c33c0717cffea2dc73180ef780bf626908c7:

  batman-adv: check return type of unicast packet preparations (2013-08-17 12:52:27 +0200)

----------------------------------------------------------------
Included change:
- Add a missing skb_abort_seq_read() to properly close seq_read session
- Check if the skb has been correctly prepared before going on

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: properly end seq_read session

Linus Lüssing (1):
      batman-adv: check return type of unicast packet preparations

 net/batman-adv/main.c    |  1 +
 net/batman-adv/unicast.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

