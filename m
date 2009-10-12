Return-Path: <antoine@7degrees.co.za>
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v1076)
From: Antoine van Gelder <antoine@7degrees.co.za>
In-Reply-To: <20091012081122.GB12833@lunn.ch>
Date: Mon, 12 Oct 2009 13:59:09 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <65D79C94-1997-418C-B773-54D0E79D5FA3@7degrees.co.za>
References: <20091012081122.GB12833@lunn.ch>
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


On 12 Oct 2009, at 10:11 , Andrew Lunn proposed:

> I would suggest changing /proc/net/batman-adv/vis to space separated
> value and moving the current formatting code into batctl. I don't yet
> have a 100% defined format in mind.


+1

/proc output formats should be unary and certainly be parse-able using  
command line tools.

Moving the DOT & JSON formatting code to batctl should also ensure  
that this change has minimal impact on users.



> A current vis output would be:
>
>        "fe:fe:00:00:04:01" -> "fe:fe:00:00:05:01" [label="1.0"]
>        "fe:fe:00:00:04:01" -> "fe:fe:00:00:03:01" [label="1.0"]
>        "fe:fe:00:00:04:01" -> "00:ff:7c:3c:ec:e0" [label="HNA"]
>        subgraph "cluster_fe:fe:00:00:04:01" {
>                "fe:fe:00:00:04:01" [peripheries=2]
>                "fe:fe:00:00:04:02"
>        }
>
> I suggest something like:
>
> fe:fe:00:00:04:01 fe:fe:00:00:05:01 255 fe:fe:00:00:03:01 255 00:ff: 
> 7c:3c:ec:e0 HNA fe:fe:00:00:04:02 S
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
> We then have a list of these, one line per mesh node which has
> provided VIS information.


Couple of questions:

* Would (<TQ_Value> / 255) be equivalent to the label value in the  
current vis output?

* Does <Secondary> refer to a secondary interface reachable from  
<Primary MAC> ?

Looks sane!

  - antoine

