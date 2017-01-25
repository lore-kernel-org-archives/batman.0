Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 25 Jan 2017 17:25:05 +0100
Message-Id: <20170125162506.12642-1-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/1] pull request for net: batman-adv
	2017-01-25
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

here is a bugfix for net which we would like to have integrated.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20170125

for you to fetch changes up to 4ea33ef0f9e95b69db9131d7afd98563713e81b0:

  batman-adv: Decrease hardif refcnt on fragmentation send error (2017-01-04 08:22:04 +0100)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - fix reference count handling on fragmentation error, by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (1):
      batman-adv: Decrease hardif refcnt on fragmentation send error

 net/batman-adv/fragmentation.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
