Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 10 Aug 2013 23:08:00 +0200
Message-Id: <1376168881-4079-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request for net: batman-adv 2013-08-10
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

here you have one fix intended for net/linux-3.11.

To avoid kernel paging errors, this patch takes care of re-assigning the value
of skb->data to the related pointers after that the skb has been re-allocated.


Please pull or let me know of any problem!

Thank you,
	Antonio



The following changes since commit 645359930231d5e78fd3296a38b98c1a658a7ade:

  rtnetlink: Fix inverted check in ndo_dflt_fdb_del() (2013-08-10 01:24:12 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 9d2c9488cedb666bc8206fbdcdc1575e0fbc5929:

  batman-adv: fix potential kernel paging errors for unicast transmissions (2013-08-10 22:55:42 +0200)

----------------------------------------------------------------
Included change:
- reassign pointers to data after skb reallocation to avoid kernel paging errors

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: fix potential kernel paging errors for unicast transmissions

 net/batman-adv/bridge_loop_avoidance.c |  2 ++
 net/batman-adv/gateway_client.c        | 13 ++++++++++++-
 net/batman-adv/gateway_client.h        |  3 +--
 net/batman-adv/soft-interface.c        |  9 ++++++++-
 net/batman-adv/unicast.c               | 13 ++++++++++---
 5 files changed, 33 insertions(+), 7 deletions(-)
