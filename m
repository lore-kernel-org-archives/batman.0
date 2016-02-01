Return-Path: <antonio@open-mesh.com>
Date: Mon, 1 Feb 2016 22:45:34 +0800
From: Antonio Quartulli <antonio@open-mesh.com>
Message-ID: <20160201144534.GB12011@prodigo>
References: <1454308474-23211-1-git-send-email-mareklindner@neomailbox.ch>
 <1454308474-23211-2-git-send-email-mareklindner@neomailbox.ch>
 <2398211.sq1Z83hZa4@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <2398211.sq1Z83hZa4@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next 2/3] batman-adv: convert wifi
 driver throughput to multiples of 100kbps
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
Cc: Thomas Huehn <thomas@net.t-labs.tu-berlin.de>, Marek Lindner <mareklindner@neomailbox.ch>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 01:26:12PM +0100, Sven Eckelmann wrote:
> On Monday 01 February 2016 14:34:33 Marek Lindner wrote:
> > The expected throughout returned by the cfg80211 API is expressed in kb=
ps
> > while internally batman-adv stores multiples of 100kbps. Ensure the
> > conversion is performed properly.
> >=20
> > Fixes: 5c324517 ("ELP - compute the metric based on the estimated throu=
ghput")
> >=20
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> > ---
> >  net/batman-adv/bat_v_elp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
> > index 46c6a00..461a765 100644
> > --- a/net/batman-adv/bat_v_elp.c
> > +++ b/net/batman-adv/bat_v_elp.c
> > @@ -100,7 +100,7 @@ static u32 batadv_v_elp_get_throughput(struct batad=
v_hardif_neigh_node *neigh)
> >  				return 0;
> >  			}
> >  			if (!ret)
> > -				return sinfo.expected_throughput / 10;
> > +				return sinfo.expected_throughput / 100;
> >  		}
>=20
> Just tested it here and can say that it now show the same value as
> `iw dev adhoc0 station dump`. But the output of `iw dev adhoc0 station du=
mp`
> confuses me. I can get easily get over 40 Mbit/s but the output of
> `iw dev adhoc0 station dump` show me 4.705Mbps. Also the output of
> `cat /sys/kernel/debug/ieee80211/phy*/netdev\:adhoc0/stations/*/rc_stats`=
 look
> definitely more like ~40 Mbit/s.
>=20
> Antonio, can you please check my tests and my conclusion (+patch [1]).

Sven,

your test looks correct. By accident this bug in mac80211 was "balanced" by=
 the
bug that Marek is fixing with ("batman-adv: convert wifi driver throughput =
to
multiples of 100kbps").

Your patch[1] looks sane to me. Thanks for sending it to linux-wireless.

Cheers,


[1]http://article.gmane.org/gmane.linux.kernel.wireless.general/148102

--=20
Antonio Quartulli

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWr2+OAAoJENpFlCjNi1MR4nQP/RGEu0BMktOJxFlU3IZ11EIx
Ax/K7+AoJVl2BRFb8NT4XRL4O+0kgJq59AjVJgavcTxncDDj/nlGB2xCDKw3ZRmd
PKTfw4v62kyhdf7CEXVq0p17iZJyGBtSe9RucyxY1kDlXtV05HGCH+3SGFDaGCev
l73kSLKCnkSX++AYLL6nVIGLpn4czt+EZvtBqijBTqns2Q9fnctwUDq9kh7wP8IW
Y9y9ZEpxZSmgblyCE3uhhSGpfwxll4oPAbxFvV+TCIoBPYjUowFLMXcqCBGxwNhe
C3jq1kul4oAHMLakM0mBIblWdOQRWgF3WyTfszwcg9sHNwRL8i2OETPUAlYJoy0l
XXczteYL2qbAFN/7f1RzoG/bggpExx/rC5/FCfaa66JI9vsSKworav8oDxBb634f
EDHa6h9X9S6SZArraGKk2cMDFn8Go4LawlISCSp8lij/P38BplxmyiQrvOHrk4V5
4idG5eujRRkmeZ4xL1gheoayhcS3tTPhkR+UEcxXCEwbHUbXiTxJ5hinexxvkNdP
gXWg2pJQplB2g9oZSxAvSLomkbMeEvdA4Q1tv+pR4zir0Vd2kEbVs+XCNO4OWo8T
j7841xmozQRrJCvp4U2+w7ra5Ge4rM8jnsaEBg73ODhueHcCxk5l7qz59CcoAtU+
mz6czQRs0cYgluEPPI79
=86VZ
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
