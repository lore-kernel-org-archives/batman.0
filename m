Return-Path: <andrew@lunn.ch>
Date: Tue, 13 Oct 2009 09:54:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091013075431.GE21060@lunn.ch>
References: <20091012081122.GB12833@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091012081122.GB12833@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] Changing vis output ready for mainline...
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

>         "fe:fe:00:00:04:01" -> "fe:fe:00:00:05:01" [label="1.0"]
>         "fe:fe:00:00:04:01" -> "fe:fe:00:00:03:01" [label="1.0"]
>         "fe:fe:00:00:04:01" -> "00:ff:7c:3c:ec:e0" [label="HNA"]
>         subgraph "cluster_fe:fe:00:00:04:01" {
>                 "fe:fe:00:00:04:01" [peripheries=2]
>                 "fe:fe:00:00:04:02"
>         }
> 
> I suggest something like:
> 
> fe:fe:00:00:04:01 fe:fe:00:00:05:01 255 fe:fe:00:00:03:01 255 00:ff:7c:3c:ec:e0 HNA fe:fe:00:00:04:02 S
> 
> In BNF something like
> 
> <Primary MAC> <Doublets>
> <Doublets>   ::= {<Doublet> }
> <Doublet>    ::= <MAC> <Flag/Value>
> <Flag/Value> ::= <TQ_Value>|<HNA>|<Secondary>
> <TQ_Value>   ::= uint8_t
> <HNA>        ::= "HNA"
> <Secondary>  ::= "S"

A small refinement:
<Doublets>   ::= {<Doublet> ","}

Adding the comma makes the format more future proof. If in the future
we need to add more doublets, triplets, etc we can do it without
breaking backwards compatibility. If batctl finds something it does
not understand, it skips to the next , separator and keeps going.

    Andrew
