Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 19 Aug 2013 18:59:54 +0200
Message-Id: <1376931595-2070-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request net: 2013-08-19
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

after a not so quiet weekend, here is my small pull request intended for
net/linux-3.11.

This is a fix that aims to block TX operations in case of skb preparation
failure.


Please pull or let me know of any problem.

Thanks,
	Antonio

p.s. is net going to be merged into net-next one of these days? I need it in
order to send a couple of changes to net-next.


The following changes since commit 0f7dd1aa8f959216f1faa71513b9d3c1a9065e5a:

  Merge tag 'clk-fixes-for-linus' of git://git.linaro.org/people/mturquette/linux (2013-08-16 10:00:18 -0700)

are available in the git repository at:


  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 50fa3b31f4700deb1a860fa1a04016b889765323:

  batman-adv: check return type of unicast packet preparations (2013-08-17 20:02:32 +0200)

----------------------------------------------------------------
Included change:
- Check if the skb has been correctly prepared before going on

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: check return type of unicast packet preparations

 net/batman-adv/unicast.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
