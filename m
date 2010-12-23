Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4D12694F.8020102@tiwoc.de>
References: <4D12694F.8020102@tiwoc.de>
Date: Thu, 23 Dec 2010 11:07:59 +0100
Message-ID: <AANLkTi=ORJ4Sz9nZT3rT9ofXHdtDVva1U4GQqD-p0ujO@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
very interesting document.
However the problem of routing loops described in the paper is based
on this erroneous information about B.A.T.M.A.N.:

"Note that, within a timeout, set by default to twice the OGM
interval, nodes purge a neighbor from which OGMs are no longer
received"

In fact the PURGE_TIMEOUT is set to a value of 200s so the problem
described in the paper, in my opinion, comes from a wrong
implementation of B.A.T.M.A.N. in the ns2 simulator used in the paper.

Anyhow the weighting function of the window is an interesting part but
unfortunately the authors does not describe how this is the best
function. Being a good weighting function in a specific network
scenario does not mean being the best function at all! :)

Furthermore in my opinion, is better that mobile nodes does not use
B.A.T.M.A.N. but should act as mesh unaware nodes exploiting HNA. Mesh
network are not MANET...

Regards!

2010/12/22 Daniel Seither <post@tiwoc.de>:
> Hi there,
>
> I found an interesting paper today that covers mobility of some nodes in
> a batman-adv network:
>
>> Stefano Annese, Claudio Casetti, Carla F. Chiasserini, Paolo
>> Cipollone, Andrea Ghittino, and Massimo Reineri. 2009. Assessing
>> mobility support in mesh networks. In Proceedings of the 4th ACM
>> international workshop on Experimental evaluation and
>> characterization (WINTECH '09).
> http://portal.acm.org/citation.cfm?id=1614297
>
> Unfortunately, the paper is not freely available on the web. If you're
> blessed with access to the ACM digital library by your school or
> employer, you can download it free of charge; in other cases you'll have
> to buy it for USD 15.
>
> In the following, I will summarize relevant parts:
>
>
> I) Weighting the local packet count
>
> The authors found that when each entry in the sliding window is weighed
> with the same weight as it is done in the current version of batman-adv,
> routing loops can occur when mobility is present. They greatly improve
> their results by weighting with the following function (i = 0..S-1 where
> S is the window size; 0 means freshest packet):
>
> weight(i) := max(1, floor(i * S / e^i))
>
> This function seems to be suboptimal as it weights entry 0 with 1 while
> the following few entries are boosted with a weight of up to 20 (see
> attachment). Adding 1 to i should deal with this flaw.
>
> However, this weighting function lead to big improvements in the
> authors' simulations, so I think you are on the right track when
> thinking about introducing some kind of weighting or moving average to
> boost the weight of current packets.
>
> Here's the Octave/Matlab code I used to create the plot (if you want to
> do plots for other weighting functions that are discussed, just replace
> the definition of w and don't forget to use .* and ./ instead of * and /
> to enforce elementwise operations):
>> x = 0:63
>> w = max(1, x.*64./exp(x))
>> stem(x,w)
>> xlabel('age')
>> ylabel('weight')
>
>
> II) Optimizations for multi-interface nodes
>
> The authors used nodes with 2 radios. They did roughly the following on
> the mobile nodes (not on the fixed ones):
>
> 1) In regular intervals, scan the forwarding tables for each interface
> to check if any neighbors are known. If an interface has no contact to
> any neighbor, go to 2)
>
> 2) Use the interface without known neighbors to scan all channels except
> the channel that the other interface is listening to. Don't send OGMs
> but simply listen for OGMs from other stations. If a channel is found
> that has a neighbor sending, stay on this channel and start to behave
> like a normal batman-adv node (send OGMs etc.).
>
> I'm not sure if this will be benefitial in other scenarios than in the
> vehicular network scenario of the paper, but I wanted to share my
> findings with you.
>
> - Daniel
>



-- 
Daniele Furlan (furland)
