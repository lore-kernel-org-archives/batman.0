Return-Path: <gwirth79@gmail.com>
Message-ID: <4B1F4584.6000802@gmail.com>
Date: Tue, 08 Dec 2009 22:36:52 -0800
From: Gus Wirth <gwirth79@gmail.com>
MIME-Version: 1.0
References: <391345.99048.qm@web111612.mail.gq1.yahoo.com>
In-Reply-To: <391345.99048.qm@web111612.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] general theory question RE: dhcp on a peer only
 mesh
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

On 12/08/2009 08:24 PM, George Sanders wrote:
>
>
> This is not a BATMAN specific question, but I see very clueful
> chatter here and would appreciate any comments.
>
> My question is:
>
> Who provides IP addresses in a truly ad-hoc, truly "peer only" mesh
> network ?
>
> That is, if I create a pool of clients, and have no centralized
> authority of any kind - every node is a peer, and is simply a client
> talking to other clients, how does anyone get an IP address ?
>
> This assumes that there is no connection to the proper Internet and
> that this is simply a small pool of clients arranged to perform peer
> to peer networking.  But again, if it is an IP network ... how would
> you get IPs properly ?
>
> If you guess ahead of time, you will either be on different IP
> networks/subnets, or you will collide your addresses.
>
> If you have no DHCP servers, that won't work ...
>
> The only thing I can think of is that _everyone_ is a DHCP server and
> you somehow manage timing so as to decide who should get an address
> from whom ...
>
> Please do point me to any writings or information related to this.

Take a look at RFC3927. Also article on Wikipedia about Avahi 
<http://en.wikipedia.org/wiki/Avahi_%28software%29>

Gus
