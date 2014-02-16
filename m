Return-Path: <antonio@meshcoding.com>
Message-ID: <5300BFA0.9080903@meshcoding.com>
Date: Sun, 16 Feb 2014 14:39:44 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392552062-17927-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1392552062-17927-1-git-send-email-linus.luessing@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IUIufLtiG8kJ9cKeCNNnrdUBRO6Irkld7"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: fix null pointer
 exception for kernels < 3.9
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@web.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IUIufLtiG8kJ9cKeCNNnrdUBRO6Irkld7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 16/02/14 13:01, Linus L=C3=BCssing wrote:
> @@ -371,12 +372,13 @@ static int __batadv_interface_tx(struct sk_buff *=
skb, \
> =20
>  #ifndef netdev_master_upper_dev_get_rcu
>  #define netdev_master_upper_dev_get_rcu(dev) \
> -	NULL; \
> +	upper; \
>  	if (dev->priv_flags & IFF_BRIDGE_PORT) { \
>  		rcu_read_unlock(); \
>  		dev_hold(dev); \
>  		return dev; \
> -	}
> +	} else \
> +		dev =3D NULL;
> =20

Following your patch the code in multicast.c will become:

172         do {
173                 upper =3D upper;
			if (dev->priv_flags & IFF_BRIDGE_PORT) {
				rcu_read_unlock();
				dev_hold(dev);
				return dev;
			} else
				dev =3D NULL;
174         } while (upper && !(upper->priv_flags & IFF_EBRIDGE));

am I wrong or this is going to break the while? I think there is a
missing '}'.


What about a simplified version like this:

 #define netdev_master_upper_dev_get_rcu(dev) \
-	NULL; \
-	if (dev->priv_flags & IFF_BRIDGE_PORT) { \
+	({if (dev->priv_flags & IFF_BRIDGE_PORT) { \
 		rcu_read_unlock(); \
 		dev_hold(dev); \
 		return dev; \
-	}
+	}\
+	NULL;})


Cheers,

--=20
Antonio Quartulli


--IUIufLtiG8kJ9cKeCNNnrdUBRO6Irkld7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTAL+kAAoJEEKTMo6mOh1V8yYP/R/NnHfKIIq467IUir2Tf2E+
ymltW6tsDcVKKE4sE90UsQ0QyUmuGQFJhh4fb55iZQinFfTvHFeHtr37+vesiB1B
VYLcl8RSMLKtc0pIYWPWQUyyDu44J8dLRo4KLMwusSF7x/nuMfck5COz59plrBNy
mW0vFvgE/T+4C94FG5aYuWf9PBkOpTGxNlb9C1TO4vPFOAlAZivd55rVM3V8U6EH
ML4pt6CDdzpmOJMCsrFlH0sU3BDNjfo51MiH0anvsf3Njvb0hgOXBfB4rENYfp03
LIaulVaiG0wjhsseOdaijAz/esvVOMu7vQUIu6XMjbTfPWj+gssZe5JLoLD7hm2e
ItRpRUctLFT2gSLM88tr6EGmBsO1vfrNaEhoEhEjWFaZXcx72JK02wVtbYPAhSTx
nvaZE8O4eGYSyNmddgW3Lxi3NQBfUvhfv7qbdH9IZ6z4854o66GCW6AcBfp1WUQ+
4GIRQZsucsNQb2nSItwFwKCFckuLdu330sT/Irl0qEjeMD3ifL738tE8F1fAuphF
NgjuXS1HBHzmeXI65hSUns2aPZbi9QN06G8PPC5/JRwi9IWfIKqlpZdE/c9CudOk
EpOFipigi/oJIHwJik78wP0mjW4Vtqutoktz5NtymDuyTf+3i5JzjsWcp5fkZcQ5
Ao5KsG5iQqxx0ElAfAff
=SH4B
-----END PGP SIGNATURE-----

--IUIufLtiG8kJ9cKeCNNnrdUBRO6Irkld7--
