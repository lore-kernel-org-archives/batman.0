Message-ID: <17196.85.41.146.90.1190212517.squirrel@krisma.oltrelinux.com>
In-Reply-To: <200709191525.12422.onelektra@gmx.net>
References: <2bda28cd0709190519r74f0c58ncc1c23553c925091@mail.gmail.com>
	<200709191525.12422.onelektra@gmx.net>
Date: Wed, 19 Sep 2007 16:35:17 +0200 (CEST)
Subject: Re: [B.A.T.M.A.N.] batman routing clarification
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi,

> which version of batman are you using? And you should provide us with more
> details. Just saying Link is 'poor' or 'good' is very unprecise. Remember:
> A direct route with 6 Megabit performs similar to a two-hop link with 12
> Megabits on each link, since no retransmissions have to be made.

Yes, this is true; anyway suppose this scenario

A----> B ----> C

where:  A --> B and B --> are 800 kbps links
and: A---->C is a 500 kbps link

Suppose we have to send 100 packtes form A to C

if the direct link A---->C is chosen we suppose a 100 packets transmission
while chosing B as router (repeater)  we would expect a 100+100 packets
transmission!
What above is well right using that bandwidht values (6Mb) but with
poor/lossy links we have also to consider the IP datagrams loss at network
layer ---> which will cause TCP retransmits at higher layers (think to
http connection) just based on that links.
For this reason maybe a kind of "bandwidth threshold" can help in
preferring a 500_Kb per link mulit-hop path rather than a 300_Kb link
direct path.

This is a my opinion elektra, no criticism... all what we want is only
give hints and tips in order to improve batman.
Ok?

--
Antonio

