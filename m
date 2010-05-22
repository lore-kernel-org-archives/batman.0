Return-Path: <gregkh@suse.de>
Date: Sat, 22 May 2010 07:35:20 -0700
From: Greg KH <gregkh@suse.de>
Message-ID: <20100522143520.GB4070@suse.de>
References: <201005221616.46785.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005221616.46785.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/26] Staging: batman-adv
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.net

On Sat, May 22, 2010 at 04:16:45PM +0200, Sven Eckelmann wrote:
> Hi,
> 
> we've tried to fix the outstanding problem regarding the sysfs filesystem and
> fixed some further smaller problems. I hope that it is right were we put the 
> ABI documentation.

Not really, but I responded to where it should go on that message.

As we are now past the .35 merge window, you should consider what
patches should be acceptable for the .35 release, and which should wait
until .36.  It looks like about half of these patches should be queued
up for .35 as they are bug fixes, right?  The api changes by moving
stuff into debugfs should wait for .36.

So could you split this patch set up into two different ones?  One you
want to see go into .35 and one for .36?

thanks,

greg k-h
