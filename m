Return-Path: <post@tiwoc.de>
Message-ID: <4D12694F.8020102@tiwoc.de>
Date: Wed, 22 Dec 2010 22:10:39 +0100
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070308090904050207000907"
Subject: [B.A.T.M.A.N.] Weighting the local packet count;
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

This is a multi-part message in MIME format.
--------------070308090904050207000907
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi there,

I found an interesting paper today that covers mobility of some nodes in
a batman-adv network:

> Stefano Annese, Claudio Casetti, Carla F. Chiasserini, Paolo
> Cipollone, Andrea Ghittino, and Massimo Reineri. 2009. Assessing
> mobility support in mesh networks. In Proceedings of the 4th ACM
> international workshop on Experimental evaluation and
> characterization (WINTECH '09).
http://portal.acm.org/citation.cfm?id=1614297

Unfortunately, the paper is not freely available on the web. If you're
blessed with access to the ACM digital library by your school or
employer, you can download it free of charge; in other cases you'll have
to buy it for USD 15.

In the following, I will summarize relevant parts:


I) Weighting the local packet count

The authors found that when each entry in the sliding window is weighed
with the same weight as it is done in the current version of batman-adv,
routing loops can occur when mobility is present. They greatly improve
their results by weighting with the following function (i = 0..S-1 where
S is the window size; 0 means freshest packet):

weight(i) := max(1, floor(i * S / e^i))

This function seems to be suboptimal as it weights entry 0 with 1 while
the following few entries are boosted with a weight of up to 20 (see
attachment). Adding 1 to i should deal with this flaw.

However, this weighting function lead to big improvements in the
authors' simulations, so I think you are on the right track when
thinking about introducing some kind of weighting or moving average to
boost the weight of current packets.

Here's the Octave/Matlab code I used to create the plot (if you want to
do plots for other weighting functions that are discussed, just replace
the definition of w and don't forget to use .* and ./ instead of * and /
to enforce elementwise operations):
> x = 0:63
> w = max(1, x.*64./exp(x))
> stem(x,w)
> xlabel('age')
> ylabel('weight')


II) Optimizations for multi-interface nodes

The authors used nodes with 2 radios. They did roughly the following on
the mobile nodes (not on the fixed ones):

1) In regular intervals, scan the forwarding tables for each interface
to check if any neighbors are known. If an interface has no contact to
any neighbor, go to 2)

2) Use the interface without known neighbors to scan all channels except
the channel that the other interface is listening to. Don't send OGMs
but simply listen for OGMs from other stations. If a channel is found
that has a neighbor sending, stay on this channel and start to behave
like a normal batman-adv node (send OGMs etc.).

I'm not sure if this will be benefitial in other scenarios than in the
vehicular network scenario of the paper, but I wanted to share my
findings with you.

- Daniel

--------------070308090904050207000907
Content-Type: image/png;
 name="weight.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="weight.png"

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
--------------070308090904050207000907--
