Return-Path: <akinobu.mita@gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu,  3 Jan 2013 21:19:15 +0900
Message-Id: <1357215562-6288-20-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1357215562-6288-1-git-send-email-akinobu.mita@gmail.com>
References: <1357215562-6288-1-git-send-email-akinobu.mita@gmail.com>
Subject: [B.A.T.M.A.N.] [PATCH -v2 19/26] batman-adv: rename random32() to
	prandom_u32()
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
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Akinobu Mita <akinobu.mita@gmail.com>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>, "David S. Miller" <davem@davemloft.net>

Use more preferable function name which implies using a pseudo-random
number generator.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Cc: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
---

No change from v1

 net/batman-adv/bat_iv_ogm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 7d02ebd..bc434c4 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -123,7 +123,7 @@ batadv_iv_ogm_emit_send_time(const struct batadv_priv *bat_priv)
 	unsigned int msecs;
 
 	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
-	msecs += random32() % (2 * BATADV_JITTER);
+	msecs += prandom_u32() % (2 * BATADV_JITTER);
 
 	return jiffies + msecs_to_jiffies(msecs);
 }
@@ -131,7 +131,7 @@ batadv_iv_ogm_emit_send_time(const struct batadv_priv *bat_priv)
 /* when do we schedule a ogm packet to be sent */
 static unsigned long batadv_iv_ogm_fwd_send_time(void)
 {
-	return jiffies + msecs_to_jiffies(random32() % (BATADV_JITTER / 2));
+	return jiffies + msecs_to_jiffies(prandom_u32() % (BATADV_JITTER / 2));
 }
 
 /* apply hop penalty for a normal link */
-- 
1.7.11.7

