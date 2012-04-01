Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <4F77AFDD.7050909@codigosur.org>
Date: Sat, 31 Mar 2012 22:31:09 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <CAA_JP8X+vPn39-QK-zPjdd1Mtn4PCTjigpV4fFM6sTVUmBiLTg@mail.gmail.com>
	<CAHD-aqKN_+5fwg65Udpr6jxt5tFsu5XXsMWkk75ujPK3bJcqJw@mail.gmail.com>
	<CAA_JP8UxNW18xWZe62ySY=H27HDnZY1YBQV-7ZGUHYnSS-ZSHw@mail.gmail.com>
	<CAHD-aqK_CGbc8u5GuEBJyFzrk2rTHHTw=bAiWjFafAW9xOqWiw@mail.gmail.com>
	<BBFA727B-FECF-4C04-BCD1-3C76CBD010DE@gmail.com>
	<CAHD-aqLOLFq5LOYa94BffAzzD2uMSeKOtwaa_PG1+d8E2vrriw@mail.gmail.com>
	<CAA_JP8XtADXO=J6rKdQNTz3vGeLr0+a1fJSsyS9Lb=-zttWgug@mail.gmail.com>
In-Reply-To: <CAA_JP8XtADXO=J6rKdQNTz3vGeLr0+a1fJSsyS9Lb=-zttWgug@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
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

On 03/31/2012 06:03 PM, dan wrote:
> On Sat, Mar 31, 2012 at 12:11 PM, Guido Iribarren
> <guidoiribarren@buenosaireslibre.org> wrote:
>> On Sat, Mar 31, 2012 at 12:45 PM, Dan Denson <dandenson@gmail.com> wrote:
>>>  I think I understand. Basically, so long as two interfaces both have a=
 path the to destination of acceptable quality, it will send the packets ou=
t the interface that did not receive the packets. Hop count doesn't have a =
direct effect, we don't really care about hop count, only about link qualit=
y.
>>>
>>> Is that the case?
>>>
>>>
>>> If hop count doesn't really matter, how do I identify my high quality, =
high capacity backhauls?
>>
>> In batworld, by their high TQ (=3D AFAIU lack of packet loss to destinat=
ion.)
>> no capacity involved in the calculations.
>>
>> (but devs might correct me if i'm being too shortsighted!)
>=20
> according to the docs, capacity is not used in the calculation.  It is
> assumed that lowest TQ is always the best route.  Hop count adds a
> default '10' to the TQ which is adjustable.  I figure this means that
> I can give a supernode a lower hop cost than the default 10 which
> should slide the TQ in favor of using this node as the optimal path.
>=20
> I also infer that this means that picostations running batman-adv that
> are part of the supernode 'cluster' are going to also add a hop
> penalty to the TQ.  From what I can tell though, link aggregation only
> cares if a interaces/links have an acceptable TQ, not an equal TQ,
> though I suspect that two picos in a supernode config would end up
> providing the same hop count and similar TQ anyway, assuming solid
> wireless links.

it's a tricky task to try and convince batman-adv to favour certain routes.

Our strategy in QuintanaLibre has been to lower the hop penalty but also
to increase multicast rate where necessary.

This effectively "invisibilizes" some links for batman.

You should use this with care, mainly if you are playing with it
remotely because you may be left out of a portion of your network.

We have reduced hop_penalty to zero on certain "preferred" nodes and
also increased mcast_rate where necessary.

Your mcast_rate can actually be heterogeneous across the network.

For example, we have an Ubiquiti BulletM2 with a 14db panel antenna
which is "seen" even by the furthest node, which establishes a low rate
link that has low throughput but looses very few packets, so batman
"thinks" it's actually a good route when in practice it's not.

So we set the Bullet mcast_rate high like so:

config 'wifi-iface'
	option 'device' 'radio0'
	option 'mcast_rate' '54000'
        ...

and then only those nodes than can establish a really good link to the
Bullet will see it as a valid route while others will ignore it.


It took a lot of time to find out this subtleties and we don't even know
if this is the "canonical" method but it does work very well to discard
undesired low rate routes.

In your setup, I think you could increase hop penalty for your
picostations, lower the hop penalty for your supernodes and also set
their mcast_rate high, so that picostations won't choose to route
directly to a far supernode but rather send traffic to their nearest
supernode which will have a solid route to the next one...  that is if I
correctly understood what you are trying to accomplish.



Please share your findings on these matters, as we may all profit from
each other's experimentation work!


Cheers,
NicoEch=E1niz





