Return-Path: <davem@davemloft.net>
Date: Wed, 02 Mar 2016 13:46:03 -0500 (EST)
Message-Id: <20160302.134603.447218907358875583.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160302144607.GH7704@prodigo.lan>
References: <1456926882-2941809-1-git-send-email-arnd@arndb.de>
 <20160302144607.GH7704@prodigo.lan>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: clarify CFG80211 dependency
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc
Cc: mareklindner@neomailbox.ch, arnd@arndb.de, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Antonio Quartulli <a@unstable.cc>
Date: Wed, 2 Mar 2016 22:46:07 +0800

> On Wed, Mar 02, 2016 at 02:54:35PM +0100, Arnd Bergmann wrote:
>> The driver calls cfg80211_get_station, which may be part of a
>> module, so we must not enable BATMAN_ADV_BATMAN_V if
>> BATMAN_ADV=y and CFG80211=m:
>> 
>> net/built-in.o: In function `batadv_v_elp_get_throughput':
>> (text+0x5c62c): undefined reference to `cfg80211_get_station'
>> 
>> This clarifies the dependency to cover all combinations.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: c833484e5f38 ("batman-adv: ELP - compute the metric based on the estimated throughput")
> 
> Acked-by: Antonio Quartulli <a@unstable.cc>
> 
> Thanks a lot Arnd!
> 
> David, could you please merge this change in net-next directly ?

Done, applied, thanks everyone.
