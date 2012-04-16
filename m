Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 16 Apr 2012 12:58:04 +0200
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<201204161237.37008.lindner_marek@yahoo.de>
	<CAKLmikMRRkrvB3Kgga51hJ=GygEto_KqLCp9TwTPseyK4gJsOw@mail.gmail.com>
In-Reply-To: <CAKLmikMRRkrvB3Kgga51hJ=GygEto_KqLCp9TwTPseyK4gJsOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201204161258.04262.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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

On Monday, April 16, 2012 12:46:35 Mitar wrote:
> > Note: Whoever is going to implement that should think about the
> > implications of mesh clouds periodically connecting and disconnecting. A
> > lot of events could be fired over and over again.
> 
> We made such extension to olsrd (which runs given bash script) and I
> think it is the consumer who needs to take care to aggregate/average
> those events and so on. Batman logic could be very simple.

If you already have a shell script uevent definitely is the way to go. It is 
far easier to script than netlink.

How does your logic handle network splits / join ? Do you have the source 
somewhere ?


> > You don't need to run another routing protocol "on top" of batman-adv.
> > You only run it to announce "stuff". You can simply run your routing
> > protocol of choice to announce the routes.
> 
> Announcing and checking for node reachability, no? And the second part
> still require some additional bandwidth, no?

Batman would also need to announce the route. What are we saving?
How reachability is handled / verified depends on the routing daemon you 
choose. You could even connect your routing daemon to the uevents mentioned 
above.

I don't see any benefit of putting this into batman-adv - only a loss of 
flexibility / choice.

Cheers,
Marek
