Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 27 Jul 2011 11:47:41 +0200
Message-Id: <1311760070-21532-2-git-send-email-sven@narfation.org>
In-Reply-To: <1311760070-21532-1-git-send-email-sven@narfation.org>
References: <1311760070-21532-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 02/11] batman-adv: Remove private define of
	atomic_dec_not_zero
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
To: linux-arch@vger.kernel.org
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>, linux-kernel@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

atomic_dec_not_zero is defined through <linux/atomic.h> for all
architectures and batman-adv doesn't need an extra define which may
collide with the global one.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org
---
 net/batman-adv/main.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index a6df61a..d986f34 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -201,8 +201,6 @@ static inline int compare_eth(const void *data1, const void *data2)
 }
 
 
-#define atomic_dec_not_zero(v)	atomic_add_unless((v), -1, 0)
-
 /* Returns the smallest signed integer in two's complement with the sizeof x */
 #define smallest_signed_int(x) (1u << (7u + 8u * (sizeof(x) - 1u)))
 
-- 
1.7.5.4

