Return-Path: <clownix@clownix.net>
Message-ID: <dbe472126b41ec4031657c0e37d8a665.squirrel@clownix.net>
In-Reply-To: <4E5D69E3.30403@robotech.de>
References: <4E5D69E3.30403@robotech.de>
Date: Tue, 30 Aug 2011 18:07:09 -0500
From: clownix@clownix.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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

Es-tu Tobias de tai?

> Hi all,
>
> i have setup a mesh-network with batman-adv running on about 10 Foneras
> and 4 TP-Link on OpenWRT.
>
> At first everything seemed to work. A node on the one end could ping a
> node on the other end over the mesh-network. The ping was hopping from
> node to node as expected.
>
> But sometimes some paths do not work anymore.
>
> Some nodes can only reach their direct neighbors via a "normal ping". A
> ping to a node via one hop does not work. A "batctl ping" does work!
>
> This only happens to parts of the network and is not permanent. If i
> wait it will recover, but then the problem appears at another node.
>
> dmesg or the syslog does not report any errors.
>
> Can anyone give me a hint where to look?
>
> Tobias
>
>
>
>
>

