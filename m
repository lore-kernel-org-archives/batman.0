Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4F86F6BF.60406@jst.sm>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
	<CAOaDhSRTgejL5tzAnAx6wBso1sjWn_7bVuT6P1_C1qcVu25McQ@mail.gmail.com>
	<4F86F6BF.60406@jst.sm>
Date: Thu, 12 Apr 2012 19:19:32 +0200
Message-ID: <CAKLmikM+jShmbtBq8X9ygAMACpX6tHBwC+HNmzhSc-8HJzMEGw@mail.gmail.com>
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

On Thu, Apr 12, 2012 at 5:37 PM, Jernej Kos <k@jst.sm> wrote:
> Wouldn't just need something like an announce mechanism so each node
> would add an L3 route to the gateway announcing the said prefix?

One way could be arp proxy. So that border node would pretend to hold
all IPs of subnet behind it and reply with its own MAC address for all
those IPs. Once packets gets there is then routed behind. I have been
playing with this once and it does work.

https://en.wikipedia.org/wiki/Proxy_ARP

> Since from layer 3, the batman mesh looks just like a big LAN, any node
> could simply add a route saying "prefix A via gateway B dev bat0" where
> B is a mesh node known to batman via its L2 identifier, no?

So we would just need some other L3 routing protocol on top of
batman-adv, without any need of knowing the wireless infrastructure,
only to configure dynamically those announcements on all nodes, no? So
that when gateway B appears, that all nodes add its prefix A to their
L3 routing tables?


Mitar
