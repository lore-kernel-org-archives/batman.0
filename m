Return-Path: <sergei.shtylyov@cogentembedded.com>
References: <20180524120300.15829-1-sw@simonwunderlich.de>
 <20180524120300.15829-3-sw@simonwunderlich.de>
 <fec8128d-0021-74db-b047-305fb1f70104@cogentembedded.com>
 <2946906.LStWHluSmG@bentobox>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <6fd70d33-11f7-33dd-3b11-e5031fe46466@cogentembedded.com>
Date: Fri, 25 May 2018 14:13:40 +0300
MIME-Version: 1.0
In-Reply-To: <2946906.LStWHluSmG@bentobox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/8] batman-adv: Disable
 CONFIG_BATMAN_ADV_DEBUGFS by default
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Joe Perches <joe@perches.com>

On 5/25/2018 1:50 PM, Sven Eckelmann wrote:

> [...]
>>> --- a/net/batman-adv/Kconfig
>>> +++ b/net/batman-adv/Kconfig
>>> @@ -94,13 +94,13 @@ config BATMAN_ADV_DEBUGFS
>>> bool "batman-adv debugfs entries"
>>> depends on BATMAN_ADV
>>> depends on DEBUG_FS
>>> -       default y
>>> +       default n
>>
>>      N is the default default. :-) You don't need this line.
> 
> Hm, looks like this would have to be changed in a lot of places (~782
> according to `git grep 'default n$'|wc -l` in my slightly outdated linux-
> next). Do you want to fix it everywhere?

    No, but we can at least not add the new ones...

> Might be good to get this integrated
> in checkpatch.pl when this will become a new policy.

    Adding Joe Perches. Joe, can you add a check for "default n"?

> Kind regards,
> 	Sven

MBR, Sergei
