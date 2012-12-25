Return-Path: <davem@davemloft.net>
Date: Tue, 25 Dec 2012 13:37:53 -0800 (PST)
Message-Id: <20121225.133753.1383155065923849678.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAC5umyh1d9XxH2We4e2rjV-OYhbP2ObGC_iwrDeff2hphJ7TzQ@mail.gmail.com>
References: <1356315256-6572-20-git-send-email-akinobu.mita@gmail.com>
 <20121225112657.GC2604@ritirata.org>
 <CAC5umyh1d9XxH2We4e2rjV-OYhbP2ObGC_iwrDeff2hphJ7TzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 19/29] batman-adv: fix random jitter
	calculation
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, siwu@hrz.tu-chemnitz.de, akpm@linux-foundation.org, lindner_marek@yahoo.de

From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 26 Dec 2012 06:35:37 +0900

> 2012/12/25 Antonio Quartulli <ordex@autistici.org>:
>> On Mon, Dec 24, 2012 at 11:14:06AM +0900, Akinobu Mita wrote:
>>> batadv_iv_ogm_emit_send_time() attempts to calculates a random integer
>>> in the range of 'orig_interval +- BATADV_JITTER' by the below lines.
>>>
>>>         msecs = atomic_read(&bat_priv->orig_interval) - BATADV_JITTER;
>>>         msecs += (random32() % 2 * BATADV_JITTER);
>>>
>>> But it actually gets 'orig_interval' or 'orig_interval - BATADV_JITTER'
>>> because '%' and '*' have same precedence and associativity is
>>> left-to-right.
>>>
>>> This adds the parentheses at the appropriate position so that it matches
>>> original intension.
>>>
>>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>>> Cc: Marek Lindner <lindner_marek@yahoo.de>
>>> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
>>> Cc: Antonio Quartulli <ordex@autistici.org>
>>> Cc: b.a.t.m.a.n@lists.open-mesh.org
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: netdev@vger.kernel.org
>>> ---
>>
>> Acked-by: Antonio Quartulli <ordex@autistici.org>
>>
>> But I would suggest to apply this change to net, since it is a fix.
> 
> I agree.
> David, please consider to apply this patch for 3.8-rc*.
> 

All patches I should consider seriously should be properly
reposted for review and inclusion.
