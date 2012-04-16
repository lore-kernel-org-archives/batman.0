Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120413055947.GH7664@lunn.ch>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
	<CAOaDhSRTgejL5tzAnAx6wBso1sjWn_7bVuT6P1_C1qcVu25McQ@mail.gmail.com>
	<4F86F6BF.60406@jst.sm>
	<CAKLmikNtFyx9tDnOAzkMuEmSOOnhVHaLvKpf8q68Fd8qes2XYA@mail.gmail.com>
	<20120413055947.GH7664@lunn.ch>
Date: Mon, 16 Apr 2012 12:25:42 +0200
Message-ID: <CAKLmikPJBmk=Xoom0a1D2OFfx6o8OtSk7D4PdT3TDXDx9iyO1A@mail.gmail.com>
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
Cc: Jernej Kos <kostko@unimatrix-one.org>

Hi!

I have a feature request.

On Fri, Apr 13, 2012 at 7:59 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> 2) BATMAN is not a daemon. Its a kernel module. Hence it cannot play
> =C2=A0 around with routes, even if it wanted to. Also, adding/removing
> =C2=A0 routes is policy, and the Linux/Unix view of the world is that use=
r
> =C2=A0 space is responsible for deciding policy.

I have problems with an idea of running another routing protocol on
top of Batman. I think this is creates unnecessary additional
bandwidth consumption:
1) routing protocol has to find which nodes are reachable
2) routing protocol has to exchange information about announced routes

But 1) Batman already knows. So we could have a netlink protocol where
user-land daemon could subscribe to events and get for example two
events: "node reachable" and "node unreachable". Then it can do some
user-land mingling. :-)

And for 2), Batman could allow a general key/value additional
information to be announced by nodes. From its point of view that
information can be anything.

And the in our case we could add to each node information which IP it
has and which subnets it has behind. This information would then be
announced to other nodes. And then we could run a simple daemon on
other nodes which would listen to netlink events and once  a node is
reachable, read that information and setup necessary routes.

I like the idea because it allows general hooks into Batman
reachability awareness. So no duplication of this is necessary. Also,
Batman already exchanges information, so we could just allow custom
additional information from nodes to be exchanged. Maybe even stored
in that DHT you have.


Mitar
