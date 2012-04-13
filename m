Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20120413081501.GJ7664@lunn.ch>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
	<CAOaDhSRTgejL5tzAnAx6wBso1sjWn_7bVuT6P1_C1qcVu25McQ@mail.gmail.com>
	<4F86F6BF.60406@jst.sm>
	<CAKLmikNtFyx9tDnOAzkMuEmSOOnhVHaLvKpf8q68Fd8qes2XYA@mail.gmail.com>
	<20120413055947.GH7664@lunn.ch>
	<CAKLmikNJMzdMSgCkHjf5xNWM0ibEWW+W9BPrskJjaL0b_8VK4g@mail.gmail.com>
	<20120413081501.GJ7664@lunn.ch>
Date: Fri, 13 Apr 2012 10:41:14 +0200
Message-ID: <CAKLmikNt0M4+MEQRsDH-fdnLD664+0G1pCcGKyCNWKim-6ro7Q@mail.gmail.com>
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

On Fri, Apr 13, 2012 at 10:15 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> How many subnets do you think you will have? Are they all using
> classful networks or classless network?

Probably not much. At most 10 % of nodes would announce their home
subnets too. But we should support also classless networks.

> quagga is a well used suite of routing protocols.
> http://www.nongnu.org/quagga/

If I understand correctly, this would allow us also easier peering
with other networks as quagga supports also redistribution of routes
and so on. So if we decide for OSPF, it will be easy also to setup BGP
on border nodes within the single daemon, no?

How CPU and memory heavy it is to run it on consumer routers like
TP-links and so on? Probably depends on number of routes and not on
itself? But is there a big penalty of running it on all nodes?


Mitar
