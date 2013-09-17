Return-Path: <antonio@meshcoding.com>
Date: Tue, 17 Sep 2013 17:38:54 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130917153854.GC3053@neomailbox.net>
References: <1379419694-12758-1-git-send-email-marco.dallato@gmail.com>
 <20130917123132.GB3053@neomailbox.net> <5238609E.5030705@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
In-Reply-To: <5238609E.5030705@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFCv2] batctl tcpdump: add IPv6 support to
 tcpdump parser
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2013 at 04:01:02PM +0200, Marco Dalla Torre wrote:
> Hi,
>=20
> On 09/17/13 14:31, Antonio Quartulli wrote:
> > On Tue, Sep 17, 2013 at 02:08:14PM +0200, Marco Dalla Torre wrote:
> >> >@@ -47,6 +49,8 @@
> >> >  #define ETH_P_BATMAN	0x4305
> >> >  #endif /* ETH_P_BATMAN */
> >> >
> >> >+#define IPV6_MIN_MTU	1280
> > I have it in /usr/include/linux/ipv6.h don't you?
> > If it has been introduced in a recent version of the headers, please ad=
d an
> > #ifndef to avoid defining the symbol twice.
> >
>=20
> I'm aware of ipv6.h, in fact this is exactly where the definition I used=
=20
> comes from. Unfortunately including it in tcpdump.c generates all sort=20
> of namespace clashes with the other include statements, and I felt that=
=20
> doing namespace housecleaning was beyond the scope of the patch...
> I'm not sure of what you mean with the #ifndef, since that statement is=
=20
> already present in the file.
> Can you suggest a solution (or explain better what you meant if that one=
=20
> is the solution)?

oh ok.

my ideas was to do something like:

#ifndef IPV6_MIN_MTU
#define IPV6_MIN_MTU     1280


but given your problem I think there is something else we should care about=
=2E..I
will check into this namespace issue.

>=20
> >> >+
> >> >  #define LEN_CHECK(buff_len, check_len, desc) \
> >> >  if ((size_t)(buff_len) < (check_len)) { \
> >> >  	fprintf(stderr, "Warning - dropping received %s packet as it is sm=
aller than expected (%zu): %zu\n", \
> >> >@@ -188,11 +192,210 @@ static void dump_arp(unsigned char *packet_buf=
f, ssize_t buff_len,
> >> >  	}
> >> >  }
> >> >
> >> >+static void parse_tcp(
> > Why don't you call this function dump_tcp like all the other dump_* ?
>=20
> Because, I wasn't aware of this rule. Now I know! :P

They are all over in the same file :-P

>=20
> >
> >> >+	unsigned char *packet_buff,
> >> >+	ssize_t buff_len,
> >> >+	size_t header_len,
> >> >+	char *src_addr,
> >> >+	char *dst_addr)
> > Did we discuss this "freestyle" alignment in the last RFC?
> >
>=20
> For this and all the other styling problems like that: yes sorry when I=
=20
> wrote this patch some time ago I wasn't aware of these formatting rules.=
=20
> And I clearly failed correcting all while reviewing it...

I guessed so :)

Cheers,

--=20
Antonio Quartulli

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSOHeOAAoJEADl0hg6qKeOvmAP/1Qcpyws0Uiz0AOdJUsduVpj
uKIPJVnRiyJW+w7M3W3A29R4Qe8pZuIr75mZg+dLbR61JKAB7b8UuMA8Q2gMPmG+
c0m7n2oq1QLe0Bl1IXZFUq2mLnqx/m7B3gEGRZ8B5KMsqK9thmnTaq2ZNF0pEBnW
1Y2zJfD2Hd5buxa6ujxLsMepyW3Vuny3j7O8V5U4Sq4UOaad9mv3x4x8qsiYOb4b
Q2x9dc8ZscqPqqO9zOABD22sUtXIBylpAW7IP7I2wSAtF028szv+gVE7BagZXlL9
4dQKGLq1+LodGWnx4KTW9tgF8X464X4nNbzZ1TDbmdIXuNF3i8V3aIKPFtJbjimA
AtNGRTao5g++4uL8g5iu5bbqUB1xl9QfynVWJqVSGEWEaMQzV1xlsAZHYJpAbQmg
n92di224+0aaMnupnlhFvnDT2QDQykI3CYjWGKGkbMS7auNhswGLFproCazEvf5r
lzzeS5+3UQk857Ng8W6RCeQ8BDhBptAsi2a/r+IEQJVpWDOFmGSCB7aGJhLfVg5v
wsgD5YmCymyZKznwDOrPcLbbECX5KwrZd9AfpAjJ4iD1Z6ta5eOYOX8k/zHsiQ8U
9PJtTzoTXbHqT9xLr65S8tsdnUPWRr+ERUrXpAyxJUbwB577BO/jiWVnuJriivgK
JTRR0ei2YUEptuAvQ/E7
=LGQs
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
