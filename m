Return-Path: <Yang.Su@ascom.CH>
In-Reply-To: <200908120042.21853.lindner_marek@yahoo.de>
References: <20090722105639.GH32143@ma.tech.ascom.ch>	<OF15A3814D.94B5B275-ONC125760E.002B50BE-C125760E.002BB709@CHASCOM.INT>
	<200908101616.50082.lindner_marek@yahoo.de>
	<200908120042.21853.lindner_marek@yahoo.de>
Message-ID: <OF516B4B6E.095CCBDE-ONC1257610.004CDE20-C1257610.00500B80@CHASCOM.INT>
From: Yang Su <Yang.Su@ascom.CH>
Date: Wed, 12 Aug 2009 16:34:17 +0200
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

Given the DV nature of Batman, current strict dropping policy seems to make
sense, because sending known OGMs (as suggested) does introduce significant
overhead but does not propagate so much new information.

In addition, loosing the dropping policy may introduce new problems which
might not be easily predictable at this moment, e.g., stability, looping
(propagating stale information within the network might cause even more
nasty looping problems).

Another way (and maybe simpler ) to fix the problem: instead of loosing the
OGM dropping policy,  loosing the echo cancellation policy.

It is a very simple fix: in addition to the usual echo cancellation
process, I also check  the TQ value contained in the echoed OGM.  This TQ
is announced by the neighbor that broadcasts this echo. If this TQ is worse
than my current TQ estimation towards that neighbor, I update the
estimation with this TQ.

Does that make sense?

Regards,
Yang



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
  |11.08.2009 18:44                                                                                                                                  |
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





On Monday 10 August 2009 16:16:49 Marek Lindner wrote:
> Excellent question - it should. I will check the code later to verify
that
> this is the case.
> However, this is not related to the echo cancellation anymore.

I inspected the code for behaviour in the case you outlined. I think our
dropping policy might be a bit too strict. I suggest the following
behaviour:

* New OGMs are processed and rebroadcasted as usual.
* Known OGMs (the sequence number is not new but we did not hear this
sequence
number via that neighbor) are processed and rebroadcasted as well.
* Duplicates (known sequence number via a neighbor that sent us this
sequence
number before are dropped.

Objections / ideas ?

Regards,
Marek

_______________________________________________
B.A.T.M.A.N mailing list
B.A.T.M.A.N@lists.open-mesh.net
https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n



