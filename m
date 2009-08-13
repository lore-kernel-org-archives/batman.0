Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 13 Aug 2009 17:56:57 +0800
References: <20090722105639.GH32143@ma.tech.ascom.ch>
	<200908120042.21853.lindner_marek@yahoo.de>
	<OF516B4B6E.095CCBDE-ONC1257610.004CDE20-C1257610.00500B80@CHASCOM.INT>
In-Reply-To: <OF516B4B6E.095CCBDE-ONC1257610.004CDE20-C1257610.00500B80@CHASCOM.INT>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200908131756.57929.lindner_marek@yahoo.de>
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

On Wednesday 12 August 2009 22:34:17 Yang Su wrote:
> Given the DV nature of Batman, current strict dropping policy seems to make
> sense, because sending known OGMs (as suggested) does introduce significant
> overhead but does not propagate so much new information.
>
> In addition, loosing the dropping policy may introduce new problems which
> might not be easily predictable at this moment, e.g., stability, looping
> (propagating stale information within the network might cause even more
> nasty looping problems).

I agree that this might introduce new problems which is the reason for posting 
it here. I definitely see the overhead created by that methog. Every better 
idea will be accepted immediately.  :-)


> Another way (and maybe simpler ) to fix the problem: instead of loosing the
> OGM dropping policy,  loosing the echo cancellation policy.
>
> It is a very simple fix: in addition to the usual echo cancellation
> process, I also check  the TQ value contained in the echoed OGM.  This TQ
> is announced by the neighbor that broadcasts this echo. If this TQ is worse
> than my current TQ estimation towards that neighbor, I update the
> estimation with this TQ.

In your testbed it fixed the issue ?
Looking at the example you gave I would expect that the problem is only solved 
partially. You argued the OGMs from E via A would always arrive faster at B 
compared to the longer path. Using your method would probably avoid the loop 
between A and B in the event of a packet loss on the longer path but it would 
not let route A via the longer path. Am I mistaken ?

Regards,
Marek
