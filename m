Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 18 Oct 2012 21:24:53 +0200
Message-Id: <1350588295-22587-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2012-10-18
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

here are two fixes intended for net. The first one fixes the CRC computation
used to check for broadcast packet duplicates. The wrong result lead to many
(more than 80%) broadcast packets being dropped and so making the network very
slow and mostly unusable. Think about all the ARP or DHCP requests not going
through.

The second patch fixes a potential race condition, still in the same duplicated
broadcast check procedure, which can lead to wrong outcomes under certain
circumstances.

I would also like to enqueue patch 1/2 for sending to stable-{3.5/3.6}.

Thanks a lot,
	Antonio




The following changes since commit 43c422eda99b894f18d1cca17bcd2401efaf7bd0:

  apparmor: fix apparmor OOPS in audit_log_untrustedstring+0x1c/0x40 (2012-10-17 16:29:46 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 7dac7b76b8db87fc79857a53a09730fb2148579b:

  batman-adv: Fix potential broadcast BLA-duplicate-check race condition (2012-10-18 18:17:31 +0200)

----------------------------------------------------------------
Included fixes:
- Fix broadcast packet CRC calculation which can lead to ~80% broadcast packet
  loss
- Fix a race condition in duplicate broadcast packet check

----------------------------------------------------------------
Linus Lüssing (2):
      batman-adv: Fix broadcast packet CRC calculation
      batman-adv: Fix potential broadcast BLA-duplicate-check race condition

 net/batman-adv/bridge_loop_avoidance.c | 27 ++++++++++++++++++---------
 net/batman-adv/routing.c               |  8 +++++++-
 net/batman-adv/types.h                 |  2 ++
 3 files changed, 27 insertions(+), 10 deletions(-)
