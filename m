Return-Path: <sven@narfation.org>
Date: Mon, 18 Jun 2012 12:41:09 +0200
From: Sven Eckelmann <sven@narfation.org>
Message-ID: <20120618104108.GA17473@sven-atom.home.narfation.org>
References: <20120616063703.GA32026@sven-atom.home.narfation.org>
	<1340014892-22722-2-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <1340014892-22722-2-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: Add the backbone gateway
 list to debugfs
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2012 at 12:21:32PM +0200, Simon Wunderlich wrote:
> +			msecs =3D msecs % 1000;
> +
> +
> +			is_own =3D batadv_compare_eth(backbone_gw->orig,

Why two empty lines?

> +static inline int batadv_bla_backbone_table_seq_print_text(struct seq_fi=
le *seq,
> +							void *offset)
> +{
> +	return 0;
> +}
> +d

This also looks wrong aligned.=20

Kind regards,
	Sven

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJP3wXDAAoJEF2HCgfBJntGIQEQANX2/BKy3kqGAv67UtD+DCxz
+3GP2ZEz8+sV9pfBGlhMooXCRrTFjUUqkjMO60PrYZtdktyrld+7Y5ppky++WtC8
pdgI9zFjooRLTiFHLCKu7IogQqj/4SzLa02ZnUEKfreuwcgpnFX4jaSHW4KyQVtu
rlAtL6qB+7C33Rw65o06WSGhu16k/3dd2vpu17yQBzghCC6W/azDgRyUbMQFBLG9
9y+VXYodC9VcWTwKyFx6rOfhdWO4Iy+m/OEBe5wV9CEFKo8dBSduq6s4HVi16xB0
6GVgPHOzs6zXQIBlYSbIzrNI557t+PlbuJy/ttWFa4217t6KFePjpg8NepkFV587
BmO4mx4XizreeEpcnODXOXuwsMXgztxEPfAluPyg1lVV1kZsl/RlXeGSkaAw8VdE
5hRUU7RYZvAEyVWyB7GGYYGer4EZiH1p73dqTQblhMBvEjFH9usxpKmk0A7NasH+
OZsuB8JbqlE1l5HGlOF5ZHp4IWB6HS3s7rbFzIJIyi+dQdRUPMcMz1up0xcl0omQ
lZkuhVgEBbWflz08v9xGXMS37VkKh6bxVvWSuKOuWcSDfcx3//0C+Hj+bwxNjXh5
ApTpH1IQ4YFmzpnG+xzPvR8CDxmlLK46FlCuWB7wWMzABTYEfzKxAp6BO31ecwYa
RseAgKKCy6ESL+fFPcNy
=C3E0
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
