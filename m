Return-Path: <ordex@ritirata.org>
Date: Thu, 2 Dec 2010 13:02:10 +0100
From: Antonio Quartulli <ordex@ritirata.org>
Message-ID: <20101202120210.GB13912@ritirata.org>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTinFgQ+Z4OsvyHTMNhy11=SrEz0Xu+YU2iZcdcwZ@mail.gmail.com>
	<AANLkTimYtBa3fD_YNmFV2x0GUoyNiDzT47wy9Kuok0k9@mail.gmail.com>
	<201012011330.19145.lindner_marek@yahoo.de>
	<20101202102752.GA11558@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20101202102752.GA11558@Sellars>
Subject: Re: [B.A.T.M.A.N.] BATMAN routing
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

Hi all*,

On gio, dic 02, 2010 at 11:27:52 +0100, Linus Lüssing wrote:
> Hi everyone,
> 
> thanks for having joined the IRC channel, Hlabishi and Chris, that's
> really speeding the discussions up a lot, I guess :). Just wanted
> to throw in another idea open for discussions which is refering to
> Hlabisihi's packet count weighting.
> 
> What do you guys think about pushing this concept even one step
> further and removing the local packet count window? And instead
> using a "smoother" exponential weighted average which got very
> popular in TCP for it's RTT estimations:
> 
> RQ_new = f(newseqno, lastseqno, RQ_old, α)
>        = (1-α) * RQ_old + α * 1 / Δ(newseqno, lastseqno)
> 
> As in TCP, α is then the parameter for tweaking on how much
> more priority a newer packet shall have and is chosen between 0
> (conservative) and 1 (opportunistic).
> 
> What do you think?
> 

IMHO this is not the best solution. Probably it could better than the
actual strategy, but, as TCP demonstrates, this is not a really nice way
of evaluating the RQ. 

Imho, since we have more and more information than
TCP for evaluating the new RQ, we could try to make a better choice
considering "more values": instead of using only the deltaSEQ and the
oldRQ, we could try to apply a function that can weight also the previous
history of the link (of course with a limit).
Something like

newRQ = f(window[0], ...., window[N-1]) in which, each OGM (received or
not) can be weighted in a different way depending on its position.

I hope I've been clear. 

furland is probably working on this aspect.

Bye!

> 
> Cheers, Linus
> 
> On Wed, Dec 01, 2010 at 01:30:18PM +0100, Marek Lindner wrote:
> > On Wednesday 01 December 2010 10:46:10 hlabishi kobo wrote:
> > > Thank you for considering this concept, i am working on the
> > > implementation now. I would love to attend your IRC channel
> > > discussions, just tell date and time.
> > 
> > The IRC meetings are less formal. Just join us when you have the time. People 
> > hang out there all the time.
> > 
> > Cheers,
> > Marek
> > 

-- 
Antonio Quartulli

Ognuno di noi, da solo, non vale nulla
Ernesto "Che" Guevara
