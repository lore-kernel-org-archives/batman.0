Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  6 Jun 2010 21:03:03 +0200
Message-Id: <1275850985-27105-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.35
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
To: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

Hi,

here are some patches which fixes different bugs in 2.6.35. These patches
collide with patches you already have received for 2.6.36. I will resend those
patches with resolved merge problems.

Best regards,
	Sven Eckelmann

 drivers/staging/batman-adv/bat_sysfs.c |   24 ++++++++++++------------
 drivers/staging/batman-adv/device.c    |    2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

Dan Carpenter (1):
      Staging: batman-adv: return -EFAULT on copy_to_user errors

Javier Martinez Canillas (1):
      Staging: batman-adv: fix function prototype

