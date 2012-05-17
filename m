Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 17 May 2012 19:53:54 +0800
References: <1335689867-8017-7-git-send-email-ordex@autistici.org>
	<20120430.205904.288157818941040253.davem@davemloft.net>
	<201205121626.38520.lindner_marek@yahoo.de>
In-Reply-To: <201205121626.38520.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201205171953.54891.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 06/15] batman-adv: Distributed ARP Table
	- add snooping functions for ARP messages
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>


David,

> On Tuesday, May 01, 2012 08:59:04 David Miller wrote:
> > From: Antonio Quartulli <ordex@autistici.org>
> > Date: Tue, 1 May 2012 00:22:30 +0200
> > 
> > > However this patch also contains a procedure which queries the neigh
> > > table in order to understand whether a given host is known or not.
> > > Would it be possible to do that in another way (Without manually
> > > touching the table)?
> > > 
> > > Instead, in the next patch (patch 06/15) batman-adv manually increase
> > > the neigh timeouts. Do you think we should avoid doing that as well?
> > > If we are allowed to do that, how can we perform the same operation in
> > > a cleaner way?
> > > 
> > > Last question: why can't other modules use exported functions? Are you
> > > going to change them as well?
> > 
> > I really don't have time to discuss your neigh issues right now as I'm
> > busy speaking at conferences and dealing with the backlog of other
> > patches.
> > 
> > You'll need to find someone else to discuss it with you, sorry.
> 
> I hope now is a good moment to bring the questions back onto the table. We
> still are not sure how to proceed because we have no clear picture of what
> is going to come and how the exported functions are supposed to be used.
> 
> David, if you don't have the time to discuss the ARP handling with us could
> you name someone who knows your plans and the code equally well ? So far,
> nobody has stepped up.

let me add another piece of information: The distributed ARP table does not 
really depend on the kernel's ARP table. We can easily write our own backend 
to be totally independent of the kernel's ARP table. Initially, we thought it 
might be considered a smart move if the code made use of existing kernel 
infrastructure instead of writing our own storage / user space API / etc, 
hence duplicating what is already there. But if you feel this is the better 
way forward we certainly will make the necessary changes.

Regards,
Marek
