Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat,  2 Jan 2010 11:30:37 +0100
Message-Id: <1262428252-26439-2-git-send-email-andrew@lunn.ch>
In-Reply-To: <1262428252-26439-1-git-send-email-andrew@lunn.ch>
References: <1262428252-26439-1-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 02/17] Staging: batman-adv: update README for
	latest kernel
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

From: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

state in the README that we also (compile) support 2.6.32

Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/staging/batman-adv/README |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/batman-adv/README b/drivers/staging/batman-adv/README
index a6a419d..2bedcbe 100644
--- a/drivers/staging/batman-adv/README
+++ b/drivers/staging/batman-adv/README
@@ -1,4 +1,4 @@
-[state: 13-11-2009]
+[state: 13-12-2009]
 
 BATMAN-ADV
 ----------
@@ -15,7 +15,7 @@ above B.A.T.M.A.N. Advanced, prominent examples are: IPv4, IPv6, DHCP, IPX.
 This is batman-advanced implemented as Linux kernel driver. It does not depend
 on any network (other) driver, and can be used on wifi as well as ethernet,
 vpn, etc ... (anything with ethernet-style layer 2).
-It compiles against and should work with Linux 2.6.20 - 2.6.31. Supporting older
+It compiles against and should work with Linux 2.6.20 - 2.6.32. Supporting older
 versions is not planned, but it's probably easy to backport it. If you work on a
 backport, feel free to contact us.  :-)
 
-- 
1.6.5.7

