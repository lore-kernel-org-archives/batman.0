Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 22 Sep 2011 20:57:15 +0200
Message-Id: <1316717836-19374-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2011-09-22 (regression fix)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi David,

our testers have discovered a regression in the current linux-3.1
code base. It increases latency of payload traffic by a factor of
4-5. Therefore we propose a patch that hopefully can be included 
before linux 3.1 final has been released. We kept it as short as 
possible to avoid introducing last minute bugs.

Once you pulled the patch you will run into a merge conflict
with net-next:
++<<<<<<< HEAD
 + orig_node = transtable_search(bat_priv, ethhdr->h_source,
 +                               ethhdr->h_dest);
 + if (is_multicast_ether_addr(ethhdr->h_dest) ||
 + (orig_node && orig_node->gw_flags)) {
++=======
+ orig_node = transtable_search(bat_priv, ethhdr->h_dest);
+ do_bcast = is_multicast_ether_addr(ethhdr->h_dest);
+ if (do_bcast || (orig_node && orig_node->gw_flags)) {
++>>>>>>> batman-adv/maint

The correct merge result would be:
+======
orig_node = transtable_search(bat_priv, ethhdr->h_source,
                              ethhdr->h_dest);
do_bcast = is_multicast_ether_addr(ethhdr->h_dest);
if (do_bcast || (orig_node && orig_node->gw_flags)) {
+======

Let me know if there is a better way to address the merge conflict.

Thanks,
Marek

The following changes since commit 322a8b034003c0d46d39af85bf24fee27b902f48:

  Linux 3.1-rc1 (2011-08-07 18:23:30 -0700)

are available in the git repository at:
  git://git.open-mesh.org/linux-merge.git batman-adv/maint

Antonio Quartulli (1):
      batman-adv: do_bcast has to be true for broadcast packets only

 net/batman-adv/soft-interface.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

