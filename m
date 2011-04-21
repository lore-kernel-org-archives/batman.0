Return-Path: <linus.luessing@web.de>
Date: Thu, 21 Apr 2011 19:54:10 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110421175410.GB23449@Sellars>
References: <BANLkTinQ6xjJQTK_zZJYKn4q4bT4Oi6NWQ@mail.gmail.com>
	<201104202305.40456.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201104202305.40456.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] batman doesn't see neigh on wired lan
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

On Wed, Apr 20, 2011 at 11:05:40PM +0200, Marek Lindner wrote:
> On Wednesday 20 April 2011 22:39:30 Gioacchino Mazzurco wrote:
> > Here in Pisa we are experiencing a big problem!
> > 
> > Nodes doesn't see each other on cable!
> > 
> > below is some data from the 2 nodes
> > 
> > As you can see nodes receives each other BAT packets but don't see
> > each other as neighbor...
> > 
> > also batctl tr can confirm it...
> > 
> > what is happening?
> 
> That can't work - eth0 is part of a bridge. You can either use eth0 with 
> batman or in a bridge, not both. However, you can configure batman to use the 
> bridge interface which the eth0 interface is part of.
> 
> Cheers,
> Marek
> 

Ah, ups, so that post too late :).
