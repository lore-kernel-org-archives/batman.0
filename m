From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Texas UML instances and OLSR+BATMAN tests
Date: Tue, 9 Oct 2007 14:50:50 +0200
References: <20070608201844.GM20739@localhost>
	<200710090953.43820.axel@open-mesh.net> <470B45AE.40502@poelzi.org>
In-Reply-To: <470B45AE.40502@poelzi.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710091450.50135.axel@open-mesh.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello,

> in openvz usuall all ebtables and iptables modules are supported in the
> 0 instance. modules that can be used inside of virtuall instances have
> to be prepared for this. but this shouldn't be a problem for your setup,
> so i guess the problem may be somewhere else.

As fare as I remember there have been some promlems with the development 
versions of openVZ. With the stable version for kernel 2.6.18 everything 
worked fine. 
Except, the ebtables module oopsed when applying more than 25 rules !! Because 
I wanted to configure virtual networks with up to 100 nodes this was a 
problem. The mentioned patch solved this problem.

ciao
/axel
