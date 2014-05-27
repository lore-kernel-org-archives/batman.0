Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 27 May 2014 04:25:46 +0200
Message-Id: <1401157547-25199-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] pull request net: batman-adv 20140527
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

here you have another very small fix intended for net/linux-3.15.
It prevents some multicast functions from dereferencing a NULL pointer.
(Actually it was nothing more than a typ0)
I hope it is not too late for such a small patch.


Please pull or let me know of any problem

Thanks a lot,
	Antonio



The following changes since commit b6ed5498601df40489606dbc14a9c7011c16630b:

  batman: fix a bogus warning from batadv_is_on_batman_iface() (2014-05-22 17:23:00 -0400)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git 

for you to fetch changes up to 9d4190df6a21d96238133a9a64866a9c796f4ec8:

  batman-adv: fix NULL pointer dereferences (2014-05-23 16:32:32 +0200)

----------------------------------------------------------------
Included changes:
- prevent NULL dereference in multicast code

----------------------------------------------------------------
Marek Lindner (1):
      batman-adv: fix NULL pointer dereferences

 net/batman-adv/multicast.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
