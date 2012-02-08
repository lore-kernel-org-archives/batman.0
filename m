Return-Path: <christian@solvare.se>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Apple Message framework v1251.1)
From: Christian Huldt <christian@solvare.se>
In-Reply-To: <20120208151317.GD21844@ritirata.org>
Date: Wed, 8 Feb 2012 16:35:29 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <D11B94FE-8D3B-4FEF-B361-7B4E6435AA01@solvare.se>
References: <73D963E8-129F-4DA1-B521-38640393D3CE@solvare.se>
	<20120208132637.GA21844@ritirata.org>
	<E6C194B0-C542-457D-98AB-A7860E22DE84@solvare.se>
	<20120208151317.GD21844@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] multi path TCP
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

Hello Antonio, and thanks both for your explanation as well as your =
question that made me understand things better.

8 feb 2012 kl. 16:13 skrev Antonio Quartulli:

> Hello Christian and thank you for your explanation,
>=20
> On Wed, Feb 08, 2012 at 03:53:22PM +0100, Christian Huldt wrote:
>>=20
>> 8 feb 2012 kl. 14:26 skrev Antonio Quartulli:
>>=20
>>> Hello Christian,
>>>=20
>>> On Wed, Feb 08, 2012 at 12:29:52PM +0100, Christian Huldt wrote:
>>>> As a complete newbie to batman, please excuse if this question is =
unusually stupid, but I just got home after getting update on the mptcp =
kernel module http://mptcp.info.ucl.ac.be/ and it seems to me that =
running mptcp over a batman mesh could potentially be quite nice. It =
that correct or am I just being ignorant?
>>>>=20
>>>=20
>>> Before answering your question, I would like to read and understand =
a
>>> bit more about mptcp, but actually I couldn't find any resource =
explaining the
>>> concept behind it an how it is supposed to work. The only document =
I've been
>>> able to find is S=E9bastien's Thesis...but I would rather prefer a =
lighter reading
>>> first :-)
>>>=20
>>>=20
>>> Anyway, is it somehow similar to ip multihoming with load balancing?
>>=20
>> I am unfortunately not able to say whether that is the case (yet=85), =
I saw a demo and (think I) understood at least parts of the talk.
>> This is my limited understanding:
>> This implementation of mptcp works by creating a virtual interface =
bound to two (or more?) interfaces and traffic over that virtual =
interface is by the mptcp layer sent packet by packet to one of the =
bound interfaces.  - I am assuming that it is using the tcp acks to =
optimize which interface gets more packets -=20
>>=20
>=20
> It sounds like "bonding at the TCP layer" (let me pass the term).
>=20
>=20
>> The receiving host has to be mptcp capable as well in order to bring =
the two (or more?) connections together to one.
>>=20
>> One of the benefits is that except for the two hosts talking, no one =
needs to be aware of the "multi path nature" as it is just two normal =
tcp connections.
>>=20
>> I think that it could be useful (or mayhem) in a mesh network though =
I would believe that where will be complications.
>=20
> Well, assuming you know how batman handles clients, the only way to =
exploit such
> "multi-path TCP" is to connect the two (or more) involved interfaces =
of the client to two
> (or more) different nodes. If not, all the packets will follow the =
same path in the mesh
> network anyway.

Maybe one could do something similar with routes rather than interfaces? =
That is, by sending packets to different other nodes?
But I think that could complicate things and I should probably dig =
deeper into batman-adv before coming up with more ideas...

> By the way, I'd say that from the batman-adv point of view using mptcp =
is the
> same as ethernet bonding. (Please correct me if I made any mistakes)

I think that is correct.=
