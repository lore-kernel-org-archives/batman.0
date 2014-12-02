Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
Date: Tue,  2 Dec 2014 12:16:31 +0100
Message-Id: <1417519009-20699-14-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
Subject: [B.A.T.M.A.N.] [PATCH 13/31] batman-adv: Makefile,
	Sort alphabetically
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
To: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

The whole Makefile is sorted, just the multicast rule is not at the
right position.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Makefile.kbuild | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index a8c34baddd63..6fb243c5b13c 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -29,6 +29,7 @@ batman-adv-y += hard-interface.o
 batman-adv-y += hash.o
 batman-adv-y += icmp_socket.o
 batman-adv-y += main.o
+batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
 batman-adv-$(CONFIG_BATMAN_ADV_NC) += network-coding.o
 batman-adv-y += originator.o
 batman-adv-y += routing.o
@@ -37,4 +38,3 @@ batman-adv-y += soft-interface.o
 batman-adv-y += sysfs.o
 batman-adv-y += translation-table.o
 batman-adv-y += tvlv.o
-batman-adv-$(CONFIG_BATMAN_ADV_MCAST) += multicast.o
-- 
2.1.3

