Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2016 13:45:06 +0200
Message-ID: <66630624.pJyiLFKJYK@bentobox>
In-Reply-To: <20160612041426.26339-3-a@unstable.cc>
References: <20160612041426.26339-1-a@unstable.cc>
 <20160612041426.26339-3-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1722964.94OlFDHWk8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 2/4] batman-adv: make GW election code
	protocol specific
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1722964.94OlFDHWk8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 12 June 2016 12:14:24 Antonio Quartulli wrote:
> +static void batadv_iv_gw_print(struct batadv_priv *bat_priv,
> +                              struct seq_file *seq)
> +{
> +       struct batadv_gw_node *gw_node;
> +       int gw_count = 0;
> +
> +       seq_printf(seq,
> +                  "      Gateway      (#/255)           Nexthop [outgoingIF]: advertised uplink bandwidth\n");

Maybe you wanted to use seq_puts here. At least you've used it in
similar changes.

Kind regards,
	Sven
--nextPart1722964.94OlFDHWk8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXXpzCAAoJEF2HCgfBJntGMpwQAKwX3GIXTUVYEwZ2TsOM1L8p
owo2HExOovJ6obdFGFZNjhGY/bMJUkbiPlV+DFD4/LU7/GtelbI6zPFZfWSHPCuD
+Yb6IptpKvxiYsGZrbT6cE3fSoAtyrSmC84xFAM55MxsT0kYTHj4uU5Infzx7DIu
ka3NrxFMIkwFnM7f2RRNwY4n8wdKBlaXfJQnrOt0K6HNGE2wihsfX783Gpq0yoTY
rD6ZM3dWTuP1EZmfo5F4A6MFca6CxNV1yetUcNr2hp6mpEoae2O2YcpI+GU/CXQg
jYR9T88i4lPu/E0UqBNTUk/CXbypI4JvWgY18vcoHf4sGuRamxI5QIMKh3eFS0gT
BJD4A4+8gqD5WlDm1an4yZbjrrbIkYjHP16uI/BXTpAEANi99qfVnF5RZsUhRdsD
pNYFWPQ9cdAhrlcGwiiVLz9XssDgY30FvDF/zcb9QMBsWLc0f4JbU4lZG7tt3cuq
mzWWHZ7bKJ2lTiyPiinLQCyvknnjWpDg0A4w7bTRVa9LkiNeOxrWAQUInhZgBp15
jBys4jsP9RS/Xp8VJqakl519MbSiF8igfiFT47pIuqylezurAp5BvM5bvb2D3wsJ
tIoWiIC/HlAJTp2oSzWVNR3EyZZQ2ku0AoHAnfuV7NEuVDCwklPxA5Fb1ubvUG6g
GiCnXS080eb3w3P/nHxu
=bb2v
-----END PGP SIGNATURE-----

--nextPart1722964.94OlFDHWk8--

