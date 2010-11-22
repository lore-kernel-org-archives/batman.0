Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 22 Nov 2010 12:34:47 +0100
Message-Id: <1290425690-5119-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <201011221129.06220.sven.eckelmann@gmx.de>
References: <201011221129.06220.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Staging: batman-adv for 2.6.37 (6)
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
Cc: b.a.t.m.a.n@lists.open-mesh.org


Hi,

I would like to propose following two patches which were already send to you
for 2.6.38 also for 2.6.37. These should be unchanged and you are free to
decide how you want to apply those to get them in both kernel version.

[PATCH 1/2] Staging: batman-adv: ensure that eth_type_trans gets linear memory
[PATCH 2/2] Staging: batman-adv: Don't remove interface with spinlock held


Following patch (backported version of patch 1/2) would be a candidate for
2.6.36 to fix a kernel Oops on Intel 3945ABG and Intel Corporation PRO/Wireless
4965 AG or AGN.

[PATCH-stable] Staging: batman-adv: ensure that eth_type_trans gets linear memory

thanks,
	Sven
