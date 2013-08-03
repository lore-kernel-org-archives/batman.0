Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 3 Aug 2013 23:17:57 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130803211755.GF12891@pandem0nium>
References: <1375303667-3018-1-git-send-email-ordex@autistici.org>
 <1375303667-3018-11-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Content-Disposition: inline
In-Reply-To: <1375303667-3018-11-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 10/10] batman-adv: adapt the TT component
 to use the new API functions
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Jul 31, 2013 at 10:47:47PM +0200, Antonio Quartulli wrote:
> +
> +		if (metric <= best_metric)
> +			continue;
> +
> +		best_entry = orig_entry;
> +		best_metric = metric;

Why don't you use the bat_metric_compare() function here?

BTW, do we need bat_metric_compare() anyway? I think both TQ and the metric in BATMAN V
can work with integer comparison, so as long as we don't add some other "special" metrics
we might not need this bat_metric_compare() at all?

	Simon

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlH9c4MACgkQrzg/fFk7axbj3QCdH1N+FrMbh3y37IzZycTb1bTh
dTwAnA+UUG7f2k1N9pmSrbyRfSCfLWqn
=bXdq
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--
