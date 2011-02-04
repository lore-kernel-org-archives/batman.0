Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 4 Feb 2011 15:21:33 +0100
References: <4D12694F.8020102@tiwoc.de>
	<201012231322.49591.lindner_marek@yahoo.de>
	<AANLkTik-6zj4JJaj7hqbMr=7KNX_JqHbtY=GrhrVafJV@mail.gmail.com>
In-Reply-To: <AANLkTik-6zj4JJaj7hqbMr=7KNX_JqHbtY=GrhrVafJV@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201102041521.33908.lindner_marek@yahoo.de>
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

>             I'm an author of  "Routing Protocols for Mesh Networks
> with Mobility Support"  and "Assessing Mobility Support in Mesh
> Networks".
> I'm very happy to hear that someone is reading these papers and I'm
> glad to discuss with you about them.

welcome on our list!  :-)


> Indeed, in our comparison with the "Draft" BATMAN, we explicitly introduced
> a timer to force the old route to be dropped out of the window. Please note
> that this timer is just two times the originator time interval (i.e., 2
> seconds using the value in the draft) and it does not depend on the
> PURGE_TIMEOUT. We could call it NEIGHBOR_TIMEOUT.

Thanks for the clarifications. Please note that it does not matter how long a 
certain timeout is - every timeout which influences routing decisions is a 
potential risk for routing loops. We, the people behind batman, are very well 
aware that a timeout free routing algorithm does not converge as fast as one 
with timeouts but also is less susceptible to routing loops. Your tests / 
paper demonstrated this fact once more.
Of course, we are interested in improving the algorithm as long as it does not 
happen on the expense of stability. We are going to study your paper at the 
coming WirelessBattleMesh in Barcelona to give you detailed feedback regarding 
your ideas.

Regards,
Marek
