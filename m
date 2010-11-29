Return-Path: <neumann@cgws.de>
From: Axel Neumann <neumann@cgws.de>
Date: Mon, 29 Nov 2010 17:29:42 +0100
References: <AANLkTimnCjXo7BWuC5kHeb2AK36DrkD8Bheo7s0UHDyb@mail.gmail.com>
In-Reply-To: <AANLkTimnCjXo7BWuC5kHeb2AK36DrkD8Bheo7s0UHDyb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201011291729.43323.neumann@cgws.de>
Subject: Re: [B.A.T.M.A.N.] Problem with BMX 0.3 and the Vis Server in the
	dot draw output
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

Hi Julio,

thanks for the hint!
Fixed seomething (the vis_packet->seq_range) in rv1884 and then did some minor 
code beatifications in rv1885. 
Can you please test with rv1885 ?  

cu
/axel


On Donnerstag 25 November 2010, Julio Cesar Puigpinos wrote:
> Hello,
> 
> We are having a problem with BMX and the Vis Server, the dot draw
> output is not been fully showed. It happens when running BMX 0.3
> rv1707 (or 0.3-rc1 rv1694 too). The Vis Server used is 0.3.1-beta, and
> the packets arrive to it.
> 
> The established links (checked with debug level 8) that a node has,
> when running those versions of BMX, are not been showed by the Vis
> Server.
> 
> For example, Node A and B running BMX 0.3 rv1707 and Node C running
> BMX 0.3-alpha.
> The dot draw output looks like:
> "Node C" -> "Node A"[label="1.05"]
> "Node C" -> "Node B"[label="1.05"]
> "Node A" -> "0.0.0.0/0.0.0.0"[label="HNA"]
> 
> When it should be like this:
> "Node C" -> "Node A"[label="1.05"]
> "Node C" -> "Node B"[label="1.05"]
> "Node A" -> "0.0.0.0/0.0.0.0"[label="HNA"]
> "Node A" -> "Node C"[label="1.05"]
> "Node A" -> "Node B"[label="1.05"]
> "Node B" -> "Node A"[label="1.05"]
> "Node B" -> "Node C"[label="1.05"]
> 
> 
> I have attached a Wireshark dump to show the format of the vis
> packets. For example, 5.252.88.99 is running BMX 0.3-rc1 rv1694
> (compatibility version 10) and 5.172.151.75 is running BMX 0.3-alpha
> (compatibility version 10). They both show with debug level 8 that
> have links in both ways.
> 
> 
>                   Saludos, Julio

