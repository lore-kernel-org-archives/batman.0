Return-Path: <David.Laight@ACULAB.COM>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Apr 2012 15:57:39 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6EF4@saturn3.aculab.com>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6EF3@saturn3.aculab.com>
From: "David Laight" <David.Laight@ACULAB.COM>
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/15] batman-adv: add
	biggest_unsigned_int(x) macro
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
To: David Laight <David.Laight@ACULAB.COM>, Antonio Quartulli <ordex@autistici.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

=20
> > +/* Returns the biggest unsigned integer with the sizeof x */
> > +#define biggest_unsigned_int(x) (~(x)0)
>=20
> Nope - biggest_unsigned_int(unsigned char) is probably 0xffffffff

To correct myself, it is actually ((int)(-1)) (ie a signed value).

	David


