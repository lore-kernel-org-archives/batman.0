Return-Path: <davem@davemloft.net>
Date: Wed, 26 Dec 2012 14:13:50 -0800 (PST)
Message-Id: <20121226.141350.999199516661256197.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1356525130-2688-1-git-send-email-akinobu.mita@gmail.com>
References: <1356525130-2688-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix random jitter calculation
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
To: akinobu.mita@gmail.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, siwu@hrz.tu-chemnitz.de, lindner_marek@yahoo.de

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 26 Dec 2012 21:32:10 +0900

> batadv_iv_ogm_emit_send_time() attempts to calculates a random integer
> in the range of 'orig_interval +- BATADV_JITTER' by the below lines.
> 
>         msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
>         msecs += (random32() % 2 * BATADV_JITTER);
> 
> But it actually gets 'orig_interval' or 'orig_interval - BATADV_JITTER'
> because '%' and '*' have same precedence and associativity is
> left-to-right.
> 
> This adds the parentheses at the appropriate position so that it matches
> original intension.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied, thanks.
