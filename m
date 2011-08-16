Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Aug 2011 14:12:23 +0200
References: <2744235.RrtTiUgUxn@sven-laptop.home.narfation.org>
	<201108161315.27242.onelektra@gmx.net>
	<201108161320.39443.lindner_marek@yahoo.de>
In-Reply-To: <201108161320.39443.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201108161412.23801.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman(d|-vis) deprecated by upstream
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

On Tuesday, August 16, 2011 13:20:33 Marek Lindner wrote:
> > > The decision was
> > >
> > > 
> > >  made to really say "batmand is deprecated" [3,4] instead of waiting
> > >for some fairies to take over the project. I've already closed the
> > >upstream bugtracker and moved the git repositories [5] in our
> > >"obsolete" folder.
> >
> > 
> >
> > the decision was made by whom without informing me beforehand?
> 
> By me.

A short amendment to avoid potential misunderstandings:

These "changes" aim to make the current state more visible. For at least 2 
years the batman daemon has not been worked on, package development & 
documentation updates have stalled. Being unaware of the situation the casual 
visitor tries to use batmand, only to run into build and support issues nobody 
wants to deal with. This does not make the project look good - clearly not in 
our interest.

We still host the batmand source code and the available documentation, so that 
people can use it if they want. At the same time we make it obvious that it is 
not recommended by removing the obsolete packages from the distributions and 
by adding big warnings signs on the website.

Of course, as soon as the batmand code / documentation / package(s) is 
actively worked on we can easily switch back. Until then I prefer to openly 
communicate the current state to avoid unpleasant surprises. 

Regards,
Marek
