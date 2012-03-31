Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHD-aqLOLFq5LOYa94BffAzzD2uMSeKOtwaa_PG1+d8E2vrriw@mail.gmail.com>
References: <CAA_JP8X+vPn39-QK-zPjdd1Mtn4PCTjigpV4fFM6sTVUmBiLTg@mail.gmail.com>
	<CAHD-aqKN_+5fwg65Udpr6jxt5tFsu5XXsMWkk75ujPK3bJcqJw@mail.gmail.com>
	<CAA_JP8UxNW18xWZe62ySY=H27HDnZY1YBQV-7ZGUHYnSS-ZSHw@mail.gmail.com>
	<CAHD-aqK_CGbc8u5GuEBJyFzrk2rTHHTw=bAiWjFafAW9xOqWiw@mail.gmail.com>
	<BBFA727B-FECF-4C04-BCD1-3C76CBD010DE@gmail.com>
	<CAHD-aqLOLFq5LOYa94BffAzzD2uMSeKOtwaa_PG1+d8E2vrriw@mail.gmail.com>
Date: Sat, 31 Mar 2012 15:03:26 -0600
Message-ID: <CAA_JP8XtADXO=J6rKdQNTz3vGeLr0+a1fJSsyS9Lb=-zttWgug@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] link alternation when radios are not on
	batman-adv router?
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

On Sat, Mar 31, 2012 at 12:11 PM, Guido Iribarren
<guidoiribarren@buenosaireslibre.org> wrote:
> On Sat, Mar 31, 2012 at 12:45 PM, Dan Denson <dandenson@gmail.com> wrote:
>> =A0I think I understand. Basically, so long as two interfaces both have =
a path the to destination of acceptable quality, it will send the packets o=
ut the interface that did not receive the packets. Hop count doesn't have a=
 direct effect, we don't really care about hop count, only about link quali=
ty.
>>
>> Is that the case?
>>
>>
>> If hop count doesn't really matter, how do I identify my high quality, h=
igh capacity backhauls?
>
> In batworld, by their high TQ (=3D AFAIU lack of packet loss to destinati=
on.)
> no capacity involved in the calculations.
>
> (but devs might correct me if i'm being too shortsighted!)

according to the docs, capacity is not used in the calculation.  It is
assumed that lowest TQ is always the best route.  Hop count adds a
default '10' to the TQ which is adjustable.  I figure this means that
I can give a supernode a lower hop cost than the default 10 which
should slide the TQ in favor of using this node as the optimal path.

I also infer that this means that picostations running batman-adv that
are part of the supernode 'cluster' are going to also add a hop
penalty to the TQ.  From what I can tell though, link aggregation only
cares if a interaces/links have an acceptable TQ, not an equal TQ,
though I suspect that two picos in a supernode config would end up
providing the same hop count and similar TQ anyway, assuming solid
wireless links.
