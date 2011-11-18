Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 18 Nov 2011 23:20:56 +0800
References: <CAG7VhQTrx1nvuH2ZXRbenSuwAqE7RyW=r9WoWrH+ubs6+aP56g@mail.gmail.com>
	<25416217.yBclFAKIz7@sven-laptop.home.narfation.org>
	<CAG7VhQRric4kzJnZFg5bKRKQUYRNPAOLuO4-haaYiwOExz152Q@mail.gmail.com>
In-Reply-To: <CAG7VhQRric4kzJnZFg5bKRKQUYRNPAOLuO4-haaYiwOExz152Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201111182320.56573.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/5] Loop-freness for B.A.T.M.A.N.
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


Hi,

> > Interesting statement but maybe it would also be interesting for others
> > to provide examples and explanations.
> 
> This argument will be a section of my master thesis. As soon as I have
> some more material I will forward it to the community together with the
> script used for testing with qemu.

should we wait with the discussion about your patches until then ? Keep in 
mind that nobody asked you to publish your thesis now or all your scripts. A 
few words explaining what you are trying to solve might be a good starting 
point.


> > are simply wrong. Have you thought about overflow of sequence numbers
> > (hint: seq_before/after)? Ok, forget about the code and look at the
> > rest.
> 
> I perfectly know that the code I provided is a mess.
> But it works and would solve the problems of loops and convergency, and
> this can be verified by anybody before concentrating on coding
> technicality.

No, it might solve something but at the same time introduces severe bugs which 
render the whole routing code useless! The integer overflow bug you are 
introducing in several places of the code breaks the whole algorithm for 
anyone that intends to use batman-adv for longer than a short test.


> > Take for example the stuff prepared by Simon. He gathered information,
> > talked to the people and prepared documentation. I can now use this
> > stuff to discuss with him at a higher level than with the stuff you
> > provided. And his stuff is only a "small" optional feature, but your
> > patches changes things in the path selection and information propagation
> > code.
> 
> My modifications are not as drastic as you are saying. They simply remove
> formally wrong mechanisms such global TQ window and the forwarding of ogm
> not coming from the actual router.

I guess you are underestimating the impact of your own changes. Both of your 
proposed solutions have been discussed on this list before and have been 
rejected because of the side effects.

For instance, only accepting the highest OGM seqno makes the algorithm 
strongly prefer short / low delay routes, no matter the TQ value. Imagine a 
simple 3 node setup: A, B and C. The route from A to C can be a single hop 
route or a 2 hop route via B. The OGMs via B (taking the extra hop) will have 
a higher delay, thus will always be discarded as they arrive "late". Even if 
it is a much better path! Unless I overlooked something you reduced batman to 
simple "hop counting"-like algorithm ..


> As soon as I have some more material I will expose my concept clearly,
> meanwhile if someone want to test my patch is free to do that.

I'd strongly advise against testing the patches! It is obivous that the code 
is broken, no matter what it tries to fix.

Regards,
Marek
