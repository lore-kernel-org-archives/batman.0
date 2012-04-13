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
Date: Fri, 13 Apr 2012 09:58:26 +0200
Message-ID: <CAKLmikNJMzdMSgCkHjf5xNWM0ibEWW+W9BPrskJjaL0b_8VK4g@mail.gmail.com>
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
Cc: Mitar <mitar@tnode.com>

Hi!

On Fri, Apr 13, 2012 at 7:59 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> This comes back to:
>
> =C2=A0 =C2=A0 You need, in your head, a clear separation between L3 and L=
2.

:-)

OK, maybe I am getting a bit of hold on this. :-)

OK, so if we would like to provide a way for all nodes to also
announce their L3 subnets which are maybe behind them, we should run
additional L3 routing protocol between them so that they can exchange
information about those subnets and configure routes accordingly.
Which routing protocol are you proposing for such task? If I
understand it can be a really simple one, checking just when a node is
accessible and setting its announcements on all other nodes. There is
no need to think about link quality or anything else. If node is
accessible, set routes for its announced subnets to it. OK, one need
we would like is that it provides some routing filtering capabilities.
So that we could for example forbid to announce anything from
192.168/16. How does such protocol determine node availability?


Mitar
