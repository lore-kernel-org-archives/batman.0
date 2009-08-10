Return-Path: <Yang.Su@ascom.CH>
In-Reply-To: <200908101548.53459.lindner_marek@yahoo.de>
References: <20090722105639.GH32143@ma.tech.ascom.ch>	<200908072358.08849.lindner_marek@yahoo.de>
	<OF6771C76D.6C69E95B-ONC125760E.002641B8-C125760E.0028535B@CHASCOM.INT>
	<200908101548.53459.lindner_marek@yahoo.de>
Message-ID: <OF15A3814D.94B5B275-ONC125760E.002B50BE-C125760E.002BB709@CHASCOM.INT>
From: Yang Su <Yang.Su@ascom.CH>
Date: Mon, 10 Aug 2009 09:57:29 +0200
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
  |10.08.2009 09:50                                                                                                                                  |
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








On Monday 10 August 2009 15:20:28 Yang Su wrote:
> For the echo cancellation example: the problem happens with the
interaction
> between A and B. Because of the asym link, A chooses B as its next
neighbor
> towards F. Because the asym path is short, B always receives F's OGM from
A
> first  (before B receives the OGM with the same seqno from C). As a
result,
> from A's point of view, F's OGMs rebroadcasted by B are always echoes and
A
> will never update the TQ information towards F via B.
>
> When the quality of any links on the path B to F drops down, B might
choose
> A as its next neighbor towards F and a loop forms between A and B.

Ah, here we have the misunderstanding. Let me briefly outline how the echo
cancellation works (I refer to your PDF-example):

1. Node C emits a packet.
2. Node B receives it and writes the address of Node C in the previous
sender
field because it received that packet via C. Now, B rebroadcasts the OGM.

-- B has already rebroadcasted an earlier OGM with the same sequence number
(received from A). Will B rebroadcast the OGM with the same sequence number
(received from C) again?

3. Node C receives the packet it sent before and discards it as the packet
contains its own address in the previous sender field.
4. Node A happily receives the packet (and goes back to step 2).


Cheers,
Yang

