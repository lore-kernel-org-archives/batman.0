Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Wed, 26 Aug 2009 11:19:21 +0200
References: <20090826064151.GE21827@ma.tech.ascom.ch>
	<200908261001.31814.sven.eckelmann@gmx.de>
In-Reply-To: <200908261001.31814.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908261119.22173.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] List policy for none subscribers
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

> > As a side issue, i'm not sure batman-adv is the right name for
> > mainline. In the context of the batman project, it makes sense, but
> > from the perspective of mainline, this is the first version of batman,
> > and maybe we cannot justify the advanced.

One problem of the B.A.T.M.A.N. project is the confusion we created by having 
too many versions. Renaming batman-advanced to batman would be the worst we 
could probably do with this regard.

> To the wiki stuff. The policy was long time correct if I remember it
> correct (send my first stuff without being subscribed). Maybe it was
> accidentally changed when the administrator upgraded the mailing list/mail
> stuff.

In principle a open-posting list would be nice, but I don't see this 
implemented anywhere with reason. My guess would be that no one is willing to 
go through literally thousands of SPAM mails every day to find the one 
legitimate e-mail coming in once a week that is waiting for approval by the 
list admins. Whenever I tried posting as a non-subscriber to a mailing list 
my email never went through.

> What make me a little curious is what that change would mean for the
> development model. Ok, they would have to work with a git clone and have to
> send merge requests/patches to upstream - but what about internal packet
> versions. The current version is 7 and have it to support older version in
> the (very probably) situation that the packet format is changed again?

This is a good and important question. Even more so because Marek and I were 
having a initial discussion via VOIP about ideas and changes to the algorithm 
for the next generation mark 5 of the protocol algorithm. Our aim is (again) 
reduced computational and data overhead, faster convergence speed, a 
simplification of the protocol  and added support for IPv6. This step will 
again call for a higher packet version number, naturally. I guess the kernel 
developers won't be amused  to include something in the main line which is 
still under heavy development? 

We should discuss the changes to mark 5 with all the people which are deeper 
involved. It would be awesome to meet you all physically somewhere for 
a "B.A.T.M.A.N. developer meeting/conference" to set the agenda and gather 
ideas...  I could organize a venue if you want to come to Berlin...

> And as my position as random guy I want to thank you for contacting Greg
> G-K

I want to say big THANKS to all people - testers, developers - that are 
contributing to the project. Marek, Andrew, Sven, Axel, Yang, Antoine, 
Simon... - it is a great joy for me to see your contributions! 

Cheers,
Elektra


