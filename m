MIME-Version: 1.0
In-Reply-To: <4A00856D.9080209@thewybles.com>
References: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
	<4A00856D.9080209@thewybles.com>
Date: Tue, 5 May 2009 14:53:56 -0400
Message-ID: <bad82a80905051153y14c528c7mc3461a1467824cc9@mail.gmail.com>
From: Arc Riley <arcriley@gmail.com>
Content-Type: multipart/alternative; boundary=0016e644dd2606efcd04692ecdeb
Subject: Re: [B.A.T.M.A.N.] batman-adv use in Manchester NH
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

--0016e644dd2606efcd04692ecdeb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Excellent! Is there a website for your project?


Not yet, in the next two weeks.


Are you fully committed to Batman or still in the evaluation phases?


There's room to be swayed, but batman-adv seems to be the best suited for
our needs right now.  The primary concern is that the layer 2 branch isn't
old enough to guarentee that it'll last - but it's free software so if it
fizzles and is useful, someone will pick it up.


OSPF perhaps? :)


As I understand it, OSPF is designed for layer 3 networks.  There is no
layer 3 routing going on within this network, to layer 3 protocols the
entire mesh appears to be locally accessable.

We really need something that directs users to use the gateway with the
highest TQ.

One method I just thought of; each gateway runs a DHCP server.  When a
broadcast request is received, each gateway announces to the others their TQ
to the requesting node, and after a brief timeout, the gateway with the
highest TQ responds to the requesting node.

This raises a question however.  After reading the protocol document, I do
not understand how the nodes on a network know which node to route frames
which are destined for a MAC not belonging to a node, ie, a standard laptop
connected to the mesh.  The above scenario would require knowing which node
a non-node MAC is connected through.


As a completely unrelated question, how does the batman-adv 0.1 kernel
module currently handle multicast frame routing?

--0016e644dd2606efcd04692ecdeb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">Excellent! Is there a website for your project?</blockquote><=
div>
<br>Not yet, in the next two weeks.<br><br><br></div><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">Are you fully committed to Batman or st=
ill in the evaluation phases?</blockquote>
<div><br>There&#39;s room to be swayed, but batman-adv seems to be the best=
 suited for our needs right now.=C2=A0 The primary concern is that the laye=
r 2 branch isn&#39;t old enough to guarentee that it&#39;ll last - but it&#=
39;s free software so if it fizzles and is useful, someone will pick it up.=
<br>
<br><br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px s=
olid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">OSP=
F perhaps? :)</blockquote><br>As I understand it, OSPF is designed for laye=
r 3 networks.=C2=A0 There is no layer 3 routing going on within this networ=
k, to layer 3 protocols the entire mesh appears to be locally accessable.<b=
r>
</div><br>We really need something that directs users to use the gateway wi=
th the highest TQ.<br><br>One method I just thought of; each gateway runs a=
 DHCP server.=C2=A0 When a broadcast request is received, each gateway anno=
unces to the others their TQ to the requesting node, and after a brief time=
out, the gateway with the highest TQ responds to the requesting node.<br>
<br>This raises a question however.=C2=A0 After reading the protocol docume=
nt, I do not understand how the nodes on a network know which node to route=
 frames which are destined for a MAC not belonging to a node, ie, a standar=
d laptop connected to the mesh.=C2=A0 The above scenario would require know=
ing which node a non-node MAC is connected through.<br>
<br><br>As a completely unrelated question, how does the batman-adv 0.1 ker=
nel module currently handle multicast frame routing?<br>

--0016e644dd2606efcd04692ecdeb--
