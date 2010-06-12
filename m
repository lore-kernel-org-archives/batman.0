Return-Path: <jch@pps.jussieu.fr>
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
In-Reply-To: <0FE97F6D-EAF6-4E7D-BB15-1917CBB2813E@lo-res.org>
References: <0FE97F6D-EAF6-4E7D-BB15-1917CBB2813E@lo-res.org>
Date: Sat, 12 Jun 2010 14:04:02 +0200
Message-ID: <87ljaka24t.fsf@pirx.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [B.A.T.M.A.N.] [Babel-users]  WBMv3: a Babel perspective
Reply-To: olsr-users@lists.olsr.org, babel-users@lists.alioth.debian.org,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: "L. Aaron Kaplan" <aaron@lo-res.org>
Cc: tmplab@lists.tmplab.org, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, olsr-users@lists.olsr.org, battlemesh@ml.ninux.org, babel-users@lists.alioth.debian.org

[Followups restricted to just olsr-users and babel-users.]

>> (1) when the network is broken, Babel is the first to collapse;
>> (2) Babel behaves well when the network is usable;

> Could you be a bit more specific with "usable"?? What does that mean
> regarding packetloss?

If you look at Elektra's writeup, in the first test none of the
protocols achieved more than 18% success -- and that's *after*
link-layer ARQ.  In the second test the figure was 27%.

In the third test, everyone achieved around 75% (after ARQ), which
I think is still pretty marginal, but starts becoming usable.

Perhaps Henning or Elektra can tell us what was the ETX (or,
equivalently, pre-ARQ packet loss) of the productive links in those
tests.

>> (3) Babel generates too many small packets on broken networks.

> Which creates more collisions in the air I assume ;-)

Well, it's still just 30 packets/s (as measured, all nodes added up),
which is well within what 802.11 is designed to handle.  (See Elektra's
slide number 8.)

> yeah ;-) Wish I had been there..

So do I.

                                        Juliusz
