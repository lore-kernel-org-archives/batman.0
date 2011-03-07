Return-Path: <davem@davemloft.net>
Date: Mon, 07 Mar 2011 01:19:22 -0800 (PST)
Message-Id: <20110307.011922.59669370.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <201103071001.39111.sven@narfation.org>
References: <1299328122-21468-1-git-send-email-sven@narfation.org>
	<20110306.181432.104062354.davem@davemloft.net>
	<201103071001.39111.sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2011-03-05
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
To: sven@narfation.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 7 Mar 2011 10:01:36 +0100

> On Monday 07 March 2011 03:14:32 David Miller wrote:
>> Can you like sync with me when you have less than 20+ patches queued
>> up?
>> 
>> It's too much at once to reasonably review, and makes regressions take
>> longer to bisect when people hit them.
> 
> I'll try. The problem is that most of it is one work package (the removal of 
> orig_hash) which I got in this amount of patches.
> 
> What do you think about another pull request which only has some of the 
> cleanup/fixes and leave the rest for the time after 2.6.39-rc1 - so it may get 
> into 2.6.40?

I already pulled this stuff into net-next-2.6
