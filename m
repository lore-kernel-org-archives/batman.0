Return-Path: <linus.luessing@web.de>
Date: Tue, 22 Oct 2013 23:26:05 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20131022212604.GA6214@Linus-Debian>
References: <20131020082506.GC13550@Linus-Debian> <1989798.ZHJlJXvcrz@diderot>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1989798.ZHJlJXvcrz@diderot>
Subject: Re: [B.A.T.M.A.N.] A few questions on TVLV
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On Sun, Oct 20, 2013 at 06:26:41PM +0800, Marek Lindner wrote:
> On Sunday 20 October 2013 10:25:07 Linus Lüssing wrote:
> > I think I had posted some thoughts on the TVLV feature on the IRC
> > channel before with some suggestions for changes (e.g. moving the
> > TVLV feature from the individual packet types down to the common
> > batman header). And had tried to come up with examples for
> > features where TVLVs for batman broadcast packets could be useful
> > - which might have been potential, but not the most convincing,
> > not the most awesome features.
> > 
> > So now I have a feature which I would like to have / would like to
> > work on in the future [0], and I would like to know:
> 
> Before we discuss how we get TVLVs 'down to the common batman header' we 
> should talk about why that would be useful. What are the advantages and 
> disadvantages ? Adding tvlvs everywhere for the mere sake of having them 
> around isn't good enough as they increase code complexity, network traffic 
> overhead and encapsulation speed penalties.
> 
> Cheers,
> Marek

Agreed, bloated, never used code is never a good thing. And yes,
before we do get into discussing the specific proposal, we should
discuss the current limitations, (perceived) issues.

To be honest, I'm not 100% sure about the advantages and
disadvantages, that's why I had decided to ask questions,
initially :).


This is my current (probably wrong) understanding about the
disadvantages of the current implementation:

With the current TVLV approach it is still going to be difficult
to introduce new features / changes to batman-adv broadcast /
coded / fragment / ... packets as the current approach only
provides TVLVs for OGMs and unicast packets.

How difficult, I'm not quite sure. Initially I thought compat
bumps would be needed for new broadcast features for instance,
but now I realized, that this is not the case, because bcast features
could be signalized via OGM TVLVs and like with the mcast patches,
could be enabled only if all nodes have that bcast-feature OGM
TVLV.

So I guess the only disadvantage is, that you would either only be
able to use a new bcast feature, if all nodes had it (which might
be painful in a heterogeneous mesh network). Or if it is an
optimization which can be applied "locally", then the according
nodes would need to convert the broadcast packets back and forth.


So vice versa, the advantage of having TVLVs for broadcast packets
would be to have ignorable features, no need for conversions
because the TVLV could be skipped, no compat bumps, not always a
need to wait for all nodes to be upgraded to make the feature effective
- just like for the current OGM and unicast TVLVs. We'd have the
same flexibility provided by a uniform framework for all packet
types from an "infrastructure point of view".

--

For the disadvantages of moving 'TVLVs down to the common header',
I'm actually having trouble getting them. Maybe others could list
them again and I try to explain which of these I'm having trouble
understanding and why?

Cheers, Linus
