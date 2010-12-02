Return-Path: <linus.luessing@ascom.ch>
Date: Thu, 2 Dec 2010 11:27:52 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@ascom.ch>
Message-ID: <20101202102752.GA11558@Sellars>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTinFgQ+Z4OsvyHTMNhy11=SrEz0Xu+YU2iZcdcwZ@mail.gmail.com>
	<AANLkTimYtBa3fD_YNmFV2x0GUoyNiDzT47wy9Kuok0k9@mail.gmail.com>
	<201012011330.19145.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201012011330.19145.lindner_marek@yahoo.de>
Sender: linus.luessing@ascom.ch
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

Hi everyone,

thanks for having joined the IRC channel, Hlabishi and Chris, that's
really speeding the discussions up a lot, I guess :). Just wanted
to throw in another idea open for discussions which is refering to
Hlabisihi's packet count weighting.

What do you guys think about pushing this concept even one step
further and removing the local packet count window? And instead
using a "smoother" exponential weighted average which got very
popular in TCP for it's RTT estimations:

RQ_new = f(newseqno, lastseqno, RQ_old, α)
       = (1-α) * RQ_old + α * 1 / Δ(newseqno, lastseqno)

As in TCP, α is then the parameter for tweaking on how much
more priority a newer packet shall have and is chosen between 0
(conservative) and 1 (opportunistic).

What do you think?


Cheers, Linus

On Wed, Dec 01, 2010 at 01:30:18PM +0100, Marek Lindner wrote:
> On Wednesday 01 December 2010 10:46:10 hlabishi kobo wrote:
> > Thank you for considering this concept, i am working on the
> > implementation now. I would love to attend your IRC channel
> > discussions, just tell date and time.
> 
> The IRC meetings are less formal. Just join us when you have the time. People 
> hang out there all the time.
> 
> Cheers,
> Marek
> 
