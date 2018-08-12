Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 12 Aug 2018 21:04:40 +0200
Message-Id: <20180812190445.28013-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/5] batman-adv: Missing list checks for
 *list_add*
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

over two years ago, I've added some tickets [1,2,3,4,5,6,7] about
missing/not properly locked list checks for functions which create new list
entries. Only Linus created a patch [8] and the other tickets were ignored.

I have therefore now created the minimal version of the patches.

Kind regards,
	Sven

[1] https://www.open-mesh.org/issues/235
[2] https://www.open-mesh.org/issues/236
[3] https://www.open-mesh.org/issues/237
[4] https://www.open-mesh.org/issues/238
[5] https://www.open-mesh.org/issues/239
[6] https://www.open-mesh.org/issues/240
[7] https://www.open-mesh.org/issues/241
[8] https://patchwork.open-mesh.org/patch/4919/

Sven Eckelmann (5):
  batman-adv: Prevent duplicated gateway_node entry
  batman-adv: Prevent duplicated nc_node entry
  batman-adv: Prevent duplicated softif_vlan entry
  batman-adv: Prevent duplicated global TT entry
  batman-adv: Prevent duplicated tvlv handler

 net/batman-adv/gateway_client.c    |  8 ++++++--
 net/batman-adv/network-coding.c    | 27 +++++++++++++++------------
 net/batman-adv/soft-interface.c    | 21 ++++++++++++---------
 net/batman-adv/translation-table.c |  6 ++++--
 net/batman-adv/tvlv.c              |  8 ++++++--
 5 files changed, 43 insertions(+), 27 deletions(-)

-- 
2.18.0

