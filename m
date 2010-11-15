Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Nov 2010 11:14:51 +0100
References: <7id3qa2xwq.fsf@lanthane.pps.jussieu.fr>
	<4CE08734.9010402@murdoch.edu.au>
In-Reply-To: <4CE08734.9010402@murdoch.edu.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201011151114.52497.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Another peer-reviewed assessment of
	Babel, Batman and OLSR
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
To: battlemesh@ml.ninux.org, olsr-users@lists.olsr.org
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>, T.Koziniec@murdoch.edu.au, David Murray <D.Murray@murdoch.edu.au>, b.a.t.m.a.n@lists.open-mesh.org, M.Dixon@murdoch.edu.au


Hi,

> We are happy to answer any questions people might have with that paper.

Quote from:
http://bridgingthelayers.org/docs/murray_routing.pdf

"Upon inspection of the BATMAN L2 and BATMAN L3
results, the only major performance difference between data
link layer routing and network layer routing is the packet
size. Data link layer routing protocols will not require a
network layer IPv4/IPv6 header and may therefore be smaller."

Please note that the packet size of the protocol packets might be of vital 
importance to the IETF and IEEE but for the batman project that was a rather 
insignificant side effect. Having full control over the traffic flowing through the 
mesh was the main motivation to go down to layer 2. It allowed us to implement 
things like broadcast support & broadcast optimization (ARQ), multicast 
support & optimization, interface alternating (consult the second part of this 
article: http://www.open-mesh.org/wiki/2010-06-13-wbm2010-bracciano), seamless 
roaming for non-mesh participants.

Regards,
Marek
