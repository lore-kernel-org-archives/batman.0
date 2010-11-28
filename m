Return-Path: <hlabishik@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTimR7VU95r3C-=C9rn5ftZahKkNTu3-cU-Vft+VZ@mail.gmail.com>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTimR7VU95r3C-=C9rn5ftZahKkNTu3-cU-Vft+VZ@mail.gmail.com>
Date: Mon, 29 Nov 2010 00:01:38 +0200
Message-ID: <AANLkTikZJn5T7gEc_REH_vyEwhKhTcsqLRdq8tX0OdF8@mail.gmail.com>
From: hlabishi kobo <hlabishik@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Fwd: BATMAN routing
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
To: b.a.t.m.a.n@lists.open-mesh.org

---------- Forwarded message ----------
From: hlabishi kobo <hlabishik@gmail.com>
Date: Sun, 28 Nov 2010 22:06:01 +0200
Subject: Fwd: BATMAN routing
To: lindner_marek@yahoo.de

Hi

Thank you very much for your reply. The reason why i sent this to you and
your colleague is that i have tried the mail list before and all my post
kept on being returned, i used this address
b.a.t.m.a.n-owner@lists.open-mesh.org. I would really appreciate it if this
can reach the mailing list public (i will keep on trying). i will send you =
a
follow up on the  full explanation of the concept like you requested.

Regards
Hlabishi
---------- Forwarded message ----------
From: <b.a.t.m.a.n-owner@lists.open-mesh.org>
Date: Sat, Nov 27, 2010 at 12:58 AM
Subject: Fwd: BATMAN routing
To: hlabishik@gmail.com


Message rejected by filter rule match



---------- Forwarded message ----------
From: hlabishi kobo <hlabishik@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sat, 27 Nov 2010 00:58:09 +0200
Subject: Fwd: BATMAN routing


---------- Forwarded message ----------
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, Nov 26, 2010 at 5:23 PM
Subject: Re: BATMAN routing
To: hlabishi kobo <hlabishik@gmail.com>, Linus L=FCssing <
linus.luessing@web.de>
Cc: siwu@hrz.tu-chemnitz.de



Hi,

welcome to the project! :-)

> Firstly my apologies for sending this email to your personal email. My
name
> is Hlabishi Isaac Kobo at the, an Msc computer science student at the
> University of the Western Cape in South Africa, I am doing a research on
> routing in a hybrid (combination of static and mobile dynamic routers)
> mesh.

I don't see a good reason to apologize, just wondering why you are not
sending
this mail to the public list ?


> I want to use the mesh potatoes as well as the batphone (android
> version of batman) to create a mesh model.

What is the "batphone" ? A project name or a nick name you invented ? :-)

Note: Various tests have shown that running a mobile device
(smartphone/tablet/etc) in adhoc mode plus running a mesh protocol on top i=
s
a
battery killer, hence not practical in real world scenarios (in addition of
the hassle to install and configure the mesh software on each and every
device). This was one of the main reasons to start developing batman-adv as
it
allows mobile devices to take advantage of the mesh (e.g. roaming) without
having to run the mesh on the device itself.

You might be aware of this - I am just mentioning it because many people ar=
e
not.


> First we say the recently received OGMs will give a clear indication on
the
> reliability on the link, so we give the recently received OGMs from the
> sliding window a priority in deciding the best next hop link towards a
> destination. We want to count and add the indexes were an OGM was recorde=
d
> in an interval (seconds), (hence the recently received OGM will have more
> weight). At the end the link with more recent OGMs will have more weight
> and hence become the current best link.

This is a good idea. We are in the process of redesigning the current
protocol
and welcome any input. Giving older OGMs less "weight" was also one of the
ideas we had. Would you mind explaining your concept in greater detail ?


> I went through the source code so many times and I got few questions abou=
t
> this:

Are we talking about the batman daemon source code or the batman-adv kernel
module ? All my answers will refer to the kernel module as this is the plac=
e
where most of the development is going on at the moment.


> 1. What structure is used to keep track of the sliding window?  If its th=
e
> has how does it get updated based on the sliding packet range?

Each "struct orig_node" has a bitarray to keep track of its own seqnos
repeated by its neighbors (bcast_own) and each "struct neigh_node" having a
bitarray for its own OGMs (real_bits).


> 2. How are the OGM's recorded, is in a form of binary where 1 will
> represent the received OGM and 0 otherwise?

Correct.


> 3. I looked in the source and still not sure of where the ranking
decisions
> are made, can you enlighten me on that?

You mean which function changes the route when a better neighbor was found =
?
That would be update_orig() in routing.c.


> On the second approach we want to use mac layer stats to estimate the
> signal strength and probably the congestion rate of the top N ranked
links.
> We acknowledge the fact that usually links with lower signal strength wil=
l
> loose more OGM's which results in an automatic low rank, however in a
> frequently changing topology, current signal strength is crucial. We plan
> to use SNR or RSSI in this case.

The concept is known since a while but nobody has implemented it so far
because its implementation is fairly complex. Do you have an idea how it
should work in the end ?


> 1. How can i get the RSSI/LQI of th neighbor links?

I don't get this question. You intend to use RSSI but you don't know how ?


> I would really appreciate your opinions and advices in this regard more
> specially how to go about implementing changes in BATMAN protocol.

This is a little abstract. Usually, we discuss specific concepts / ideas in
our
IRC channel or on the mailing list long before starting to implement them.
The
past has shown it is often better to let other people dive into your ideas
and
comment because routing is a rather complex subject.

As I mentioned above: We are in a redesign phase right now and welcome
anyone
interested to join. As the next step we envisioned a collection of routing
scenarios in which the current implementation behaves poorly. All routing
protocol changes have to go through this collection of scenarios to estimat=
e
its impact. What do you think about this idea ?

Regards,
Marek
