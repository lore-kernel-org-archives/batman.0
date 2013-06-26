Return-Path: <ordex@autistici.org>
Date: Wed, 26 Jun 2013 18:53:19 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130626165319.GB2120@ritirata.org>
References: <1372156113-1416-1-git-send-email-ordex@autistici.org>
 <1372156113-1416-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <1372156113-1416-4-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv8 3/3] batman-adv: make the AP isolation
 attribute VLAN specific
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2013 at 12:28:33PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> AP isolation has to be enabled on one VLAN interface only.
> This patch moves the AP isolation attribute to the per-vlan
> interface attribute set, enabling it to have a different
> value depending on the selected vlan.
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>

I just found out that i did not remove all the occurrences of
bat_priv->ap_isolation...


I'll send v9 :)

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRyxx/AAoJEADl0hg6qKeOihQP/A7bgrDAS5sVaSJwz21xy2qn
4tF1BxYyFo3h7vHIalMFnCOe4wIo1HxPkKnLeY0AO4Kx67KdIWd/psGIh6L6bjBg
NfrMC8CHWKday7y1GVYqyKLdshxSCSqda+l+hIoAZNJyT0Nlmmg/9inHkdiD9PNA
2Df13kQpE+I0zhZ8PlLASpfnauEgVmjq2Ts4NRVdg/pQpYfFM7zDMrgy6KbB2tmh
likquxzTp6LiSYsQNLAP1WflUjxQH/9hvDnXcDfVYuNVSgRnncUH7x9G7c2lW+Ie
dyx3uvq0oDFDYB+YMYJWo3m1XxrPwWiuASJC+5j3KawabgwFVG06u3MK7wVfysZp
iZEW5X5hGKEuTGGF1HTbuFd3QhNvgNowub+AdekgoIuhZ7rztUaj6Fxuic2kAZ0P
hJJ0Rss8v3BJgyi+8VWNKQIIURo/tsgMnDaczfMa6KM5nMJpbkQeW0q52bEYJ70J
sGdtn+JIdcSMSOB/JDdny7b9nEUk/Kw2Y33A58AivczviX82g7PsFX3aeGFOVz5x
sVQe1OB8JDh8ygx7Ldgm5pI4xT+djuGAd32PrSFK5bzZ0jAjT3QMFBIKpdOoyJ+k
YlxJCEB69fBfWP2xK0SJ7+SI51J4Vu/CUH7pELPRNJpmtUxFaqp46kBJiLHE1qVk
JBTNpbH5LAiESeAnCVAW
=lxTd
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
