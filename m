Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 10 Aug 2009 15:48:40 +0800
References: <20090722105639.GH32143@ma.tech.ascom.ch>
	<200908072358.08849.lindner_marek@yahoo.de>
	<OF6771C76D.6C69E95B-ONC125760E.002641B8-C125760E.0028535B@CHASCOM.INT>
In-Reply-To: <OF6771C76D.6C69E95B-ONC125760E.002641B8-C125760E.0028535B@CHASCOM.INT>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908101548.53459.lindner_marek@yahoo.de>
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

On Monday 10 August 2009 15:20:28 Yang Su wrote:
> For the echo cancellation example: the problem happens with the interaction
> between A and B. Because of the asym link, A chooses B as its next neighbor
> towards F. Because the asym path is short, B always receives F's OGM from A
> first  (before B receives the OGM with the same seqno from C). As a result,
> from A's point of view, F's OGMs rebroadcasted by B are always echoes and A
> will never update the TQ information towards F via B.
>
> When the quality of any links on the path B to F drops down, B might choose
> A as its next neighbor towards F and a loop forms between A and B.

Ah, here we have the misunderstanding. Let me briefly outline how the echo 
cancellation works (I refer to your PDF-example):

1. Node C emits a packet.
2. Node B receives it and writes the address of Node C in the previous sender 
field because it received that packet via C. Now, B rebroadcasts the OGM.
3. Node C receives the packet it sent before and discards it as the packet 
contains its own address in the previous sender field.
4. Node A happily receives the packet (and goes back to step 2).

The echo cancellation will not kill the packets coming via the longer path. 

Does this help ? 

Regards,
Marek

