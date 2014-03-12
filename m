Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 12 Mar 2014 11:36:16 +0100
References: <20140310212525.GU24339@pengutronix.de>
In-Reply-To: <20140310212525.GU24339@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201403121136.16430.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] Line of Nodes
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hey Robert,

> Hi,
> 
> I have a little bit strange usecase for a wireless mesh network, and I'm
> wondering if B.A.T.M.A.N could be a good choice: my network stations,
> which are part of an industrial application, are located in a line:
> 
>   Gateway - A1 - A2 - A3 - A4 - A5 - ... - A120
> 
> Any station generates data and wants to transmit it to the gateway, with
> the smallest possible latency. The distance of the stations is pretty
> small: about 3...4 m.
> 
> It might happen that someone re-arranges the stations:
> 
>   Gateway - A9 - A17 - A1 - A47 - A9 - ... - A6
> 
> but the topology stays the same (a line).
> 
> It is allowed that one station sends its data to the farest reachable
> hop, so i.e. for my first example, if A5 wants to send data and is able
> to reach A2, it could directly do so.
> 
> - What do you think, could B.A.T.M.A.N be a solution?

Yes, BATMAN could help in this situation - its better than doing it statically 
at least, since batman can decide how many intermediate hops to skip.

> - Could the short distance be a problem?

well you have interference between the nodes and the typical throughput 
limitations because of the half-duplex nature of WiFi. But if you take that 
into consideration and don't expect the same throughput as on a single link, 
3-4 meter should be fine.

It also depends on what kind of data you will send (many industrial 
applications use broadcast, for example).

> - Is it possible to regulate the transmission power in order to avoid
>   disturbance?

There are WiFi driver which allow that, yes. However I'd recommend to keep it 
as it is and change the broadcast rate to something higher (e.g. 18M or more) 
to force to only use good links, even if they are a little shorter.

Cheers,
    Simon
