Return-Path: <hagen@jauu.net>
Date: Mon, 28 Jun 2010 00:27:06 +0200
From: Hagen Paul Pfeifer <hagen@jauu.net>
Message-ID: <20100627222706.GC8285@nuttenaction>
References: <201006260214.06662.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <201006260214.06662.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Reviewing batman-adv for net/
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.net, "David S. Miller" <davem@davemloft.net>

* Sven Eckelmann | 2010-06-26 02:14:05 [+0200]:

>batman-adv is a meshing protocol currently in drivers/staging/batman-adv. =
We=20
>asked GregKH recently [1] if he thinks that it is ok to send a patch to yo=
u=20
>for review. He acknowledged that request and now we would like to ask you =
to=20
>review it.
>
>I will send a patch referencing this mail. I hope you find time to send us=
=20
>your opinion and ideas.

Hello Sven,

o Where are the advantages of BATMAN compared to OLSR? OLSR is standardized
  by the IETF which is a great advantage compared to BATMAN. 20 byte IPv4
	header respective 60 byte IPv6 header savings? Network protocol neutrality?
	Where are the differences between BATMAN and 802.11s? Where are the
	similarities? See commit 37c5798968d0ce4 of 802.11s

o Are there any publications which describe the protocol behavior in detail?
  I assume it is a pro-active protocol - similar to standard BATMAN -
	but what about neighbor discovery, TC, HNA and the like? What about multic=
ast
	transport? It is difficult to rate the patchset if no one knowns what the
	intended behavior is.

o The major code is twisted about bookkeeping stuff, configuration aspects =
and
  so on. The minor codebase is about protocol processing. What about a
	generalized architecture and a userspace implementation of the protocol? A=
nd
	communication via netlink sockets.


Cheers, Hagen
