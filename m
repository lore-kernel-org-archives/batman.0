Return-Path: <andrew@lunn.ch>
Date: Sat, 26 Mar 2011 18:45:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110326174547.GL17979@lunn.ch>
References: <20110326172155.GA11235@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110326172155.GA11235@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] TTL yes, TTL no
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

> I think it is wrong: TQ is not decremented by hop_penalty each time, but it is
> multiplied by (TQ_MAX-hop_penalty/TQ_MAX), then the number of hops is
> bigger than what you said. With hop_penalty = 10 we can probably reach
> ~135 hops (raw calculus 255*(TQ_MAX-hop_penalty/TQ_MAX)^135) =~ 0)

I agree with the principle. However, you need to take rounding into
effect. The kernel does integer arithmetic and TQ is always an integer
value. I also got it wrong in my last post. I used the wrong round
function when calculating the values. Using rounddown() i get:

255
245
235
225
216
207
198
190
182
174
167
160
153
147
141
135
129
123
118
113
108
103
98
94
90
86
82
78
74
71
68
65
62
59
56
53
50
48
46
44
42
40
38
36
34
32
30
28
26
24
23
22
21
20
19
18
17
16
15
14
13
12
11
10
9
8
7
6
5
4
3
2
1
0

After 73 hops, TQ will be zero.

> Looking at the calculus above, I'm proposing to use TTL = ~135

TTL of 73 would be more accurate i think.

Which leads me to a new question. At WBM we talked about moving the
HNAs out of the OGMs. If we had a really big mesh, with more than 73
hops from side to side, do we get into a situation where we have HNAs
from more than 73 hops away, but no idea how to route to them since
OGMs got dropped when TQ reached 0?

     Andrew
