Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed,  1 Mar 2017 16:53:31 +0100
Message-Id: <20170301155333.19406-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/2] pull request for net: batman-adv
	2017-03-01
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

here are two bugfixes which we would like to see integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 4ea33ef0f9e95b69db9131d7afd98563713e81b0:

  batman-adv: Decrease hardif refcnt on fragmentation send error (2017-01-04 08:22:04 +0100)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20170301

for you to fetch changes up to 51c6b429c0c95e67edd1cb0b548c5cf6a6604763:

  batman-adv: Fix transmission of final, 16th fragment (2017-02-21 18:33:35 +0100)

----------------------------------------------------------------
Here are two batman-adv bugfixes:

 - fix a potential double free when fragment merges fail,
   by Sven Eckelmann

 - fix failing tranmission of the 16th (last) fragment if that exists,
   by Linus Lüssing

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: Fix transmission of final, 16th fragment

Sven Eckelmann (1):
      batman-adv: Fix double free during fragment merge error

 net/batman-adv/fragmentation.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)
