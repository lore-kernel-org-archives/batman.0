Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 17 Aug 2013 12:34:53 +0200
Message-Id: <1376735694-676-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] pull request net: 2013-08-17
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

here you have another very small fix intended for net/linux-3.11.
Tha patch properly closes a seq_read session by adding an invocation to
skb_abort_seq_read().

Please pull or let me know if there is any problem.

Also, when do you plan to merge net into net-next? I have a couple of changes
for net-next which is better to apply after the merge.


Thanks a lot,
	Antonio


The following changes since commit 0f7dd1aa8f959216f1faa71513b9d3c1a9065e5a:

  Merge tag 'clk-fixes-for-linus' of git://git.linaro.org/people/mturquette/linux (2013-08-16 10:00:18 -0700)

are available in the git repository at:


  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 9863634227f1390737104f93c0748e6a7b52020e:

  batman-adv: properly end seq_read session (2013-08-17 12:23:37 +0200)

----------------------------------------------------------------
Included change:
- Add a missing skb_abort_seq_read() to properly close seq_read session

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: properly end seq_read session

 net/batman-adv/main.c | 1 +
 1 file changed, 1 insertion(+)n-Reply-To: 

Hello David,

here you have another very small fix for net/linux-3.11.
Tha patch properly closes a seq_read session by adding an invocation to
skb_abort_seq_read().

Please pull or let me know if there is any problem.

Also, when do you plan to merge net into net-next? I have a couple of changes
for net-next which is better to apply after the merge.


Thanks a lot,
	Antonio


The following changes since commit 0f7dd1aa8f959216f1faa71513b9d3c1a9065e5a:

  Merge tag 'clk-fixes-for-linus' of git://git.linaro.org/people/mturquette/linux (2013-08-16 10:00:18 -0700)

are available in the git repository at:


  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 9863634227f1390737104f93c0748e6a7b52020e:

  batman-adv: properly end seq_read session (2013-08-17 12:23:37 +0200)

----------------------------------------------------------------
Included change:
- Add a missing skb_abort_seq_read() to properly close seq_read session

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: properly end seq_read session

 net/batman-adv/main.c | 1 +
 1 file changed, 1 insertion(+)

