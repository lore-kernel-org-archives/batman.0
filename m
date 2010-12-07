Return-Path: <linus.luessing@ascom.ch>
Date: Tue, 7 Dec 2010 11:09:26 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@ascom.ch>
Message-ID: <20101207100926.GA18505@Sellars>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTinFgQ+Z4OsvyHTMNhy11=SrEz0Xu+YU2iZcdcwZ@mail.gmail.com>
	<AANLkTimYtBa3fD_YNmFV2x0GUoyNiDzT47wy9Kuok0k9@mail.gmail.com>
	<201012011330.19145.lindner_marek@yahoo.de>
	<20101202102752.GA11558@Sellars>
	<20101202120210.GB13912@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20101202120210.GB13912@ritirata.org>
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

Hi Antonio,

thanks for the feedback on the exponential weighted average.

> IMHO this is not the best solution. Probably it could better than the
> actual strategy, but, as TCP demonstrates, this is not a really nice way
> of evaluating the RQ.
Well, I guess TCP could have used a weighted window for doing its RTT
estimations, too, couldn't it? Do you know if there has been a
particular design decision to using an exponential weighted
average instead of a weighted window here?

> 
> Imho, since we have more and more information than
> TCP for evaluating the new RQ, we could try to make a better choice
> considering "more values": instead of using only the deltaSEQ and the
> oldRQ, we could try to apply a function that can weight also the previous
> history of the link (of course with a limit).
> Something like
Hmm, I think with an exponential weighted average we are weighting
the previous history as well, aren't we? And due to the
exponential behaviour, history further in the past will be
considered less - which sounds similar to the scheme proposed by
Hlabishi with a wighted window, doesn't it? And by the way,
an exponential weighted average should consid "more value" compared
to the weighted window, shouldn't it? The window is limited in size
and packets get kicked out again, while in an exponential weighted average,
even a veeeery old packet still has an influence (though a veeeery
little one then, too ;) ).

One thing that might be something not easily doable with an exponential
weighted average is changing the weight of a single, previously
received packet on demand (we cannot suddenly say that we now want to make the
packet we received 3 seconds ago now 5 times more important). But
I guess that's not needed with the current ideas so far, is it?

For changing the weight of a just received packet, doing special
weighting could even be easier, as a different α could be applied
for this single packet. For instance there were some discussions
if we should send larger packets for packet loss probing from time
to time and giving these a higher priority.
> 
> newRQ = f(window[0], ...., window[N-1]) in which, each OGM (received or
> not) can be weighted in a different way depending on its position.
Yes, I think that's what Hlabishi had in mind, too.

I actually started doing some googling and there seem there seem to
be even more ways of how to weight a set of samples. Anyone with
some more knowledge in the field of signal processing? Or
economics / stock markets :D?


Hlabishi, I'd be curious if there was a certain design decision
for using a weighted window in favour for other weigthing
techniques and if you considered using other
techniques, too. Or was the idea of using a weighted window due to
the fact, that we are already having a window and that you did not
want to temper too much with that?


Cheers, Linus
