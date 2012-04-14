Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4F88E056.4080208@codigosur.org>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
	<CAOaDhSRTgejL5tzAnAx6wBso1sjWn_7bVuT6P1_C1qcVu25McQ@mail.gmail.com>
	<4F86F6BF.60406@jst.sm>
	<CAKLmikNtFyx9tDnOAzkMuEmSOOnhVHaLvKpf8q68Fd8qes2XYA@mail.gmail.com>
	<20120413055947.GH7664@lunn.ch>
	<CAKLmikNJMzdMSgCkHjf5xNWM0ibEWW+W9BPrskJjaL0b_8VK4g@mail.gmail.com>
	<20120413081501.GJ7664@lunn.ch>
	<CAKLmikNt0M4+MEQRsDH-fdnLD664+0G1pCcGKyCNWKim-6ro7Q@mail.gmail.com>
	<4F88E056.4080208@codigosur.org>
Date: Sat, 14 Apr 2012 11:06:01 +0200
Message-ID: <CAKLmikNpsoGBKd4j=B8b5XejWBVeHF0zSYQAr5=DvzpZQyCOMQ@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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

Hi!

2012/4/14 Nicol=C3=A1s Ech=C3=A1niz <nicoechaniz@codigosur.org>:
> I'm curious as to why those nodes wouldn't use the same IP address space
> as the net if they will be announcing their routes to the mesh anyway.

Probably they will use the same IP address space, but we want to route
those subnets not bridge them. This is the main difference.

> One thing to be aware of is that when a home network (on a different
> subnet) is connected to the batman mesh you get some side-effects, like
> for example an in-house router responding to DHCP requests...

If we do routing between home network and mesh network, no.

Also, our routers will not run DHCP itself. (Probably DHCP will be run
inside home networks. But as I said, we would like to only route
there, not bridge.)

> One other suggestion, for VPN is to take a look at Tinc; it has a
> routing (or router?) mode which might be useful in your case.

No, it is an user-space daemon. Context switches between user-space
and kernel-space kills much of the performance on those cheap routers.
We are currently using OpenVPN and I doubt Tinc will improve much in
this aspect. Or am I mistaken?


Mitar
