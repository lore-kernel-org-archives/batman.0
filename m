Return-Path: <andrew@lunn.ch>
Date: Sun, 1 May 2011 15:10:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110501131033.GD6538@lunn.ch>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1303940106-1457-3-git-send-email-ordex@autistici.org>
	<20110430084226.GM21883@lunn.ch>
	<20110430160027.GC3851@ritirata.org>
	<20110430174839.GC6538@lunn.ch>
	<20110501113536.GA8915@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110501113536.GA8915@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: improved client
 announcement mechanism
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

> > O.K. so there is a good reason. So maybe hint about these reasons in
> > the comment? Help the reader understand why it might happen.
> 
> Ok I can add some comments more. But, should I reason as we do not have
> documentation at all? I mean, while deciding to put a comment or not..

If you want to reference to documentation, i think it should be in
kernel documentation. So i would make the documentation part of this
patch set. I.e. include a file Documentation/networking/batman-adv-tt.txt,
and reference it.
 
> > > Yes, memory problem. Actually it is not possible to make two passes:
> > > e.g. imagine that the set of changes is the following:
> > > - DEL A
> > > - ADD A
> > > - DEL A
> > > (ok it is probably not really common, but still possible)
> > 
> > And since it will not happen to often, it is not worth the code so
> > find such situations and simply the transactions.
> > 
> 
> What do you exactly mean? Sorry but I didn't fully understand your
> sentence :(

You could parse the changes, DEL A, ADD A, DEL A, and optimize it down
to just DEL A. But i guess it is not worth the effort.
 
> I understood that I have to work harder to write comments :D

That is one approach. I often take another. Lots of very small
functions, with names which make it clear what they do. The function
names replace the comments.

This is no right/wrong, just different styles.

     Andrew
