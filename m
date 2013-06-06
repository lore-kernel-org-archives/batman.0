Return-Path: <ordex@autistici.org>
Date: Thu, 6 Jun 2013 07:51:02 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130606055102.GH1789@ritirata.org>
References: <51A3C7E9.7080208@inti.gob.ar> <20130528070057.GC3333@ritirata.org>
 <51ACBCE4.8000506@inti.gob.ar> <20130603160813.GC1226@ritirata.org>
 <51AD0277.1060907@inti.gob.ar> <20130604051326.GJ1226@ritirata.org>
 <20130604053841.GK1226@ritirata.org> <51AF567A.7030404@inti.gob.ar>
 <51AF58F4.8080501@inti.gob.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JI+G0+mN8WmwPnOn"
Content-Disposition: inline
In-Reply-To: <51AF58F4.8080501@inti.gob.ar>
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
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
To: Gabriel =?utf-8?B?VG9sw7Nu?= <gtolon@inti.gob.ar>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--JI+G0+mN8WmwPnOn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Gabriel,

On Wed, Jun 05, 2013 at 12:27:48PM -0300, Gabriel Tol=C3=B3n wrote:
>=20
> Sorry, I sent the mail incomplete,
>=20
> So these are the routes:
>=20
> Equipo1:
>=20
> root@Equipo 1:~# batctl o
> [B.A.T.M.A.N. adv 5ffa8f2, MainIF/MAC: wlan0-1/66:70:02:4e:d9:42 (bat0)]
>    Originator      last-seen (#/255)           Nexthop [outgoingIF]:=20
> Potential nexthops ...
>            E3-5GHz    0.680s   (251)           E3-5GHz [   wlan1-1]:=20
>         E3-5GHz (251)
>            E3-2GHz    0.430s   (255)           E3-5GHz [   wlan1-1]:=20
>         E3-5GHz (255)           E3-2GHz (252)
>=20
>=20
> Equipo3:
>=20
> root@Equipo 3:~# batctl o
> [B.A.T.M.A.N. adv 5ffa8f2, MainIF/MAC: wlan0-1/66:70:02:4e:d9:d6 (bat0)]
>    Originator      last-seen (#/255)           Nexthop [outgoingIF]:=20
> Potential nexthops ...
>            E1-2GHz    0.310s   (255)           E1-5GHz [   wlan1-1]:=20
>         E1-5GHz (255)           E1-2GHz (255)
>            E1-5GHz    0.550s   (255)           E1-5GHz [   wlan1-1]:=20
>         E1-5GHz (255)
>=20

routing tables look good. I am wondering where the problem can be..
Can you try to do a "batctl td wlan0-1" while pinging? this may help to
understand where the process is blocking.
It would be helpful if you could do that on both the nodes while pinging in=
 only
one direction This way we see who receives what.

(commit IDs are ok)
Thank you very much for helping us in debugging this :)

Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--JI+G0+mN8WmwPnOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRsCNGAAoJEADl0hg6qKeOJl8QALDKHMudWFIYKYBdExJYc1JA
znilEm/fE6LCeyh0JjptVImajSwkRmRZx+Kk+5VQ9YQltlCefp4FSkydpJaRCSI+
AL2cQtH830sRvoRY+//yiJxfQ7wWyfLbp88uqdv7dJyLMfwAE8WwdCUbJlEQC9FQ
uXqgG2Fzo1bMo0W5oIwFoKDoYZUoX8AGzkFCqTHfZSEkfLcqE0zS/Ogyf2eTmU7S
ZGK6jNqh7Zf0rrKceySdgoAekzwc+eNEZmhf/Px3CkXle/dZ49lBlvE8LlPXwIf4
3gslYqbbhJUxgEP5LaJFgZdDgteS7B6YAlrd//B+kAAHldf6nNuwozOPTexoltyZ
dZ9Y0/z9ae5plnr5C4j2son00blY56gRNoUWYjFccqT7w0vpKgXANeGrVQtfUZn7
YyyNIb3uCptU/qXTbC1M4oZ7AmkMhxLDqfRi5Z79J2LOZOz6YWhfTgnWltA7uSMR
7eEkKGZQC8AFZrrrAf0YZjMg15vfqnP0n2xecySjmvZSc6qHh0scOZ4wk4sLkbKz
jlI1uP/TK6jnoh3Gh6uhS5sbqZ21PCO6fVJqDMvP5hdEKNir1kU3C1gJWFEj2Xa4
XAckki1VdwKWr9E3CsME/goGA/6uA+kUvgyRknNngXVp66Jba5zvTGofcckbnoZe
uzs0lzuEZVxhqx3vwtlK
=b09g
-----END PGP SIGNATURE-----

--JI+G0+mN8WmwPnOn--
