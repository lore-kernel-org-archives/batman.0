Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4F86F6BF.60406@jst.sm>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com> <20120412120002.GE8528@ritirata.org>
	<CAKLmikOz3az4HWYA4XWsq+kUBx+vF9fuYQS+jjkU=9ibDxPy3A@mail.gmail.com>
	<CAOaDhSRTgejL5tzAnAx6wBso1sjWn_7bVuT6P1_C1qcVu25McQ@mail.gmail.com>
	<4F86F6BF.60406@jst.sm>
Date: Thu, 12 Apr 2012 23:08:48 +0200
Message-ID: <CAKLmikNtFyx9tDnOAzkMuEmSOOnhVHaLvKpf8q68Fd8qes2XYA@mail.gmail.com>
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
> Since from layer 3, the batman mesh looks just like a big LAN, any node
> could simply add a route saying "prefix A via gateway B dev bat0" where
> B is a mesh node known to batman via its L2 identifier, no?

So I have almost convinced Kostko that we could switch to Batman, but
he does not want to run multiple routing daemons on nodes. So could
Batman support announcing also L3 prefixes? For example, that in the
node configuration you could define that that node (let say it has IP
10.10.10.10) should announce also some L3 subnet. Like
192.168.42.0/24. And when that node would be reachable from other
node, that other node would run:

ip route add prefix 192.168.42.0/24 via gateway 10.10.10.10 dev bat0

Doable? Because to run additional routing daemon just to rediscover
which nodes are around and announce things ... when Batman already
knows all this ...


Mitar
