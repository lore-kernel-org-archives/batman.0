Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed,  9 Dec 2009 21:09:33 +0100
Message-Id: <1260389373-1071-11-git-send-email-andrew@lunn.ch>
In-Reply-To: <1260389373-1071-10-git-send-email-andrew@lunn.ch>
References: <1260389373-1071-1-git-send-email-andrew@lunn.ch>
	<1260389373-1071-2-git-send-email-andrew@lunn.ch>
	<1260389373-1071-3-git-send-email-andrew@lunn.ch>
	<1260389373-1071-4-git-send-email-andrew@lunn.ch>
	<1260389373-1071-5-git-send-email-andrew@lunn.ch>
	<1260389373-1071-6-git-send-email-andrew@lunn.ch>
	<1260389373-1071-7-git-send-email-andrew@lunn.ch>
	<1260389373-1071-8-git-send-email-andrew@lunn.ch>
	<1260389373-1071-9-git-send-email-andrew@lunn.ch>
	<1260389373-1071-10-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 10/10] staging:batman-adv:Add Kconfig
	dependancies on PROC_FS and PACKET.
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
Cc: devel@driverdev.osuosl.org, b.a.t.m.a.n@lists.open-mesh.net

Signed-off-by: Andrew Lunn <andrew@lunn.ch>

---
 drivers/staging/batman-adv/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/batman-adv/Kconfig b/drivers/staging/batman-adv/Kconfig
index 698eb31..69e8fb0 100644
--- a/drivers/staging/batman-adv/Kconfig
+++ b/drivers/staging/batman-adv/Kconfig
@@ -4,6 +4,7 @@
 
 config BATMAN_ADV
 	tristate "B.A.T.M.A.N. Advanced Meshing Protocol"
+	depends on PROC_FS && PACKET
         default n
 	---help---
 
-- 
1.6.5.4

