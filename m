Return-Path: <andrew@lunn.ch>
Date: Mon, 12 Oct 2009 17:22:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091012152250.GD12833@lunn.ch>
References: <20091012081122.GB12833@lunn.ch>
	<65D79C94-1997-418C-B773-54D0E79D5FA3@7degrees.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65D79C94-1997-418C-B773-54D0E79D5FA3@7degrees.co.za>
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

> >A current vis output would be:
> >
> >       "fe:fe:00:00:04:01" -> "fe:fe:00:00:05:01" [label="1.0"]
> >       "fe:fe:00:00:04:01" -> "fe:fe:00:00:03:01" [label="1.0"]
> >       "fe:fe:00:00:04:01" -> "00:ff:7c:3c:ec:e0" [label="HNA"]
> >       subgraph "cluster_fe:fe:00:00:04:01" {
> >               "fe:fe:00:00:04:01" [peripheries=2]
> >               "fe:fe:00:00:04:02"
> >       }
> >
> >I suggest something like:
> >
> >fe:fe:00:00:04:01 fe:fe:00:00:05:01 255 fe:fe:00:00:03:01 255
> >00:ff:7c:3c:ec:e0 HNA fe:fe:00:00:04:02 S
> >
> >In BNF something like
> >
> ><Primary MAC> <Doublets>
> ><Doublets>   ::= {<Doublet> }
> ><Doublet>    ::= <MAC> <Flag/Value>
> ><Flag/Value> ::= <TQ_Value>|<HNA>|<Secondary>
> ><TQ_Value>   ::= uint8_t
> ><HNA>        ::= "HNA"
> ><Secondary>  ::= "S"
> >We then have a list of these, one line per mesh node which has
> >provided VIS information.
> 
> 
> Couple of questions:
> 
> * Would (<TQ_Value> / 255) be equivalent to the label value in the
> current vis output?

I need to look at the current code to see how it derives its
value. Since you cannot use floating point in the kernel i know it
does something different than plain /255. What ever it does, i would
keep the same algorithm in batctl so the values stay the same. It
would also be possible to add a flag to batctl to really do a floating
point TQ_Value/255. 

> * Does <Secondary> refer to a secondary interface reachable from
> <Primary MAC> ?

Linus added the subgraph for the primary and secondary interfaces. 

https://lists.open-mesh.net/pipermail/b.a.t.m.a.n/2009-August/001669.html
https://lists.open-mesh.net/pipermail/b.a.t.m.a.n/2009-August/001723.html

The word "secondary" is mine, i don't think Linus used it
anywhere. I'm happy to change this to something else.
 
> Looks sane!

Thanks

        Andrew
