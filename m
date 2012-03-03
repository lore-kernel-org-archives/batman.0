Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <4F51F168.7000605@codigosur.org>
Date: Sat, 03 Mar 2012 07:24:40 -0300
From: =?ISO-8859-1?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
References: <4F51CA9D.2090404@codigosur.org>
	<201203031553.53565.lindner_marek@yahoo.de>
	<4F51D34F.9040204@codigosur.org>
	<201203031643.12912.lindner_marek@yahoo.de>
	<4F51EF0B.5070501@codigosur.org>
In-Reply-To: <4F51EF0B.5070501@codigosur.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] routing loops on interconnected routers / adhoc
 + ethernet
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

On 03/03/2012 07:14 AM, Nicol=E1s Ech=E1niz wrote:
> On 03/03/2012 05:43 AM, Marek Lindner wrote:

>> You should not have loops either way but it is easy to build loops in=20
>> complicated setups. At first we should understand your setup and=20
>> configuration. Drawing a little picture that shows what interface is con=
nected=20
>> to what other interface also can help.
>=20
> alright, I'll try some ascii art, but I'm afraid you'll find out my
> english is better :P

holy s... I knew this wouldn't work

I've uploaded the image here:
http://www.lavecindaria.org.ar/picture/esquema-de-enlaces/


>=20
>=20
>                                                    (non-batman)
>                                                       wlan0
>                                                         |
>                                                   ------
>                                                  | czuk |
>                                                   ------
>                                                 /wlan1
>                                                /
>                                               /
>                                              /
>                                             /  1500m
>                                            /
>                                           /
>                                          /
>                                         wlan1
>                             ---------- /
>                            | cisterna |
>                             ----------                  (batman enabled
>                                 |                        cabled clients)
>                               wlan0                                |
>                                / \                               eth0
>                               /   \                                |
>                              /     \                           -------
>                             /       \                         | nogal |
>                            /  350m   \          600m         / -------
>                           /           \         --------wlan0
>                          /             \      /
>                         /               \    /
>                   wlan0--------------wlan0-1
>                  /                          \
>     ------------                              ------------
>    | marisa-mr  |            0m                | marisa-blt |
>     ------------                              ------------ \
>    |             \eth0__________________eth0/               wlan0
>   eth1                                                    (non-batman)
> (non-batman)
>    |
>    |
>    |
> [in-house router]
>=20
