Return-Path: <ordex@autistici.org>
Date: Fri, 17 Feb 2012 11:29:30 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120217101933.GA2194@ritirata.org>
References: <1329349200-8507-1-git-send-email-ordex@autistici.org>
	<201202171805.42454.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline
In-Reply-To: <201202171805.42454.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use ETH_HLEN instead of
 sizeof(struct ethhdr)
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


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2012 at 06:05:42 +0800, Marek Lindner wrote:
> On Thursday, February 16, 2012 07:40:00 Antonio Quartulli wrote:
> > Instead of using sizeof(struct ethhdr) it is strongly recommended to use
> > the kernel macro ETH_HLEN. This patch substitute each occurrence of the
> > former expressione with the latter one.
>=20
> You have missed 2 incarnations.  :)
> Check bridge_loop_avoidance.c line 859 and send.c line 54.

Oh, thanks.
I'll send v2

>=20
> Cheers,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPPiwJAAoJEFMQTLzJFOZFcfsIAMQEcCAK6gtaGDxjaIgAWJi3
T3ww3itL7UO2VN8eKi2Ssm2vlK/DH+5Ox1EJXeAc80YFxQI1gXUWQ+mkf3qdkntl
OwdkMio9njJUWVvaDStwcfNuZDdr3ykp3S0OZ16UFa9s2Gx+npFG7YGOzwzFo2Gs
B8r52abKptGHDptpdv5DBfTKYne7vj2FnhgS1CsZIC4UTTSznQwf3EMIFiDUwVQW
Tqp9w+mlSfE5Smi21t2LAgiDk7ZW+gzOR9prq51+fsY0BkbPOHGLvJn1yaHpmesr
sac1QBpOTiLRlHEONhkXKtIhhEKMbDrMfsth0B1lrGVvp3rbmW+DPgT0ntoRoIs=
=H2Mw
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
