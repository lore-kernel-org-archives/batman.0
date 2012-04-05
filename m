Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 5 Apr 2012 23:30:06 +0300
References: <201203222250.31309.lindner_marek@yahoo.de>
	<20120323063206.GA5662@lunn.ch>
In-Reply-To: <20120323063206.GA5662@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204052330.06655.lindner_marek@yahoo.de>
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


Hi Andrew,

excuse the delayed answers - the wbmv5 was rather intense.  ;-)


> The problem with broadcasting the ELP packets is that they are always
> sent with the most robust coding rate. So ELP gives you an idea how
> good the 1Mbps broadcast channel is, not how good the unicast channel
> the automatic rate selection algorithm is using is. I think we
> discussed mixing in some unicast packets in the forward direction. The
> ELP packets containing the reports would stay the same, and so
> function as node detection. But a node could also send out unicast ELP
> packets to its known neighbours and they would be included into the
> LQ.
> 
> There are obvious drawbacks. More overhead, especially in dense
> networks. It is also not clear if the measurements would be
> better. Unicast packets get a number of retries with fast ACKs, where
> as multicast does not. So multicast might actually give a better
> measure of the link at 1Mbps.
> 
> Do you know if Linus had chance to explore these ideas during his
> GSOC?

the problem is known but we did not have enough time to explore it. One idea 
we had in mind was sending larger ELP broadcast packets every now and then in 
the hope of better estimating the link quality. The feature to increase the 
ELP packet size is part of this patchset and would allow to test this idea.

On the other hand I think we should move towards throughput based path 
decisions. It tells us so much more about what we really care about. Some 
obstacles are waiting for us if we go down this path. Have you ever 
experimented with this approach ?

Regards,
Marek
