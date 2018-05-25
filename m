Return-Path: <davem@davemloft.net>
Date: Fri, 25 May 2018 14:39:50 -0400 (EDT)
Message-Id: <20180525.143950.1016974537238779353.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <ffef0c24-37af-f58e-47b7-ed5ed41af70f@cogentembedded.com>
References: <6fd70d33-11f7-33dd-3b11-e5031fe46466@cogentembedded.com>
 <2273548.5hmqMeOsCk@bentobox>
 <ffef0c24-37af-f58e-47b7-ed5ed41af70f@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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
To: sergei.shtylyov@cogentembedded.com
Cc: sven@narfation.org, sw@simonwunderlich.de, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, joe@perches.com

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 25 May 2018 18:56:09 +0300

> On 05/25/2018 02:15 PM, Sven Eckelmann wrote:
> 
>>>> [...]
>>>>>> --- a/net/batman-adv/Kconfig
>>>>>> +++ b/net/batman-adv/Kconfig
>>>>>> @@ -94,13 +94,13 @@ config BATMAN_ADV_DEBUGFS
>>>>>> bool "batman-adv debugfs entries"
>>>>>> depends on BATMAN_ADV
>>>>>> depends on DEBUG_FS
>>>>>> -       default y
>>>>>> +       default n
>>>>>
>>>>> N is the default default. :-) You don't need this line.
>>>>
>>>> Hm, looks like this would have to be changed in a lot of places (~782
>>>> according to `git grep 'default n$'|wc -l` in my slightly outdated linux-
>>>> next). Do you want to fix it everywhere?
>>>
>>>     No, but we can at least not add the new ones...
>> 
>> But the patch was added to net-next yesterday.
> 
>    DaveM is still too fast for me. :-)

No worries, just let's get a patch to remove the line.
