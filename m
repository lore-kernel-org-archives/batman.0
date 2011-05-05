Return-Path: <ed.okerson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201105051744.40330.lindner_marek@yahoo.de>
References: <BANLkTikaMjY9t=0gDQCn0xUzz+c4YPz7gQ@mail.gmail.com>
	<201105051744.40330.lindner_marek@yahoo.de>
Date: Thu, 5 May 2011 12:25:58 -0500
Message-ID: <BANLkTin0ge+SNpLr3wjTibT303PZ8SRbGw@mail.gmail.com>
From: Ed Okerson <ed.okerson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Routing decisions
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

On Thu, May 5, 2011 at 10:44 AM, Marek Lindner <lindner_marek@yahoo.de> wro=
te:
>
> Hi,
>
>> We are evaluating using Batman in an environment where there could be
>> 200-300 devices in a single building. =A0We started out setting up 10
>> devices in our office to figure out how everything works and do some
>> throughput testing. =A0We have noticed that the routing decisions always
>> send the packet to the node towards the destination with the highest
>> signal strength. =A0This causes the packet to always traverse the
>> network with the maximum possible number of hops, which causes
>> performance to degrade quickly. =A0Is it possible to use a different
>> routing algorithm? =A0It would seem that sending to the node closest to
>> the destination that the source node can still communicate with
>> directly would minimize the number of hops.
>
> if you wish to minimize the number of hops you have to increase the hop
> penalty. Check the "hop penalty" section here:
> http://www.open-mesh.org/wiki/batman-adv/Tweaking
>

That seems to indicate that it is a per node setting, i.e. "using this
node will incur a penalty of x".  That is also not the desired
behavior.  For our installation all nodes are in a fixed location, so
using a particular node as a next hop in the route may incur a penalty
for one source node, but not another.  This should be dynamically
determined for each route from each source to each destination to
minimize hops.

Thanks
Ed Okerson
