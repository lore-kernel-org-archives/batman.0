Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120406091320.GB10020@lunn.ch>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<20120323063206.GA5662@lunn.ch>
	<201204052330.06655.lindner_marek@yahoo.de>
	<20120406091320.GB10020@lunn.ch>
Date: Fri, 6 Apr 2012 10:57:52 -0600
Message-ID: <CAA_JP8VofnfLX7C7Bkfpbe1N6vqBiD3LV8N4U3seEw=NT9WnyQ@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [RFC] ELP
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

>
> but this is a big change. We have lost TQ, but gained unicast to the
> specific originator we want the metric for. We no longer need to send
> probe packets, so have less overhead, but depend on there being some
> traffic in order that minstral can do its thing.
>
> If we send unicast probe packets, and combine it with minstral:
>
> The quality of packets send using unicast at X Mbps.
>
> We have no choice on X, Minstral decides it. This is in fact good,
> since the real data also get X. We have a metric based on (TQ, X). How
> we actually determine X is interesting. TQ is a moving window
> average. Can we do the same for X? Minstral will already be doing some
> averaging, so maybe just use the latest value?
>
> So far, we have no idea about available capacity of the link:
>
> Determine X from Minstral. Send a burst of packets forcing them to be
> sent at rate X and without retries. Time how long it takes to send the
> packets. Compare this with the theoretical time needed, assuming no
> congestion, to calculate a congestion factor C.
>
> You now can build a metric based on (TQ, X, C). But you have more
> overhead, because you need a burst of unicast packets, and a lot more
> complexity, but you have an idea of the free capacity of the link.
>
> =A0 =A0 =A0 =A0 =A0 =A0Andrew

disclaimer: I am an end user, not a dev.  I run a wISP (no mesh right
now, ringed).  Also, this is an evolved version of other ideas I
posted here.

So here is my thought.  How can you possibly test a wireless link for
quality and capacity without sending enough data to stress the link?
I do a lot of statistical work on historical product movement and
sales, so I am trying to apply some lessons learned there to this
problem.  The only way to know capacity is to measure it.  You cannot
measure nothing, that is 'null', and generating traffic to measure
decreases capacity/increases overhead.

My train of thought here says that you must use historical data and
statistics.  For this period of time x (5 seconds?), interface y
transfered the aggregate amount of data z and latency to the next node
in the path was L.  later, x and y are unchanged but z is higher and L
spikes. later x and y are unchanged but z in low and L is similar to
the first entry.  Keep these high water marks around and lower them
when the history shows them to be invalid.

From this we can statistically say that interface y is able to
transfer z before L spikes.  This is theoretical capacity of the
connection.  obviously, this is over wireless links so these are
dynamic numbers that must be adjusted within some timeframe to
changing conditions.

I find that most wireless links maintain good latency until they reach
a breaking point and then the latency collapses.  it hits a wall.

In the wISP world, I pre-test links and configure the radios
modulation to the highest stable value.  The link might negotiate at
MCS15 but collapses at anything over MCS13.  I do not rely on
auto-adjustments here.  The phenomenon of fresnel zone echo can make a
link look great until data is transfered, then the echos from fresnel
zone infractions destroys the link.  The only way to know what is on
the link is to push data across it.  When I do this test, I can
negatively effect other clients on the radio.  This is a necessary
evil for me and my tests are brief and infrequent.

If batman-adv is able to take these sort of measurements, or is able
to read the results of a helper application that does the math, then
it stands to reason that these numbers could be read by a helper
application and the maximum modulation of a radio could be set with
userspace utils (like iw) to fit the calculation to further stabilize
the link.  You can nudge the values up periodically to test with.  If
a link is MCS2 per the calculations, nudge it up to MCS3 and let the
algorythm do its magic.  If it still thinks that 19.5Mb is optimal we
can bring the mod back down to MCS2 (via helper app), if it shows as
good we will leave it at MCS3 for a while then nudge it up to MCS4.
Never jump up from MCS2 to 4 because the link might completely
collapse. rinse, repeat.
