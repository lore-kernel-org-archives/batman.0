Return-Path: <andrew@lunn.ch>
Date: Mon, 12 Oct 2009 10:11:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091012081122.GB12833@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Changing vis output ready for mainline...
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
To: b.a.t.m.a.n@lists.open-mesh.net

Hi Folks

We need to discuss the changes which are needed to the VIS output for
inclusion of batman into mainline.

At the moment the vis output can be read from /proc/net/batman-adv/vis. It
supports two formats, graphviz dot and JSON. This can be selected
using the file /proc/net/batman-adv/vis_format.

I see a few problems here. 

1) No other /proc file in mainline does any special formatting. Either
comma separated value or space separated value is used. User space
reads this and then performs any formatting needed.

2) No other /proc file supports two userspace switchable formats!

3) We have problems when multiple applications wants different formats
at the same time. One wants dot the other wants JSON. Currently there
is no locking, so something bad is going to happen.

There are a number of ways to solve this. We should discuss different
proposals.

I would suggest changing /proc/net/batman-adv/vis to space separated
value and moving the current formatting code into batctl. I don't yet
have a 100% defined format in mind.

A current vis output would be:

        "fe:fe:00:00:04:01" -> "fe:fe:00:00:05:01" [label="1.0"]
        "fe:fe:00:00:04:01" -> "fe:fe:00:00:03:01" [label="1.0"]
        "fe:fe:00:00:04:01" -> "00:ff:7c:3c:ec:e0" [label="HNA"]
        subgraph "cluster_fe:fe:00:00:04:01" {
                "fe:fe:00:00:04:01" [peripheries=2]
                "fe:fe:00:00:04:02"
        }

I suggest something like:

fe:fe:00:00:04:01 fe:fe:00:00:05:01 255 fe:fe:00:00:03:01 255 00:ff:7c:3c:ec:e0 HNA fe:fe:00:00:04:02 S

In BNF something like

<Primary MAC> <Doublets>
<Doublets>   ::= {<Doublet> }
<Doublet>    ::= <MAC> <Flag/Value>
<Flag/Value> ::= <TQ_Value>|<HNA>|<Secondary>
<TQ_Value>   ::= uint8_t
<HNA>        ::= "HNA"
<Secondary>  ::= "S"

We then have a list of these, one line per mesh node which has
provided VIS information.

What do others thing of this? Does anybody have a different proposal?

     Thanks
        Andrew
