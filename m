Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 13 Oct 2009 00:48:49 +0800
References: <20091012081122.GB12833@lunn.ch>
In-Reply-To: <20091012081122.GB12833@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200910130048.49571.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Changing vis output ready for mainline...
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> 1) No other /proc file in mainline does any special formatting. Either
> comma separated value or space separated value is used. User space
> reads this and then performs any formatting needed.
> 
> 2) No other /proc file supports two userspace switchable formats!
> 
> 3) We have problems when multiple applications wants different formats
> at the same time. One wants dot the other wants JSON. Currently there
> is no locking, so something bad is going to happen.
> 
> What do others thing of this? Does anybody have a different proposal?

thanks a lot for summarizing the situation and pushing for a solution.

It seems we have to decide where we want to go with batctl. Until now batctl 
was not mandatory to operate the batman-adv kernel module. batctl extended the 
modules functionality and made things easier to configure but remained 
optional.

Personally, I like it a lot that way because it does not create unnecessary 
dependencies. It can become an uphill battle if you want to keep your kernel 
and its configuration tools in sync. Everyone that tried to use oprofile knows 
what I'm talking about (or the wireless tools to name another example).

So, the question is whether we want to make batctl the almighty tool that we 
always depend on or are we trying to find alternative solutions to avoid that 
dependency ?

One option for the case at hand might be debugfs 
(http://lwn.net/Articles/115282/). It is another filesystem which needs to be 
mounted seperately - there we can output whatever we want (unlike /proc). It 
would be possible to create virtual files for the dot draw / json / raw output 
(raw means the neutral format suggested by Andrew).

Soon we also will have to decide what to do with routing log as we can't 
"spam" the system log with our data. Again, debugfs seems like a good 
solution. That does not need to be decided now but could be a consistent path 
towards mainline integration.

Regards,
Marek
