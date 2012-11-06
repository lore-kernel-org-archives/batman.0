Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  6 Nov 2012 12:05:18 +0100
Message-Id: <1352199923-16653-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 0/5] TT "fixing" campaign
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
This is a second version of the TT patchset I recently sent.
In this case I decided to rearrange the patches. Pathces listed here are not
improvements, but they are fixes that should go into batman-adv/next.

The remaining patches, which are improvements intended for batman-adv/master,
will be sent in another patchset soon.


Thank you,


Antonio Quartulli (5):
  batman-adv: fix TT packet rerouting
  batman-adv: fix debug message
  batman-adv: remove useless goto
  batman-adv: send ROAMING_ADV once
  batman-adv: fix local client recognition in is_my_client()

 routing.c           | 36 ++++++++++++++++++++++++++----------
 translation-table.c | 10 ++++++----
 2 files changed, 32 insertions(+), 14 deletions(-)

-- 
1.8.0

