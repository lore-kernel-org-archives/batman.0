Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed,  9 Dec 2009 21:09:25 +0100
Message-Id: <1260389373-1071-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1260389373-1071-2-git-send-email-andrew@lunn.ch>
References: <1260389373-1071-1-git-send-email-andrew@lunn.ch>
	<1260389373-1071-2-git-send-email-andrew@lunn.ch>
Sender: Andrew Lunn <andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCH 02/10] staging:batman-adv: batctl adapt
	batctl to the new logging mechanisms
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
Cc: devel@driverdev.osuosl.org, Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

From: marek <marek@45894c77-fb22-0410-b583-ff6e7d5dbf6c>

Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
git-svn-id: http://downloads.open-mesh.net/svn/batman/trunk/batman-adv-kernelland@1483 45894c77-fb22-0410-b583-ff6e7d5dbf6c
---
 Makefile.kbuild |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.kbuild b/Makefile.kbuild
index 418c1cc..401f648 100644
--- a/Makefile.kbuild
+++ b/Makefile.kbuild
@@ -25,7 +25,7 @@ ifeq ($(MAKING_MODULES),1)
 -include $(TOPDIR)/Rules.make
 endif
 
-#EXTRA_CFLAGS += -DCONFIG_BATMAN_DEBUG
+# EXTRA_CFLAGS += -DCONFIG_BATMAN_DEBUG
 
 ifneq ($(REVISION),)
 EXTRA_CFLAGS += -DREVISION_VERSION=\"r$(REVISION)\"
-- 
1.6.5.4

