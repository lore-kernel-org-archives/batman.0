Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 23 Dec 2010 13:22:49 +0100
References: <4D12694F.8020102@tiwoc.de>
	<AANLkTi=ORJ4Sz9nZT3rT9ofXHdtDVva1U4GQqD-p0ujO@mail.gmail.com>
In-Reply-To: <AANLkTi=ORJ4Sz9nZT3rT9ofXHdtDVva1U4GQqD-p0ujO@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201012231322.49591.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Weighting the local packet count;
	Optimizations for multi-interface nodes
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


Hi,

> "Note that, within a timeout, set by default to twice the OGM
> interval, nodes purge a neighbor from which OGMs are no longer
> received"
> 
> In fact the PURGE_TIMEOUT is set to a value of 200s so the problem
> described in the paper, in my opinion, comes from a wrong
> implementation of B.A.T.M.A.N. in the ns2 simulator used in the paper.

you are absolutely right. The authors assume the batman protocol is based on 
timeouts which leads to wrong results. Anyone interested to understand the 
PURGE_TIMEOUT can consult our FAQ.

During the WBMv3 we studied a paper called "Routing protocols for mesh 
networks with mobility support" which seems to have a similar content / same 
authors (?) and contacted the authors to let them know about their wrong 
assumption. Not sure in which manner these papers are related ...


> Furthermore in my opinion, is better that mobile nodes does not use
> B.A.T.M.A.N. but should act as mesh unaware nodes exploiting HNA. Mesh
> network are not MANET...

Agreed.

Cheers,
Marek
