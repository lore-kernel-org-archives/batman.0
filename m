Return-Path: <Yang.Su@ascom.CH>
In-Reply-To: <200908031821.22497.lindner_marek@yahoo.de>
References: <20090722105639.GH32143@ma.tech.ascom.ch>	<200907280020.06026.lindner_marek@yahoo.de>
	<OF82FBEF87.4CF60579-ONC1257603.002FC1DB-C1257603.004FD789@CHASCOM.INT>
	<200908031821.22497.lindner_marek@yahoo.de>
Message-ID: <OFC1B28E77.E7123900-ONC125760A.0028654D-C125760A.00300451@CHASCOM.INT>
From: Yang Su <Yang.Su@ascom.CH>
Date: Thu, 6 Aug 2009 10:44:28 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [B.A.T.M.A.N.] batman goes looping...
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

|------------>
| From:      |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |Marek Lindner <lindner_marek@yahoo.de>                                                                                                            |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| To:        |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |"The list for a Better Approach To Mobile Ad-hoc Networking" <b.a.t.m.a.n@lists.open-mesh.net>                                                    |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| Date:      |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |03.08.2009 12:23                                                                                                                                  |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| Subject:   |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |Re: [B.A.T.M.A.N.] batman goes looping...                                                                                                         |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| Sent by:   |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |b.a.t.m.a.n-bounces@lists.open-mesh.net                                                                                                           |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|








On Thursday 30 July 2009 22:32:04 Yang Su wrote:
> 1.  Similar to what Marek proposed. But push it to the extreme: switch to
a
> neighbor only when it has the best tq AND it has the newest seqno.  This
> fix along seems to already solve the looping problem in the test cases.
It
> reduces the rerouting time from more than 1 minutes to less than 15
> seconds.  Marek: I also tried the patch you sent. It didn't help in this
> setup.

Changing the route based on the (fastest) sequence number has some
drawbacks
which we experienced before (BATMAN III). It tends to discriminate longer
but
better routes and favors short paths. In some asymetric link (worst case)
scenarios it would route against all odds, simply because receiving a fast
packet (newest seqno) does not mean we can send the same way back. If
possible
I'd like to avoid this strict seqno check.

- You are right. Under certain circumstance, this approach may lead to less
optimal route selection. Just to understand batman algorithm better, I try
to make an example (please correct me if something's wrong here): There are
two direct neighbors via which a sender communicates with a receiver. Via
the good neighbor, their is a single good route with long delay. Between
the bad neighbor and the receiver there are many parallel bad routes. Each
bad route has high packet loss rate but very short delay. The receiver's
OGMs arrive at the sender first via the bad neighbor. Although there is
substantial OGM loss on each individual bad routes, by aggregation over
those parallel bad routes, the bad neighbor is still able to relay most of
sender's OGM to the receiver. As a result, if the sender already chooses
the bad neighbor as the next hop, it will stick to it for quite long time
and does not switch to the good neighbor.

I attached another patch which will conduct a route switch only if the TQ
of the sending neighbor is better than our current best route (no negative
switching anymore). I tested the patch here and it works so far but my
environment is less controlled than yours. Could you perform the same test
on your setup ?

- This approach achieves the similar goal as the seqno-based one: switch to
a neighbor only when this neighbor is better and has more up-to-date
information than the current best route. But this approach is less
constrained and seems not to suffer from the above problem for the
seqno-based approach. I have tested the patch on our test environment. It
works pretty well on the test cases.

> 2. Relaxed echo cancellation. This is based on  the following
observation:
> the TQ value that a node puts into OGM is completely decoupled with "from
> which neighbor this OGM is received".   As a result, the TQ value
contained
> in the echoed OGM represent the real TQ value at the neighbor which
echoed
> this OGM. The current echo cancellation implementation just drops all the
> echoed OGM. This may prevent the node from updating the information
towards
> the neighbor that echos the OGM. In the extreme case, the information
> towards that neighbor may becomes completely stale (similar to what
happens
> in case 2).  The change I  made:  Always check the TQ contained in the
> echoed OGMs. When it is worse than the avg TQ towards that neighbor, we
use
> this TQ reading to update the avg TQ towards that neighbor. This change
> didn't show any effect during the chain tests. However, I still include
> this change in the patch to bring up the discussion.

Right, every node will emit his currently best TQ value but I did not
understand how we can use that. If we send him a better TQ he will send
back
that number. If we send a bad TQ he will send his good number. Furthermore,

each hop will apply some asymetric / hop / wifi penalty that we pull into
our
routing database ?

- The problem might happen when the neighbor thinks that I am his best
neighbor (his good number is actually from me). In this case, my estimation
of that neighbor's TQ is actually decided by my own TQ (my TQ minus one hop
penalty). When my TQ drops down, the correct behavior should be that my
estimation of that neighbor's TQ also drops down accordingly. However, when
echo cancellation steps in, my estimation of that neighbor's TQ will not be
updated and remains to be the stale value. This might cause problems (e.g.
looping) in corner cases even with the new patch.  Does this analysis make
sense or I miss some details of the echo cancellation?

Regards,
Marek

[attachment "switch-route-with-better-tq.patch" deleted by Yang
Su/NSUYAN/CH/Ascom] _______________________________________________
B.A.T.M.A.N mailing list
B.A.T.M.A.N@lists.open-mesh.net
https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n


