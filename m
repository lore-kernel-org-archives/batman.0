Return-Path: <linus.luessing@web.de>
Date: Tue, 12 Jul 2011 02:00:20 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110712000020.GA31975@netfeed>
References: <CAOaDhSS0-EP6bPM+2kho3h9u8aGJXsP0QmaqFMAhHa_4Y=MA4Q@mail.gmail.com>
	<CAKeC-QH0D5R2dvXJ-KEoBPCc=rmYadCzmMW1kAeBxuur+okzrw@mail.gmail.com>
	<CAOaDhSTMPWNi+Cbv8jqumA3S1Bkpetcqqmh-SMUROOe+LUFEbg@mail.gmail.com>
	<1640517.S3sb13Hzrx@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1640517.S3sb13Hzrx@sven-desktop.home.narfation.org>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] batctl vd dot buggy
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
To: Sven Eckelmann <sven@narfation.org>, Gioacchino Mazzurco <gmazzurco89@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Jul 06, 2011 at 12:27:28AM +0200, Sven Eckelmann wrote:
> On Tuesday 05 July 2011 23:29:07 Gioacchino Mazzurco wrote:
> > Good job, but what we are trying to fix is the topology visualization
> > we need that at moment
> 
> Just looked with one eye at the stuff and it seems that the data which comes 
> from the kernel module is not what you expect. For example 00:15:6d:fc:72:0b 
> isn't marked as primary or secondary.

We don't mark secondary interfaces explicitly in the raw output, a
raw row output of a primary interface contains all the
information, both that it is a primary interface and also
optionally which other secondary interfaces belong to it.

Gioacchino:
Are the interfaces 00:15:6d:fc:72:0b, 06:15:6d:7c:09:d8 and
06:15:6d:fc:71:ce primary or secondary ones?
(a primary one is the one listed in the first line of 'batctl o',
the MainIf)

And those are actually the specific ones where no
subgraph-dot-thingy has been added and no box was drawn and where
the error lies, right? Or are there more issues we missed so far
(like links, HNA entries or interfaces missing completely in the list and/or
graph for instance)?

> 
> It looks like one vis_if_list
> 
> So you can't use the module from 2.6.38 and expect that we fix it with batctl. 
> And the correct people to ask here are:
>  * Simon Wunderlich (author of the vis stuff)
>  * Linus Luessing (the person which added the subgraph stuff)
>  * Andrew Lunn (he introduced the format "vis raw" which is used in vis_data)
> 
> I don't want to touch it because it may explode in my hand. But you can also 
> try whether you are lucky and check vis_seq_print_text. It is currently overly 
> complex without any reason. It could easily use seq_file and don't do the 
> precalculation (which was necessary in /sys).... I forgot the topic.
> 
> Kind regards,
> 	Sven
