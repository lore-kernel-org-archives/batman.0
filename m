Return-Path: <andrew@lunn.ch>
Date: Mon, 21 Mar 2016 14:25:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160321132510.GG28582@lunn.ch>
References: <1458551033-8734-1-git-send-email-hwhilse@gmail.com>
 <2352013.EmfB5eiPMC@bentobox>
 <e5bc47fb3a536ddda2923e4d85773cb4@hilses.de>
 <4157766.3ikgnCPmEQ@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4157766.3ikgnCPmEQ@prime>
Subject: Re: [B.A.T.M.A.N.] [RFC] alfred: implement TCP support for
 server-to-server communication
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Hans-Werner Hilse <hwhilse@gmail.com>

> I was also thinking that we might want to use TCP in general when the packet 
> size reaches a certain threshold (e.g. >3kB), and always use UDP for small 
> packets. Then we would also not need the commandline option (unless you think 
> we should leave a way to force a mode). Any thoughts on that?

Hi Simon

Either/or behaviour like this can cause hard to understand
issues. e.g. i opened a hole in the firewall to let Alfred traffic
though, but it suddenly stops when the network gets big, because it
swapped to TCP, and i don't have a hole of that. Similar for QoS
filters, i prioritise UDP Alfred packets, but when it swaps to TCP
they are not prioritised and get discarded during congestion...

     Andrew
