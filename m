Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat,  1 Apr 2017 14:47:02 +0200
Message-Id: <20170401124706.18257-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/4] batman-adv: ethtool code cleanup
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

Philippe Reynes sent in a patch [1] to convert the get_settings stuff to
the new ethtool link_ksettings api. I've therefore asked Marek (original
author of the ethtool stubs) whether the code is still needed for
something.

He couldn't remember anything about it. This was therefore a good
opportunity to completely get rid of the code - instead of converting
not useful code to the new api.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/16982/

Sven Eckelmann (4):
  batman-adv: Use ethtool helper to get link status
  batman-adv: Remove ethtool msglevel functions
  batman-adv: Remove ethtool .get_settings stub
  batman-adv: Group ethtool related code together

 net/batman-adv/soft-interface.c | 229 ++++++++++++++++------------------------
 1 file changed, 92 insertions(+), 137 deletions(-)

-- 
2.11.0

