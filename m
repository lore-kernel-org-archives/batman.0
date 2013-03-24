Return-Path: <ordex@autistici.org>
Date: Sun, 24 Mar 2013 19:30:28 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130324183028.GA5152@ritirata.org>
References: <1364126431-17774-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <1364126431-17774-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix interface clean up
	on error
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
To: b.a.t.m.a.n@lists.open-mesh.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2013 at 01:00:31 +0100, Antonio Quartulli wrote:
> When enabling an hard_iface for the first time, the
> hard_iface->soft_iface member is initialised with the newly
> created soft_iface.
> However, in case of error during the activation procedure
> this member has to be set to NULL again, otherwise the
> hard_iface will result busy and will not be possible to use
> it anymore
>=20

I forgot to mention that this problem was already observed in the past duri=
ng
previous tests of the rtnl API:

Reported-by: Marek Lindner <lindner_marek@yahoo.de>

Thanks!

> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRT0ZEAAoJEADl0hg6qKeO7DQQAK+Ookvgq5Eb6bJj/ry8sd0Y
iq/WSb1fCkoYuXod2+rPtPHF9yH4Vr3C9Q6ehVgsNB/b3+IU8zJFoESL0t+K/Zem
8bxWUZV0s9RISMCr2rODmL2ykR0821zr1wBAy+U1nJ8ZMky/YeB1w68cK2QI3rKL
j3sHMF2c6QmCMfHAZwb0HRzpBwpE2eV+gtQ94BpKEITneEc2IZIRC7AjACAhXQfu
cLQcyuDLHXnW7vSmblhYIC1XOkkJjgCciCyNrwwpsRICVw/p7N0F59yKbjuxggTv
vYcWVtqgn7qLoo4wWvmy7gkL+Iiy5zb9CXnk9w7Ohob55gLBVCwzSmDOI+surRTQ
yYM9IHplmYF3TbPsTzs1t9a5xC3fEL4SiLksPkqRbOGp6pVcV79b2fcckvj2ER8X
+CnewgmtJRvnnXKqXOY33XdTDH2f7B1XthiLRPL3isOREnjWd1NNrzrAtgF6ASdu
ssWZ7pMBPUR7iDA9894lsy3H1rDmGcCesAnsyKn9Y/bMaLg1GnRqAnkwOt51xOOG
Ip3f1422/8sXMj8HLB11Q86CPBEFytdpkWyYsFgh08bxaCGDzSchiopnIrZr0GEN
gx48+Gml/LfaVusVyg0dsaQYAV5GOwuLGwHYdaC9ebAGqIXOK2OEvP1U3yGRHJck
p21Kmep5zzV1VvC0GCxD
=vvzE
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
