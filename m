Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 30 Sep 2010 14:08:40 +0200
Message-Id: <1285848524-13469-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] (no subject)
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

since the vis code and the bridge loop avoidance code already use
the kref library functions, I converted the remaining refcounting
code to use kref as well.

Regards,
Marek

Marek Lindner (4):
      batman-adv: convert gw_node custom refcounting to kref functions
      batman-adv: use rcu callbacks when freeing gw_nodes
      batman-adv: convert batman_if custom refcounting to kref functions
      batman-adv: use rcu callbacks when freeing batman_if

 batman-adv/bat_sysfs.c      |   12 ++++++------
 batman-adv/gateway_client.c |   30 ++++++++++++++++--------------
 batman-adv/hard-interface.c |   41 +++++++++++++++++++++++------------------
 batman-adv/hard-interface.h |   13 ++++---------
 batman-adv/types.h          |    6 ++++--
 5 files changed, 53 insertions(+), 49 deletions(-)
