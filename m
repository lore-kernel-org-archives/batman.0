Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 26 Mar 2018 14:47:52 +0200
Message-Id: <20180326124754.5897-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/2] pull request for net: batman-adv
 2018-03-26
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>

Hi David,

here are two late bugfixes for batman-adv which we would like to have in net
if still possible.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit fc04fdb2c8a894283259f5621d31d75610701091:

  batman-adv: Fix skbuff rcsum on packet reroute (2018-03-18 13:20:32 +0100)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20180326

for you to fetch changes up to a752c0a4524889cdc0765925258fd1fd72344100:

  batman-adv: fix packet loss for broadcasted DHCP packets to a server (2018-03-24 10:25:49 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - fix multicast-via-unicast transmissions for AP isolation and gateway
   extension, by Linus Luessing (2 patches)

----------------------------------------------------------------
Linus Lüssing (2):
      batman-adv: fix multicast-via-unicast transmission with AP isolation
      batman-adv: fix packet loss for broadcasted DHCP packets to a server

 net/batman-adv/gateway_client.c | 5 ++++-
 net/batman-adv/multicast.c      | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)
