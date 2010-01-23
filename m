Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Jan 2010 11:27:30 +0800
References: <20100122100238.GL24649@lunn.ch>
In-Reply-To: <20100122100238.GL24649@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001231127.30577.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] State of batman-adv in mainline
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hey,

> Our first patch landed by GregKH just before the merge window for
> 2.6.33 opened. This patch made it into 2.6.33-rc1. So at around the
> end of march when 2.6.33 is released, we will be in mainline.
> 
> All patches submitted after this first big one was after the merge
> window closed. So they are currently queued up by GregKH. They appear
> in linux-next and should be accepted during the 2.6.34 merge window.

thanks a lot for posting this overview!


> 1) We should make it clear on www.open-mesh.org which version of
>    batctl should be used with 2.6.33. The trunk version will not work
>    correctly, an older version is needed. Probably we want to make a
>    tarball release and put it somewhere prominent on the website.

Since a while I maintain batctl 0.2.x in its own branch:
http://www.open-mesh.org/browser/branches/batctl-0.2.x
As the name implies it should be compatible with batman-adv 0.2.x. It does not 
contain any links and will build right out of this branch.
Are there any known incompatibilities between batman-adv in 2.6.33 and this 
branch ?


> 2) We still have the chance to get bug fixes into 2.6.33. Is there
>    anything in 2.6.33-rc5 which can cause oopses, deadlocks, etc?

As Sven already pointed out I merged all relevant bugfix patches into the maint 
branch. Unless I overlooked something it should be ready to go.


> 4) We should review what is currently in subversion but not yet pushed
>    to GregKH ready for 2.6.34. eg gateway support, vis server startup
>    fix, bonding, etc. In another email i will produce a list of
>    patches we should consider.

I think we should stick to our original agreement to not push new features too 
fast. Gateway stuff, bonding, etc need more time to mature.
The vis patch is waiting in the maint branch - ready for inclusion.  :)


> All this work is currently happening in staging. Once 2.6.33 is
> released we will get a bit more exposure and hopefully trigger some
> discussion. 2.6.34-rc1 will be a big step forward and i think at that
> point we should approach the linux networking guys and ask for a
> review. That would be one of the first steps of getting out of staging
> and somewhere under the net directory.

Ok, let's see what happens then.

Regards,
Marek
