Return-Path: <Yang.Su@ascom.CH>
In-Reply-To: <200908072358.08849.lindner_marek@yahoo.de>
References: <20090722105639.GH32143@ma.tech.ascom.ch>	<200908062215.42266.lindner_marek@yahoo.de>
	<OF7EA947EA.4A9F255F-ONC125760B.00526255-C125760B.0053A890@CHASCOM.INT>
	<200908072358.08849.lindner_marek@yahoo.de>
Message-ID: <OF6771C76D.6C69E95B-ONC125760E.002641B8-C125760E.0028535B@CHASCOM.INT>
From: Yang Su <Yang.Su@ascom.CH>
Date: Mon, 10 Aug 2009 09:20:28 +0200
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

For the echo cancellation example: the problem happens with the interaction
between A and B. Because of the asym link, A chooses B as its next neighbor
towards F. Because the asym path is short, B always receives F's OGM from A
first  (before B receives the OGM with the same seqno from C). As a result,
from A's point of view, F's OGMs rebroadcasted by B are always echoes and A
will never update the TQ information towards F via B.

When the quality of any links on the path B to F drops down, B might choose
A as its next neighbor towards F and a loop forms between A and B.

Regards,
Yang





On Friday 07 August 2009 23:13:46 Yang Su wrote:
> - Some updates: I did more thorough testing. It turns out that this patch
> does really solve the problem.  This method seems not able to completely
> eliminate all possible forms of looping which happen in the test cases.
> This result in an special pattern: the rerouting is fast (~15 seconds),
> then (after 3~ 5 seconds) the network enters the looping state and it
> normally takes long time to recover.  Last time when I did tests, I stop
> the tests right after I observed the successful rerouting. I didn't look
> into the cause of this problem yet. Any inputs are welcome.

Can you provide logs from the nodes involved ? You also can send them
off-list
to avoid sending too big attachments.


> - In the following example (also appended in the attachment :) ), if I
> understand the current echo cancellation implementation correctly, batman
> will enter permanent looping between A and B. In this example, A send to
F,
> all the links are perfect and have the same delay. Only exception is link
> A-E. It is an asymmetric link.

Why do you think it would loop permanently and why do you think it is the
fault of the echo cancellation ?
Actually, this example should[tm] be pretty easy. Every time the OGM from E
or
F arrive at A via the asymetric link A will apply a severe asymetric link
penalty. All nodes will route via the longer path. Did you try to run this
scenario in your testbed ?

Regards,
Marek

_______________________________________________
B.A.T.M.A.N mailing list
B.A.T.M.A.N@lists.open-mesh.net
https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n



