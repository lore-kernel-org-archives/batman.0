Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 18 Oct 2012 11:43:54 +0200
Message-Id: <1350553434-6722-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Recommend not to change Makefile
	for configuration
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

The Makefile suggests to change it to enable or disable features. This resulted
in patch submissions with changed Makefile even when this change would not be
necessary.

Instead the configuration should be done using the make parameters explained in
README.external

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c6266a2..4d70e40 100644
--- a/Makefile
+++ b/Makefile
@@ -18,7 +18,7 @@
 # 02110-1301, USA
 #
 
-# changing the CONFIG_* line to 'y' enables the related feature
+# read README.external for more information about the configuration
 # B.A.T.M.A.N. debugging:
 export CONFIG_BATMAN_ADV_DEBUG=n
 # B.A.T.M.A.N. bridge loop avoidance:
-- 
1.7.10.4

