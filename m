Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 27 Sep 2016 01:07:41 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160926230741.GC6995@otheros>
References: <dbe677b5597c50f4f97171b59752af6b@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbe677b5597c50f4f97171b59752af6b@riseup.net>
Subject: Re: [B.A.T.M.A.N.] Interested in contributing
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Mon, Sep 26, 2016 at 10:17:48PM +0530, leftbydefault@riseup.net wrote:
> Hello folks,
> 
> I came across the list of improvements and ideas to work on B.A.T.M.A.N-Adv
> from Gsoc2013 Ideas here https://wiki.freifunk.net/Ideas_GSoC_2013
> I am interested to work on implementing a proposed solution to any of the
> mentioned problem. The wiki has a list of problems but, there is no
> description about the current status of each problem listed (whether they
> have been already implemented or still looking for contributions?).
> 
> If there are any other problems apart from the above list, I would also like
> to know those to see if I can contribute.


Hi!

We had been discussing priorities at the last Wireless Battlemesh
and the top ones are currently:

1) Implementing aggregation for BATMAN V
   (or better, implement some routing algorithm independent
   aggregation)
2) Then the "Dead node fast path switching/invalidating" point
   (current codename: "RIP") to increase scalibility/responsiveness
   through such a reactive addition to the protocol


Regarding larger community mesh networks, it also seems that we
need some deeper evaluation and maybe improvements for DAT. At
least some statistics indicate that larger, open mesh networks
still have a non-negligable amount of broadcast traffic caused by
ARP.

Then there were also some discussions about some "Privacy
Extension" for clients, but there is no easy or even satisfying
concept yet.

I personally would love to improve the current multicast
optimizations to allow real multicast streaming, but we came to
the conclusion at WBM, that this is a "nice-to-have" for now until
1)+2) are done.


Of course, priorities depend on real use-cases, so other people
can probably throw in other ideas or preferences. Or, asking
you, what are the scenarios and use-cases you would like to
improve and feel motivated to work on :-)?

Regards, Linus

PS: Also something, if you might already have some experience with
kernel code, would be to simply help in reviewing pending patches.
Maybe not as exciting as contributing something new and fancy. But
it doesn't help to send patchsets for new features if too many, prior
patches are still pending. So reviewing actually helps a lot and
might contribute even more than submitting something new and fancy.

PPS: Great that you want to contribute! :-)
