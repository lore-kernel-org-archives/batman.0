Return-Path: <a@unstable.cc>
Date: Mon, 9 May 2016 22:20:15 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160509142015.GL3945@prodigo.futur3.it>
References: <1462664836-21988-1-git-send-email-mareklindner@neomailbox.ch>
 <8890255.lVUf8VaFkP@voltaire>
 <20160509104533.GI3945@prodigo.futur3.it>
 <1643067.4fJX8kxc6U@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ShzQXCswyqjgWi6k"
Content-Disposition: inline
In-Reply-To: <1643067.4fJX8kxc6U@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: init ELP tweaking options
 only once
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--ShzQXCswyqjgWi6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2016 at 09:10:44PM +0800, Marek Lindner wrote:
> Am I right assuming you're not testing with Openwrt ? I suspect it is net=
ifd=20
> that removes the interface from batX entirely on ifconfig down. That migh=
t not=20
> be the same on your system. I can reword the commit message to not mentio=
n=20
> interface down if you like.

You are right - I was not using netifd and so my simple "ifdown & ifup" was=
 not
enough to trigger the reset.

Still, I do understand that your point is to avoid resetting the elp_interv=
al
and throughput_override more than once during the hard_iface life span.


This said, I think your patch is fine, but the commit message should be
re-arranged in order to avoid stating that "ifdown & ifup" is a way to trig=
ger
the "misbehaviour".

Cheers,



--=20
Antonio Quartulli

--ShzQXCswyqjgWi6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMJyfAAoJEJ4aZjxxc6bKMJAP/0O2wO1cueSHx5zgNN83TZAd
+Wu6vDj1f05rVxgNLy6XA/+LBXAHcIiOclX43Q5xjMzCrzwYWtN9WN5ayb1UNExp
UCA8q0vxKG44Er5uxTcKvnbtSatXlha7X8hnqC8QPCvoqKSZIfIs9r0LW5kqs/9I
xHMLI9PvPJxa8EEYiwr7YkqIZzgKhCZz7Wqfs2DSDjw55D747nMVnyp9ebl8wcs3
bUTNfFZyo8PVPBupukvcrzr9WtQfQtZrxLwIrF96e56iTcrroVh7yPrRYr8tBWKO
2qG4Sa05Hpo1ACgR3Bi824LjIFYNBpWKP7i76tB+XeHhS0Z0JaSqGuJcvh9BkNpj
cHT/Ti0OhnTxWz5TM2DwF0R2X2OEFxTbcW1oIqRZ3xGGdRwJe2nFAeCm2Ob+Vzl3
Ql5PgUuBRLgASzGu5Dkx7+IPdyF12zoODQbxcIyWrOPxtMgcatjo1dIr+6DyBX/e
44Dvy+kcdEWsX5kDbHfX9iHikZs3lE3equTf4CNkETfz/GasN7YIRrM2UW0jCoAF
L9oTy3RpMJvv8gmTJmeGPTGD8yrT9YtSh0xBC0yGuJtU43XHYOKt513ywFjjarTb
Cj838q8z+fvM00GVMo1zSSiUp3VqH+cb9eAhyUSUOge7mdRv0JrX5md5EpVrgwiQ
xFnBzSGIP8DvDZuAKCHr
=vAL+
-----END PGP SIGNATURE-----

--ShzQXCswyqjgWi6k--
