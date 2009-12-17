Return-Path: <Eric.Conner@QinetiQ-NA.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Dec 2009 08:09:28 -0500
Message-ID: <94CAE17FD1DB4640BF8FF28D61FDFA8A22BF3B@RESQNAOEX01.qnao.net>
In-Reply-To: <20091216232502.GA27802@pandem0nium>
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A22BEF4@RESQNAOEX01.qnao.net>
	<20091216232502.GA27802@pandem0nium>
From: "Conner, Eric" <Eric.Conner@QinetiQ-NA.com>
Subject: Re: [B.A.T.M.A.N.] [BULK]  Re:  required network to run
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

Simon

thanks for the insight, and actually that is what I originally thought
that  a mesh routing protocol would do for me.  But my question still
remains, how do I configure my linux box so that it uses batmand to
discover the other computers that aren't part of the network?=20

batmand tells me it wants an active network interface to attach to (like
wlan0, or eth1).  But now I have a chicken and egg problem.  I can't
discover other nodes with the mesh routing protocol because I have no
active network interface, but I need a network interface to find other
nodes to connect to...

I know I am still missing some key ingredient.  I guess the important
thing is just how do you configure the linux box to auto-discover a
network, or moreover how do I configure batmand to auto-discover a
network?

Thanks
Eric


=20

-----Original Message-----
From: b.a.t.m.a.n-bounces@lists.open-mesh.net
[mailto:b.a.t.m.a.n-bounces@lists.open-mesh.net] On Behalf Of Simon
Wunderlich
Sent: Wednesday, December 16, 2009 6:25 PM
To: The list for a Better Approach To Mobile Ad-hoc Networking
Subject: [BULK] Re: [B.A.T.M.A.N.] required network to run
Importance: Low

Hello Eric,

the basic idea of meshing in general is: the destination nodes are=20
probably not in the coverage area of your radio, but you still want=20
to talk to these nodes. For example, imagine a city network where all=20
nodes are connected to each other: You wifi cards signal is only strong=20
enough for the next "neighbor", so you pass the traffic to the next=20
neighbor, which will foward it again until it has reached your
destination.

This means you don't "see" all nodes in a network, and you need a=20
mesh routing program like batman to discover other nodes and find=20
correct routes to them via other nodes.

If you have all nodes in one little room, you don't need a routing
daemon,
of course. :)

best regards,
	Simon

On Wed, Dec 16, 2009 at 04:30:51PM -0500, Conner, Eric wrote:
> I am new to ad-hoc mobile networking, and have a few questions.  I am
> just a little confused as to where batman fits in. Why do I need an
> active network to attach the batmand to?  If I'm in a network can't I
> see all the other nodes already?  What is batman buying for me if I
have
> to create my own ad-hoc network?  If I don't have to create my own
> ad-hoc network, how do I set up my linux boxes so that they have an
> active network that will discover the nodes and allow the batmand to
> run?
>=20
> =20
>=20
> Thanks for your help
> Eric
>=20
> =20
>=20
> =20
>=20

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n

