Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 16 May 2012 20:23:25 +0200
Message-Id: <1337192605-8652-13-git-send-email-sven@narfation.org>
In-Reply-To: <1337192605-8652-1-git-send-email-sven@narfation.org>
References: <1779270.uUsuEFyTM4@sven-desktop.home.narfation.org>
	<1337192605-8652-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 13/13] batman-adv: Use typedef instead of
	define for type dat_addr_t
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

This wrong type definition was introduced in
a34852f63a694e3f35eb155101120a3c6f4dd6ee

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 types.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/types.h b/types.h
index 6f3d6f6..73aaef9 100644
--- a/types.h
+++ b/types.h
@@ -30,7 +30,7 @@
  *
  * *Please be careful: dat_addr_t must be UNSIGNED*
  */
-#define dat_addr_t uint16_t
+typedef uint16_t dat_addr_t;
 
 #endif /* CONFIG_BATMAN_ADV_DAT */
 
-- 
1.7.10

