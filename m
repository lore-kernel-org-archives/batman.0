Return-Path: <don@dis.org.nz>
MIME-Version: 1.0
In-Reply-To: <200911092239.01984.lindner_marek@yahoo.de>
References: <200911082144.49637.lindner_marek@yahoo.de>
	<591bc9930911090043mf62cd17tac8033d316002a18@mail.gmail.com>
	<200911092239.01984.lindner_marek@yahoo.de>
Date: Wed, 11 Nov 2009 16:17:22 +1300
Message-ID: <591bc9930911101917j149b5ba5j666ddded7a0ceeb0@mail.gmail.com>
From: Donald Gordon <don@dis.org.nz>
Content-Type: multipart/alternative; boundary=0016e64ce5b67725d104780fdd10
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 released
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

--0016e64ce5b67725d104780fdd10
Content-Type: text/plain; charset=ISO-8859-1

One implementation possibility I was thinking of was adding yet another
ethernet device that sat like a proxy in front of bat0.  It would fragment
transmitted frames larger than the bat0 MTU (changing the ethernet frame
type), and reassemble recieved frames.  This would push the load of frame
fragmentation to the edge of the network, and shouldn't add too much
overhead.  Does that sound like a reasonable way forward?  And if so, does
anyone have any pointers on how to develop fake ethernet drivers?

With the frame-combining that batman-adv now does, those extra frame
fragments would be good candidates for combining to cut down on wifi
overhead.

With resepect to the motivation for allowing 1500 MTU frames over a 1500 MTU
intermediate network, I guess my grand vision is to borrow bits of network
that are already there to get the mesh extended further.  Hopping through a
citywide hotspot network (conveniently all bridged together), borrowing
existing ethernet segments in buildings, that sort of thing.  Which means
I'm also keen on some sort of integrated way to tunnel batman packets over
IP without the overhead of passing them to userspace through a tun/tap but I
guess that'll have to wait :-)

donald

On Tue, Nov 10, 2009 at 3:39 AM, Marek Lindner <lindner_marek@yahoo.de>wrote:

> Nevertheless, it might be neat to have fragmentation as a fallback
> mechanism.
> Be sure we review and submit your code as soon as it is available.  :)
>
> Regards,
> Marek
>
>

--0016e64ce5b67725d104780fdd10
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

One implementation possibility I was thinking of was adding yet another eth=
ernet device that sat like a proxy in front of bat0.=A0 It would fragment t=
ransmitted frames larger than the bat0 MTU (changing the ethernet frame typ=
e), and reassemble recieved frames.=A0 This would push the load of frame fr=
agmentation to the edge of the network, and shouldn&#39;t add too much over=
head.=A0 Does that sound like a reasonable way forward?=A0 And if so, does =
anyone have any pointers on how to develop fake ethernet drivers?<br>
<br>With the frame-combining that batman-adv now does, those extra frame fr=
agments would be good candidates for combining to cut down on wifi overhead=
.<br><br>With resepect to the motivation for allowing 1500 MTU frames over =
a 1500 MTU intermediate network, I guess my grand vision is to borrow bits =
of network that are already there to get the mesh extended further.=A0 Hopp=
ing through a citywide hotspot network (conveniently all bridged together),=
 borrowing existing ethernet segments in buildings, that sort of thing.=A0 =
Which means I&#39;m also keen on some sort of integrated way to tunnel batm=
an packets over IP without the overhead of passing them to userspace throug=
h a tun/tap but I guess that&#39;ll have to wait :-)<br>
<br>donald<br><br><div class=3D"gmail_quote">On Tue, Nov 10, 2009 at 3:39 A=
M, Marek Lindner <span dir=3D"ltr">&lt;<a href=3D"mailto:lindner_marek@yaho=
o.de">lindner_marek@yahoo.de</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
t 0pt 0pt 0.8ex; padding-left: 1ex;">
Nevertheless, it might be neat to have fragmentation as a fallback mechanis=
m.<br>
Be sure we review and submit your code as soon as it is available. =A0:)<br=
>
<br>
Regards,<br>
<font color=3D"#888888">Marek<br>
</font><div><div></div><br></div></blockquote></div>

--0016e64ce5b67725d104780fdd10--
