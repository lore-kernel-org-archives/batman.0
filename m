Return-Path: <sven@narfation.org>
Date: Sat, 16 Jun 2012 08:37:03 +0200
From: Sven Eckelmann <sven@narfation.org>
Message-ID: <20120616063703.GA32026@sven-atom.home.narfation.org>
References: <20120615084751.GA32430@pandem0nium>
	<1339753563-313-2-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <1339753563-313-2-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Add the backbone gateway
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


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 15, 2012 at 11:46:03AM +0200, Simon Wunderlich wrote:
> +		hlist_for_each_entry_rcu(backbone_gw, node, head, hash_entry) {
> +			last_seen_msecs = jiffies_to_msecs(jiffies -
> +							backbone_gw->lasttime);

Please fix that in another way and not by wrong alignment.

Kind regards,
	Sven

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJP3CmPAAoJEF2HCgfBJntGJVsQAM12Dt7jUIfAIHvJGX1JMF1m
tm/dK+eAAK5WlWOYOo4GuXMHBamt1vS1Fh0Wx5nKN03MXwxOWwwvmzR+0iuPItxJ
GHSrS5/O/YOZwSwhjoaBU5uN+JeuAgQFWeUs98dZIaLq8T0Gv+ANVp8p8sP9AHh+
/6Jxo7ed5UetNikOFZ/RdRIaadiBQ+WLSQbjdIQ1tYX1Whfv0uYSYiVJsVKRXrVj
oJ/ev1U5Ddx9vlITGTcliqDvKMt3/f4rRFI6UCd9MNeLe/5k97Re8BcwUCfeuQUC
s3+L2I/b+DgMI0z888sLcyh8fIQIQe5IMhf8fx50OeLFlRB2XtkytGkvkuemDmsV
Ui+SNoztZRDact2Koe1TMPawXE8g4MqEYPl3V3YAAUkDM/GefzNmPWak98uuFXHg
XoX5SXk/Bc2O6buE+cfjYbLQrLwcxQ954jM61jynFjWAiAG41dErw03IX3mZ3Mn7
CdkcVAI7g5YM1AeX2ogaqrQwbslI80QBSozJ3YjOBvo1lmSR5et3hlAocAowJStu
k4EDEPWcltjhncpCjzenldt4vUyivhQi9mpP51G29qF+bAacU/Wz9Z2wvjVQgwtV
xVKn4u+fZD9m8GH5sokoi0jKkK1a6s0heW0NTZ5N81DThnSwdyrkcm/y78sTQfHz
tOcMH/ykzekA/TEz6s0B
=tS1t
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
