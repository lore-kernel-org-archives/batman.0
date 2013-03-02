Return-Path: <ordex@autistici.org>
Date: Sat, 2 Mar 2013 22:25:13 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130302212512.GJ20607@ritirata.org>
References: <1362174287-15561-1-git-send-email-ordex@autistici.org>
 <20130302140113.GA26567@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IJFRpmOek+ZRSQoz"
Content-Disposition: inline
In-Reply-To: <20130302140113.GA26567@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: remove interfacing
 enslaving loop private check
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


--IJFRpmOek+ZRSQoz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2013 at 03:01:14PM +0100, Simon Wunderlich wrote:
> Hi,
>=20
> I've tested this for compatibility on 2.6.32 (Debian stable) in my virtua=
l machine.

Hello Simon and thank yuou,

> Marek suggested to use:
>=20
> batctl if add eth0
> vconfig add bat0 5
> batctl if add bat0.5
>=20
> and the last command fails with:
> Error - can't write to file '/sys/class/net/bat0.5/batman_adv/mesh_iface'=
: Operation not permitted
>=20
> which looks good and expected to me.
>=20

yeah.

> Without the patch, the directory /sys/class/net/bat0.5/batman_adv does no=
t even exist - probably
> because the check was removed in this patch.
>=20

Well, with this patch the check is done later and therefore the folder is
created. We may want to try to move the check earlier, like it was before t=
he
patch?


> Another thing I have tried, which behaves bad with and without this patch:
> batctl if add eth0
> brctl addbr br0
> brctl addif br0 bat0
> batctl if add br0
> (wait a few seconds)
> rmmod batman-adv
>=20
> First, enslaving br0 into bat0 does not fail, but it makes no sense to en=
slave bat0 through br0 into bat0
> again - we should probably prevent this too. Removing the module crashes =
the kernel, not always, but pretty
> reliably (I have the feeling it happens more often after applying this pa=
tch, but not sure).
> Unfortunately I couldn't get any useful backtraces so far, if it fails it=
 usually instantly reboots
> or hangs without output (this is in kvm with -curses). I've succeeded to =
get some trace part, it's
> probably not useful but i've attached it to the bottom anyway [1].
>=20
> Any thoughts on that? :)
>=20

How sure are we about being batman-adv the culprit for this?

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--IJFRpmOek+ZRSQoz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRMm44AAoJEADl0hg6qKeOV5cP/iokQiLtYggyFPf8+3llgOEb
NCDU78laEN0eArSb5YuHrfHaqs/a79C5MjhY41uKq52upvPWYZxTEHO96qjapXi/
TcPRu2GMhw4B5IlHFYIaevpce4qC+odVEirkXLzCzt/kee+s+OC95wIfyFr6U5jG
IXmNQCxLfvEX2pXahMuuDNY+w2yzU2hZaIvhpK3PjAaDzQjC0Jiq2+iJmjNi3yfJ
qpzflIbHjBSV/0BK/kqE0e6eZK4ZUo9IZz0xV+kr6VLYnrdN+psei0xTjlHfGWd3
7TNs//vbLZaWY4mj8LBPcYWUACwa9MEeXV/I2fiE3ehOkhMhhs2PDv50N2FWGXbu
Csgu9dXvEkexF1tmWSR3YNhfzTbfWGOz4PQS0mk1NwJu1aQM9kxMxQAR9Rox3hLh
E70cnrDQ7TJCRw16pJAvUTW9Irl9WeBT5SU7sw/hjxPfb03hhtNtC1Ia7hjx8rYg
AdlepD8ZPKwIdnytl6eciQ7ABCnhZKgWu3P7dz98jTBMuTJ+vCB/BAw4f3iztSDo
39zLkhr4HHhqtnvlCd9DZb36pAvGDsQLxmjl3tW3GayEMdnQDB4qG43Mcow4irOx
atX+Wa4mk+ooG6oK4dk27ofH4UZFkVmQC0FruWkrDG95o/gH3B3y6QDluvvLz0Qs
QuOCuqFgHDnykO3+Dip2
=u8y4
-----END PGP SIGNATURE-----

--IJFRpmOek+ZRSQoz--
