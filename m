From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 30 Apr 2009 16:46:49 +0800
References: <209743CECB91EB4F84169A51F300410D1F3137C3F9@MAIL02.ug.kth.se>
	<49F5E0D3.208@gmx.net> <49F96044.4070207@informatik.haw-hamburg.de>
In-Reply-To: <49F96044.4070207@informatik.haw-hamburg.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904301646.50271.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Masters thesis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

> Was the protocol implemented yet on a simulation platform like omnet?
> For comparing purposes (for example with OLSR) it could be interesting
> to simulate the protocol.

there is no simulator support that I know of.


> Further the package load will be tunnelled through batman network by an
> udp tunnel. There was reasons to do this. But why we can not establish
> an tcp-tunel on top of the existing tunnels. So earn more overhead but
> the delivery of the related packages are granted.

It is not necessary to implement the tunnel with TCP as all protocols that use 
the tunnel already have a mechanism to detect packet lost. If you issue a HTTP 
query over a tunnel it will look like this:
HTTP -> TCP -> UDP Tunnel -> Internet

Your setup would look like this:
HTTP -> TCP -> TCP Tunnel -> Internet

Next to the overhead which comes with TCP you will face a double congestion 
window (see TCP congestion avoidance). In a lossy environment TCP over TCP 
connection will run at the lowest speed possible without a chance to recover. 


> In respect to IPv6: What is the problem with IPv6? The batman protocol
> self should work with ipv6? As payload it could be realized by an tunnel
> too.

Its not a problem - just somebody needs to do it.  :-)

Regards,
Marek

