Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 16 Oct 2015 13:28:55 +0200
Message-ID: <2791733.raofpuymoN@prime>
In-Reply-To: <001f01d107fd$2a0f9680$7e2ec380$@itelsis.com>
References: <001f01d107fd$2a0f9680$7e2ec380$@itelsis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart96335163.EnFZTrDuKe";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] video streaming over batman-adv
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart96335163.EnFZTrDuKe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Santiago,

On Friday 16 October 2015 12:26:48 Santiago =C1lvarez =C1lvarez wrote:
> Hi everybody,
> I=92m an engineer working in a R&D Project using batman-adv protocol.=
 We=92re
> trying to develop a mesh network using linux devices with the objecti=
ve of
> transmitting video in streaming. Video is being generated with gstrea=
mer
> using UDP.
> The application works relatively fine with 2 devices, but efficiency =
heavily
> decreases when introducing a new node in the mesh network (informatio=
n need
> two jumps to arrive to destination). Introducing more jumps in the ne=
twork
> is exponentially worst. We have been expecting a better behavior of t=
his
> protocol, since level 2 routing should be transparent  (just increasi=
ng
> delay when increasing the number of nodes).

Did you consider the effects of the half-duplex nature? Your intemediat=
e hop=20
will have to listen to the sender and and send each packet also to the=20=

receiver. This means it has to send and receive each packet twice, so n=
eeds=20
double amount of airtime and therefore the throughput will be halved. A=
dding=20
more repeaters is even worse. This is a well known effect in mesh netwo=
rks and=20
is not limited to Layer2/3. Usually your first hop drops to 50%, second=
 to 33%=20
and so on.

The only way to resolve that would be to use multiradio access points o=
n=20
different frequencies.

> We are using batman version 2015.0,  over wifi interfaces, and our st=
reaming
> applications is working only point-to-point (not multicast or broadca=
st).
> The nodes in between server and client are working just as wireless
> repeaters using batman-adv.
> We also discovered that worst case happens when changes in batman rou=
ting
> tables are happening (sometimes, client is able to reach server in ju=
st one
> jump, but with low quality, and chooses that option instead of jumpin=
g
> through the repeater node, with better quality). When that happens, w=
e're
> droping lots of packets.

Another thing you should consider is rates: your wifi card has a rate c=
ontrol=20
algorithm implemented which will choose the best rate, which can be any=
thing=20
between 1 Mbit/s and 450 MBit/s (depending on  your hardware of course)=
.=20
Choosing a low throughput rate also results into losses if your video s=
tream=20
needs more throughput than the channel can give you.

> Any of you haver tried batman-adv for video streaming? Which was the =
maximum
> number of jumps between batman nodes that you can manage maintaining =
a good
> video quality?

I've seen for some cases. It can work over multiple hops, but it heavil=
y=20
depends on your video stream. There are also WiFi parameters you might =
tune.

> Can you recommend any specific configuration for improving batman beh=
avior?

First, I would suggest to use a higher multicast rate (WiFi configurati=
on).=20
Another thing to consider, if this is a setup which should only send vi=
deo=20
streams, is to limit the WiFi rates to some high rates like 18 Mbit/s a=
nd up.

Cheers,
     Simon
--nextPart96335163.EnFZTrDuKe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlYg33cACgkQrzg/fFk7axaVvwCg4poACcM93sneFIOR6Sv1UQwT
ra8AoI1krAui9C2o4mVs+5kPEZAkp1cv
=Z6rd
-----END PGP SIGNATURE-----

--nextPart96335163.EnFZTrDuKe--

