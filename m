Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120413092447.GL7664@lunn.ch>
References: <4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
	<CAOaDhSRTgejL5tzAnAx6wBso1sjWn_7bVuT6P1_C1qcVu25McQ@mail.gmail.com>
	<4F86F6BF.60406@jst.sm>
	<CAKLmikNtFyx9tDnOAzkMuEmSOOnhVHaLvKpf8q68Fd8qes2XYA@mail.gmail.com>
	<20120413055947.GH7664@lunn.ch>
	<CAKLmikNJMzdMSgCkHjf5xNWM0ibEWW+W9BPrskJjaL0b_8VK4g@mail.gmail.com>
	<20120413081501.GJ7664@lunn.ch>
	<CAKLmikNt0M4+MEQRsDH-fdnLD664+0G1pCcGKyCNWKim-6ro7Q@mail.gmail.com>
	<20120413092447.GL7664@lunn.ch>
Date: Fri, 13 Apr 2012 15:24:18 +0200
Message-ID: <CAKLmikOpJ0O3uXwEqGvjY-Y=P1HqjZGuBjG42+c_kDYiRzoevw@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On Fri, Apr 13, 2012 at 11:24 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> Yes, quagga has BGP, but depending on your organizational structure,
> it might be easier to use OSPF on your peering links. It depends on
> your peers. If its The Internet, then you probably have little choice,
> you need BGP. However, if your peer is another mesh network, you can
> decide for your self what routing protocol to use.

OK, but quagga can run multiple protocols at the same time? Like OSPF
into one direction and BGP into another? (Just making sure if I
understand correctly.)

> I've used quagga on Gateworks Cambria devices, with a Xscale CPU,
> 667MHz, 128Mbytes RAM. These tend to have more RAM than typical
> consumer devices, but i've no idea how much is actually consumed.

We would like to run that on Foneras. Does anybody have experience
with this? So we are running OLSR and it works good. If we switch to
quagga and OSPF and same network, will we have more or less CPU usage?


Mitar
