Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 30 Oct 2012 14:09:43 +0100
Message-Id: <1351602589-22844-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 0/6] TT improvement campaign
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello,

as you may have seen in the last period, TT has been under heavily
re-design/work in order to improve its robustness (and also readability).
However, some more extensive tests and emulated scenarios revealed that it is
possible to hit some situations in which TT behaviour is not optimal.

This set of patches aims to fix some glitches introduces with the last re-design
and to fix some issues discovered by testing complex scenarios.

Cheers,


Antonio Quartulli (6):
  batman-adv: fix TT packet rerouting
  batman-adv: fix debug message
  batman-adv: remove useless goto
  batman-adv: send ROAMING_ADV once
  batman-adv: remove useless assignment in tt_local_add()
  batman-adv: fix local client recognition in is_my_client()

 routing.c           | 36 ++++++++++++++++++++++++++----------
 translation-table.c | 22 +++++++++++-----------
 2 files changed, 37 insertions(+), 21 deletions(-)

-- 
1.7.12.4

