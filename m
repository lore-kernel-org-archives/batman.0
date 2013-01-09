Return-Path: <gregkh@linuxfoundation.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed,  9 Jan 2013 12:35:23 -0800
Message-Id: <20130109201509.395329312@linuxfoundation.org>
In-Reply-To: <20130109201458.392601412@linuxfoundation.org>
References: <20130109201458.392601412@linuxfoundation.org>
Subject: [B.A.T.M.A.N.] [ 084/123] batman-adv: fix random jitter calculation
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, b.a.t.m.a.n@lists.open-mesh.org, Akinobu Mita <akinobu.mita@gmail.com>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, netdev@vger.kernel.org, Marek Lindner <lindner_marek@yahoo.de>, "David S. Miller" <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk

3.7-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 143cdd8f33909ff5a153e3f02048738c5964ba26 ]

batadv_iv_ogm_emit_send_time() attempts to calculates a random integer
in the range of 'orig_interval +- BATADV_JITTER' by the below lines.

        msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
        msecs += (random32() % 2 * BATADV_JITTER);

But it actually gets 'orig_interval' or 'orig_interval - BATADV_JITTER'
because '%' and '*' have same precedence and associativity is
left-to-right.

This adds the parentheses at the appropriate position so that it matches
original intension.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Antonio Quartulli <ordex@autistici.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
Cc: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_iv_ogm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -119,7 +119,7 @@ batadv_iv_ogm_emit_send_time(const struc
 	unsigned int msecs;
 
 	msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
-	msecs += (random32() % 2 * BATADV_JITTER);
+	msecs += random32() % (2 * BATADV_JITTER);
 
 	return jiffies + msecs_to_jiffies(msecs);
 }


