Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 19 Apr 2013 11:04:50 +0200
Message-Id: <1366362292-22961-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH net-next 0/2] batman-adv: fixes for net-next
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <ordex@autistici.org>

Hello David,

here you have two fixes for net-next. One is fixing the compile issues
introduced by the merge of net into net-next and one is fixing a bug in a
component existing in net-next only.


I'm not sending a pull request because I'm anticipating your merge of net into
net-next and so I don't have a base point.


I hope it is fine with you.

Thanks a lot,
	Antonio


Antonio Quartulli (2):
  batman-adv: fix batadv_is_my_mac() usage
  batman-adv: fix global protection fault during soft_iface destruction

 net/batman-adv/main.c           |  6 ++++++
 net/batman-adv/network-coding.c | 18 ++++++++++--------
 net/batman-adv/routing.c        |  1 +
 net/batman-adv/soft-interface.c |  7 +++++++
 4 files changed, 24 insertions(+), 8 deletions(-)

-- 
1.8.1.5

