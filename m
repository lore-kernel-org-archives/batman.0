Return-Path: <post@tiwoc.de>
Message-ID: <4C061EE4.1040601@tiwoc.de>
Date: Wed, 02 Jun 2010 11:05:40 +0200
From: Daniel Seither <post@tiwoc.de>
MIME-Version: 1.0
References: <4C058626.4060108@interia.pl>
In-Reply-To: <4C058626.4060108@interia.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] building testbed for batman-adv and
	expected	performance/throughput
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
To: Krzysztof Urbas <krzysu@interia.pl>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello!

Am 02.06.2010 00:13, schrieb Krzysztof Urbas:
> So my questions are:
> 1. Do you have any suggestions how to build multi-hop testbed in
> laboratory environment (in one room)?

A multi-hop testbed in a single room will probably only work if you use
attenuators between your device and the antenna. This setup was used in
the following paper:
http://wirelessafrica.meraka.org.za/wiki/images/9/98/Batman_ifip.pdf

If your testbed should be more realistic, you really need to distribute
your devices over a larger area, but with only 4 nodes, interesting
multi-hop connections will be rather hard to achieve. If there's only
one possible path for the signal, a routing protocol cannot show how
reliably it choses a stable path.

> 2. How to make testing proces more automatic (some kind of central
> server to run tests and collect data)?

Use Ethernet to connect your devices so you can manage your experiments
out of band. With pssh or cssh, the same command can be run on multiple
nodes at the same time (if you need that). With pssh, you can even
push/retrieve data to/from multiple nodes.

* http://code.google.com/p/parallel-ssh/
* http://sourceforge.net/apps/mediawiki/clusterssh/index.php?title=Main_Page

> 5. Do you have any other
> suggestions/observations/conclusions/example_data from your tests?

TCP over lossy (wireless!) networks is a big problem since TCP's
congestion control algorithm interprets packet loss as congestion, which
is great for wired networks but in most cases wrong for wireless. This
can seriously impair throughput.

A second factor for low througput: A station that forwards data
communicates with all of its neighbors on the same channel which means
that while sending, it cannot receive data at the same time. This can
impact performance quite seriously.

There's literature (try Google Scholar) on both problems.

Regards,
Daniel
