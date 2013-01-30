Return-Path: <ordex@autistici.org>
Date: Wed, 30 Jan 2013 23:03:16 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130130220316.GA11109@ritirata.org>
References: <loom.20130130T212716-301@post.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <loom.20130130T212716-301@post.gmane.org>
Subject: Re: [B.A.T.M.A.N.] Using BATMAN to create a repeater
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


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2013 at 08:30:52PM +0000, Rip route wrote:
> All,
> I am trying to create a WiFi repeater using hardware that cannot accommod=
ate a=20
> normal "bridged repeater" mode. Is it possible to create this type of rep=
eater=20
> using BATMAN adv?

If I correctly got your question you may want to connect two nodes via wire=
less,
then install batman-adv on top of the wifi interfaces ans consequently brid=
ge
the bat0 with the ethernet interface:


     wlan0~~~~~~~wlan0
       .          .
      bat0       bat0
       .          .
      br0        br0
       .          .
     eth0        eth0
       |          |
ETH____/          \_______ETH


wlan0s can be two adhoc interfaces (common case for a mesh) or also an AP/s=
ta
pair.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRCZikAAoJEADl0hg6qKeOcdEP/RtU1Gdkw9lAVB6McimTeF86
IWOO6OQ2GRqA8OICJxYjKmlYkX0RLTXU7z7R5ibmvQ/hoC4cBW1o+CUO/LSwpYPX
DoTvOT1TB9rPXZzykjEfpGJFQuP/8DaMsrjivMmgq3OlWJknXsOzN4Se+aguld/7
veFs5OgS30A1RxF5mvcaV8i+i+tSKa2saoJFi8tlKw3qNPg5myd6h22fHWdioDqG
QKUzyH2XMzGT/h/jJ4Jtl57vLjDi53IHhWuGbWB19HVL92oX5eD7iN9JJ+3TKEpu
G0EAlauzq/GlHEetaStI8tlellxRSIyPhM71YTZwUDITiC078PsqOIQq4CcrSR7j
6QfxkIEjL0faMGXPdP6bP/aghr7UpnapcBEx7O88Peo0ps9KfUnU30Tw7SeZkrix
BXoAIkAOIeglB7ySVvY4DA8WKR2scyXFuQDmitH8cAT3OXnReuhMDClUv78LzXQK
qN+RVg0IIwv3JjQ9dlz46QnoFuZcAoUfFkwqCyk/UvawOjkPUE2QmiY3ycxdgD1a
d5MZXGiSworE9D1PAz1fyqFKzsMcSY22BYo7UK3HJbcwWbSMIIkweeH/fAO0xBsn
Jb0+Zx+x3ZlulM/uQZFOpa2W271JrZGq5c0FByapffFBuiKXWG6/X1WrUbdO7b/0
4J7duZRD/DX07apw0Yr4
=BB0d
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
