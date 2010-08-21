Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 21 Aug 2010 14:18:07 +0200
Message-Id: <1282393090-27411-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.36 (7: fixes)
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
To: greg@kroah.com
Cc: b.a.t.m.a.n@lists.open-mesh.net

Hi,

here are patches targeted for 2.6.36. They are smaller bugfixes and add
no new features.

I already send you 5 Patches two weeks ago which fixes problems in 2.6.36 and
one of them also in 2.6.35, but got no reply till now. So here is the reminder
you asked me before.

The patches for 2.6.37 will follow later.

thanks,
	Sven

Sven Eckelmann (3):
      Staging: batman-adv: Create batman_if only on register event
      Staging: batman-adv: Don't use net_dev after dev_put
      Staging: batman-adv: Don't write in not allocated packet_buff

 drivers/staging/batman-adv/hard-interface.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)
