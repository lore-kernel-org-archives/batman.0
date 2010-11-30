Return-Path: <mvanderkolff@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=mAZHrPGYvr_dJYED0NDLv7FBQyDqcJ3jTx5OA@mail.gmail.com>
References: <AANLkTikhncqRxsbRfJRPb0y8oM2uT4sHpQOzONc4hxba@mail.gmail.com>
	<201011301542.45457.lindner_marek@yahoo.de>
	<AANLkTinh3EzmA5=rJLi05wgy+cSXQwVRE4Ri+QBbCUMr@mail.gmail.com>
	<201011301610.46917.lindner_marek@yahoo.de>
	<AANLkTi=mAZHrPGYvr_dJYED0NDLv7FBQyDqcJ3jTx5OA@mail.gmail.com>
Date: Wed, 1 Dec 2010 02:52:37 +1100
Message-ID: <AANLkTimwm8AOvgriOm06r9oNOqu+q7gL+F=hLuvB_6dm@mail.gmail.com>
From: Michael van der Kolff <mvanderkolff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] global mesh
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

They are not theoretical, just not as production hardened as BATMAN.
Which is to say, finding small-time implementations of them isn't too
hard - they do have working code.  But their code runs on top of the
Click routing system, which will never find much acceptance within the
Linux kernel community due to its use of C++ (albeit with exceptions &
other things stripped).  In short, they have working code, but it is a
proof of concept.  No one has actually got a real 125,000 node system
working, but the simulations of the routing protocol do make that
prediction, yes.

"Real world deployments" is always a tricky and nebulous concept.
BATMAN has real world deployments due to Freifunk & other initiatives,
who naturally favour code that has a real chance of being accepted
into the kernel.  Not using C++ is good for kernel acceptance.

But yes, there have been some honours theses written around
small-scale deployments with extensions to do things like hash-based
lookup of names (compute the hash and make the routing protocol stop
when its successor is greater than the hash value, instead of the IPv6
behaviour which is an ICMPv6 response...)

For more information, google Linyphi.  Or, indeed, netsukuku.  But
seriously, the point is mesh networks are an open research topic, and
I should imagine that many more PhDs will come out of this field - but
BATMAN is very much focussed on reduction to practice - making the
current ideas work as best as they can - which is why it is suitable
for the networks it has been deployed into.

Cheers,

Michael

On Wed, Dec 1, 2010 at 2:18 AM, Kosta -- A Human Right
<kosta@ahumanright.org> wrote:
> Are those protocols simply theoretical? Or could they work if someone
> tried them?
>
> -K
>
> On Tue, Nov 30, 2010 at 7:10 AM, Marek Lindner <lindner_marek@yahoo.de> w=
rote:
>> On Tuesday 30 November 2010 15:55:16 Michael van der Kolff wrote:
>>> It is in fact feasible to have thousands of mesh nodes -
>>> http://www.so.in.tum.de/wiki/index.php5/Scalable_Source_Routing gives
>>> a real model for something like that. =C2=A0Linyphi gives a real model =
for
>>> that - embed a MAC address into subnet address, and get routes to your
>>> immediate successor, 2nd node, 4th node, etc, and forward packets to
>>> the node closest numerically to the destination while still being
>>> under it. =C2=A0Of course, Linyphi is hardly production ready - more a
>>> proof of concept.
>>
>> Let me rephrase then: I don't know of any mesh protocol that is being us=
ed in
>> real world deployments and scales up to millions of nodes.
>>
>> If we leave the realm of working implementations I'd like to add Netsuku=
ku to
>> the list of endlessly scalable mesh protocols. I quote from their FAQ:
>>
>> It [Netsukuku] can be used to build a world-wide distributed, fault-tole=
rant,
>> anonymous, and censorship-immune network, fully independent from the Int=
ernet.
>> [..]
>> The number of interconnected nodes can grow endlessly.
>>
>> Cheers,
>> Marek
>>
>
>
>
> --
> http://iamkosta.org
>
