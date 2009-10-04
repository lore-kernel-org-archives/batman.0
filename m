Return-Path: <andrew@lunn.ch>
Date: Sun, 4 Oct 2009 19:41:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091004174127.GB3685@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] VGER mailing list request
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
To: postmaster@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.net

> I'm sure your project is very interesting, but it falls short of the
> scope for having the list crated on vger.
> 
> Generally, we host lists for kernel projects and their tools for which
> they are already upstream or for which their upstream acceptance is
> imminent.
> 
> I've never seen the BATMAN kernel bits even submitted for review on
> netdev@vger.kernel.org and getting your code upstream via submission
> there would be a prerequesite before we could be discussing a mailing
> list on vger.
> 
> I'm not even sure the getting your kernel bits upstream is even
> something you want, or whether the networking maintainer (that's
> me :-) would consider your code and approach acceptable.

Hi David

Let me fill in some of the background.

We have been talking to GregKH about submitting the code to staging.
Greg has said he is happy to accept the patches for staging, since the
code is totally self contained, mostly passed checkpatch apart from
some long lines, sparse clean etc. And we have a TODO list of things
we think need fixing before it can leave staging.

However, at the moment we are using a closed list. Your reply to this
email is going to bounce from the list server. Before we submit to
staging and hopefully start getting feedback from kernel experts, we
would like to move to an open list. The current list server does not
have good enough Spam filtering for an open list. So we are looking
for a list server provider who we could use. vger seemed like an
obvious choice.

Is likely acceptance in staging sufficient for "...for which their
upstream acceptance is imminent."?

   Thanks
          Andrew
