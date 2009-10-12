Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Mon, 12 Oct 2009 23:36:12 +0200
References: <20091012081122.GB12833@lunn.ch>
	<200910130048.49571.lindner_marek@yahoo.de>
In-Reply-To: <200910130048.49571.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200910122336.12511.onelektra@gmx.net>
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

Hi!

> It seems we have to decide where we want to go with batctl. Until now
> batctl was not mandatory to operate the batman-adv kernel module. batctl
> extended the modules functionality and made things easier to configure but
> remained optional.
>
> Personally, I like it a lot that way because it does not create unnecessary
> dependencies.

Ack.

> It can become an uphill battle if you want to keep your
> kernel and its configuration tools in sync. Everyone that tried to use
> oprofile knows what I'm talking about (or the wireless tools to name
> another example).
>
> So, the question is whether we want to make batctl the almighty tool that
> we always depend on or are we trying to find alternative solutions to avoid
> that dependency ?

I'd opt for the latter.

>
> One option for the case at hand might be debugfs
> (http://lwn.net/Articles/115282/). It is another filesystem which needs to
> be mounted seperately - there we can output whatever we want (unlike
> /proc). It would be possible to create virtual files for the dot draw /
> json / raw output (raw means the neutral format suggested by Andrew).
>
> Soon we also will have to decide what to do with routing log as we can't
> "spam" the system log with our data. Again, debugfs seems like a good
> solution. That does not need to be decided now but could be a consistent
> path towards mainline integration.

Seems like the way to go.

Cheers,
Elektra

