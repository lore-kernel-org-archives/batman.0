Return-Path: <david.laight@aculab.com>
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] asm-generic: avoid sparse {get,put}_unaligned warning
Date: Tue, 27 Jul 2021 08:44:21 +0000
Message-ID: <bb831fbad4f74e11b868d936f7616d1a@AcuMS.aculab.com>
References: <20210724162429.394792-1-sven@narfation.org>
In-Reply-To: <20210724162429.394792-1-sven@narfation.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: 'Sven Eckelmann' <sven@narfation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Sven Eckelmann
> Sent: 24 July 2021 17:24
>=20
> Sparse will try to check casting of simple integer types which are marked
> as __bitwise. This for example "disallows" simple casting of __be{16,32,6=
4}
> or __le{16,32,64} to other types. This is also true for pointers to
> variables with this type.
>=20
> But the new generic {get,put}_unaligned is doing that by (reinterpret)
> casting the original pointer to a new (anonymous) struct pointer. This wi=
ll
> then create warnings like:
>=20
>   net/batman-adv/distributed-arp-table.c:1461:19: warning: cast from rest=
ricted __be32 *
>   net/batman-adv/distributed-arp-table.c:1510:23: warning: cast from rest=
ricted __be32 [usertype]
> *[assigned] magic
>   net/batman-adv/distributed-arp-table.c:1588:24: warning: cast from rest=
ricted __be32 [usertype]
> *[assigned] yiaddr
>=20
> The special attribute force must be used in such statements when the cast
> is known to be safe to avoid these warnings.

At least the __force is being added to an existing cast.

The real problems are when a (__force __le32)value cast is used
to silence sparse.
These should really be something like:
=09__tell_sparce(__le32, value)
so that the whole thing can be removed by the preprocessor when
compiling the code.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

