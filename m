Return-Path: <andrew@lunn.ch>
Date: Wed, 26 Aug 2009 20:25:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20090826182548.GG16067@lunn.ch>
References: <20090825200530.GA21951@lunn.ch>
 <20090825201457.GA5070@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090825201457.GA5070@suse.de>
Subject: Re: [B.A.T.M.A.N.] Getting batman into staging
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
To: Greg KH <gregkh@suse.de>
Cc: b.a.t.m.a.n@lists.open-mesh.net

Hi Greg

CC: to the batman list should now work for you. Your email address has
been listed as O.K. to accept. There is an ongoing discussion about an
open list and fighting SPAM etc.

> But first off, what is keeping this code from being added to the "main"
> portion of the kernel tree?  Have you submitted it for inclusion there
> already?  If so, what was the response?  If not, why not?
 
I'm reasonably new to the project so don't know the history too
well. I get the impression the code has not been sent to lkml or
linux-net list. There seems to be a perception within the developers
that getting code into mainline is difficult, so why bother when it
has been going O.K. out of mainline. I think you saying it could go
into staging right now has taken quite a few people by surprise.

Is staging the right way to do this? Is posting to say linux-net
better for this sort of code?

> Sound good?  If so, send me some patches!

Assuming we do go via staging, do you want one jumbo patch, 6500 lines
of code, or should i break it up into smaller chunks?

   Thanks
        Andrew
