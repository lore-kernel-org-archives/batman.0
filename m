Return-Path: <linus.luessing@web.de>
Date: Sun, 14 Mar 2010 21:41:38 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100314204138.GA6096@Linus-Debian>
References: <8D692389-52C5-4CCB-BE58-D4B2E4D07161@me.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <8D692389-52C5-4CCB-BE58-D4B2E4D07161@me.com>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N Suitability for MAGIC 2010
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


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

> My name is Michael. I am currently working on a large robotics
> project and I am thinking of using B.A.T.M.A.N to facilitate a MANET
> to communicate between a number of bots and a base station. I was
> hoping to get a bit of information regarding the suitability of
> B.A.T.M.A.N for such an application. Any information would be helpful
> (general or specific). Here are some of the details of our project.

Your project sounds very exciting! I had a little look at the MAGIC 2010
website and what it says about the tasks that have to be done and what kind=
 of
time span and how much mobility we're talking about here and what the speci=
fic
tasks are on the MAGIC 2010 website. However, I/we have little experience w=
ith
such challenges and setups. Most people use batman to create wireless netwo=
rks
within buildings / houses / cities. Could you tell us a bit more about why =
you
want to run mesh on the robots itself and not using the common infrastucture
mode on the base station for example (as I assume this has been used in rob=
otic
challenges before)? Have other people tried mesh on bots before and what we=
re/are
the problems you expect?

So far, I haven't heard of anyone using B.A.T.M.A.N. in a robotics scenario
before, though I've always been interested in seeing B.A.T.M.A.N. in a=20
swarm-robotics scenario one day :).

> We have various types of data to be communicated on our network
> including, GPS, basic telemetry, control message, imagery, UAV feeds,
> point cloud info etc.
> Some data such as GPS and telemetry is realtime and need not be
> reliable (we are considering simply UDP broadcasting this data). Other
> data such as imagery and control messages will require stable links
> and need to be relatively reliable.
> We are not yet sure if we will be deploying any specific middleware
> technology although I am partial to pub/sub middleware. Are there any
> such middleware that can complement B.A.T.M.A.N?

14 mobile bots should be perfectly fine for batman to handle. Like most rou=
ting
protocols, batman does not interact with other software components directly.
It will try to be as invisible as possible and allows all standard network
operations to behave as expected. Nothing special or fancy required here.

On the other hand it is important to realize that batman comes in 2 flavors:
* The batman daemon operating on layer 3 (like most other routing protocols
do).
* The batman-adv kernel module building a layer 2 network across the wifi
nodes.

The later comes with some handy features you might want to look at. Unlike =
the
layer 3 routing protocols it does not only decide about the routing of the
traffic but handles the traffic forwarding itself. Therefore, it can be opt=
imized
for your traffic needs. For example, broadcasting UDP messages over wifi is=
 not
as easy as it sounds (broadcasted packets are getting lost more often than =
unicast
packets here). batman-adv already has a feature built-in to send broadcasts=
 up to
3 times along each hop to increase the probability of getting the data tran=
smitted.

> I was hoping to know what type of issues I might run into using
> B.A.T.M.A.N adv in such a scenario. For instance, what kind of
> throughput might I expect in the described environment? Link stability
> issues? General suitability? How would B.A.T.M.A.N compare to OLSR or
> Babel? I am really interested in anything that anyone has to offer.

Usually in mesh networks the rule so far was, that you can expect about half
of the bandwidth with each additional hop starting with ~25MBit/s payload
throughput in 802.11a/g networks for direct neighbours. In 802.11n you can
expect a maximum capacity of ~100MBit/s in ideal conditions with a wifi card
capable of 3x3:3or 4x4:4 settings as far as I know.
For QoS there seems to be the 802.11e standard especially for wifi networks,
but I have no experiences with that one.
I can't say that much for the protocol comparision as I haven't been
using/testing current implementations of OLSR or BABEL lately and I'm also
only aware of two comparison papers. I think it comes down to try what works
best for you and what your requirements are.

When you start your tests you might want to reduce the originator interval =
to
50ms (the minimum value) to make sure the routing entries are updated quite
often. Batman's default settings are optimized for less traffic but slower
updates. Buildings tend to move much less. ;-)

Hope I could answer most of your questions so far. More questions
always welcome :).

Cheers, Linus

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLnUoCAAoJEBKw7u43QNpfeE0P/0T6fDrtEY+J0WDWA5Rk9NhB
n1Pf7fecpXaD1cPb+vBqxRIU2C7HkCdvhpXnpGCO1uWZHkAJ6XaO0ZY6z6uoIosW
5fQaLRmke4Y687kzimEWOp7eKwZ9x6KTEsnL4/8xTI93TRLFQvKZRJdSg9ARi+av
mjGLZXwK+cuhB/GdimLH/WqfTfrU/lo0igWjVEilnZ2UGhktArI5HN3MvWX25f8S
LpEVSF1O7/yEdBf72o9A34Mk3a4FINU4X5UhSZDHHDzF3H38x2qpGayOhpCQDB0v
L8uMh/wuzt2XTLNmC0l9w9AKrZoPlUvAmvggFvl0sAKoVOmEW3hPY/Ee0ObM4Orq
EC1c22m4UyPmOf2ZATtnjbCu4S58befaAJmmiKCcKhjMBGdCWrxKJEvwaHVjsM7i
eKlrraiz076pKTJ5jw4KdnB0SsF++pAFvYGBewGXL0cQ05N7vhAZq3pvSniT814R
k5rEpedN4oi5+j2UxK2P2THFhrBuhP780ggnQkfCClcL/L7bedRmYMyv9fTAzlqX
TE/3y6/3zDHPIa2qcf7jzrsZemlPAMDKAtf4ojRQ4tr8LthOp2qf8aNoV4Ayncel
+yJiuqUH4q1FUT+x1FQdpCfmHBR+o5aNQu6zrbW5badiExsNGLcSObU1pADINVtj
399zWEsrf9SzsGtYI1qq
=+jtS
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
