Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201204161237.37008.lindner_marek@yahoo.de>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<20120413055947.GH7664@lunn.ch>
	<CAKLmikPJBmk=Xoom0a1D2OFfx6o8OtSk7D4PdT3TDXDx9iyO1A@mail.gmail.com>
	<201204161237.37008.lindner_marek@yahoo.de>
Date: Mon, 16 Apr 2012 12:46:35 +0200
Message-ID: <CAKLmikMRRkrvB3Kgga51hJ=GygEto_KqLCp9TwTPseyK4gJsOw@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi!

On Mon, Apr 16, 2012 at 12:37 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> Note: Whoever is going to implement that should think about the implications
> of mesh clouds periodically connecting and disconnecting. A lot of events
> could be fired over and over again.

We made such extension to olsrd (which runs given bash script) and I
think it is the consumer who needs to take care to aggregate/average
those events and so on. Batman logic could be very simple.

> You don't need to run another routing protocol "on top" of batman-adv. You only
> run it to announce "stuff". You can simply run your routing protocol of choice
> to announce the routes.

Announcing and checking for node reachability, no? And the second part
still require some additional bandwidth, no?


Mitar
