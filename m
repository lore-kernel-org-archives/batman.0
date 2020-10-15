Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] batman-adv: compat: Fix prandom.h include for older LTS kernels
Date: Thu, 15 Oct 2020 21:10:09 +0200
Message-Id: <20201015191009.34021-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Sven Eckelmann <sven@narfation.org>

The longterm stable kernels 4.4.x and 4.9.x were missing the
linux/prandom.h for a long time but the commit c0842fbc1b18 ("random32:
move the pseudo-random 32-bit definitions to prandom.h") was recently
backported. Due to this change, it was no longer possible for batman-adv to
find the prandom_u32_max definition. This resulted in a build error:

  net/batman-adv/bat_iv_ogm.c:284:18: error: undefined identifier 'prandom_u32_max'
  net/batman-adv/bat_iv_ogm.c:292:43: error: undefined identifier 'prandom_u32_max'
  net/batman-adv/bat_iv_ogm.c: In function ‘batadv_iv_ogm_emit_send_time’:
  net/batman-adv/bat_iv_ogm.c:284:11: error: implicit declaration of function ‘prandom_u32_max’ [-Werror=implicit-function-declaration]
    msecs += prandom_u32_max(2 * BATADV_JITTER);

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 compat-include/linux/prandom.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat-include/linux/prandom.h b/compat-include/linux/prandom.h
index 2863a57d..9d30d2d9 100644
--- a/compat-include/linux/prandom.h
+++ b/compat-include/linux/prandom.h
@@ -12,6 +12,8 @@
 
 #include <linux/version.h>
 #if LINUX_VERSION_IS_GEQ(5, 8, 1) || \
+    (LINUX_VERSION_IS_GEQ(4, 4, 233) && LINUX_VERSION_IS_LESS(4, 5, 0)) || \
+    (LINUX_VERSION_IS_GEQ(4, 9, 233) && LINUX_VERSION_IS_LESS(4, 10, 0)) || \
     (LINUX_VERSION_IS_GEQ(4, 14, 193) && LINUX_VERSION_IS_LESS(4, 15, 0)) || \
     (LINUX_VERSION_IS_GEQ(4, 19, 138) && LINUX_VERSION_IS_LESS(4, 20, 0)) || \
     (LINUX_VERSION_IS_GEQ(5, 4, 57) && LINUX_VERSION_IS_LESS(5, 5, 0)) || \
-- 
2.28.0

