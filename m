Return-Path: <ordex@autistici.org>
Date: Wed, 26 Jun 2013 16:46:05 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130626144605.GA2120@ritirata.org>
References: <1371232209-7808-1-git-send-email-linus.luessing@web.de>
 <1371232209-7808-4-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <1371232209-7808-4-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv6 3/3] batman-adv: Modified forwarding
 behaviour for multicast packets
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


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2013 at 07:50:09PM +0200, Linus L=C3=BCssing wrote:
>  static void
> -batadv_tt_global_del_orig_entry(struct batadv_priv *bat_priv,
> -				struct batadv_tt_global_entry *tt_global_entry,
> -				struct batadv_orig_node *orig_node,
> -				const char *message)
> +batadv_tt_global_del_orig_node(struct batadv_priv *bat_priv,
> +			       struct batadv_tt_global_entry *tt_global_entry,
> +			       struct batadv_orig_node *orig_node,
> +			       const char *message)

*cough*cough*kerneldoc*cough* :)

For all the remaining TT bits you have my ACK.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRyv6tAAoJEADl0hg6qKeOcd4P/RfkIJ5R+Zx1JMs8mZ68BGcV
UY7T9NtI6P1meOOu7ByDsKJNmPwJbp+awFrSYyv28iJV/DCOH3CR4sV8lPArOksq
o7AAHQ1sZErHtnUav92yorFDLHyYZqEUD56wASDckLj+v5Du6cCdwlOlt0KMqiPw
btc0/wCK/rd0zelIZCZjAB+QiHAUD/bc/Al86Dmk5PBN4Lx/y9bEDnTAmHoaw5dm
cVJOpeHP2vJbWtuTR6jht8P7yP3gqyk3dQYCAjxOmjyXfWE8+egwEnmiZVhKrbG6
+6p9qavM7eh25wegm7MkPz0mRXUN+TtfJmijzNiqmxJpqxnm/Akeh5Q6LRwBjwq2
QXVekM7T0dGBFq9ofvjPUZqe2iPjfixTQv35YSAjgH7bwRJg9YMXyS+Nvbs0NfuW
0SKUikEXM1wBS5h1TV08c4Y5VDZ1qLM+JtWXDJu4qYbPxnUM/AigVLbRkplZ5MF6
8uXA0Y27x5DPcbqb+xJdfRsXS6QpSW65sCi+NbUWo3Wym1XPgP2t2G++ja+g43hQ
CVmkqJ5hWJUxtPZ3uPNGiSUJNSC+nS8oUcSkXoF5M/oRgN9I9K+tSDxQ4m5dgQKg
JxUmxcxGIq+e5ciuQbQ9ML5wDeWpE0zmk9pDKXVfXJmw5cOgReemxtlBZf603dei
iFMJfeEkxeE4Evrdc33y
=SB8n
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
