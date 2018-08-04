Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Aug 2018 16:23:56 +0200
Message-ID: <1538516.THWfRjFL1q@sven-edge>
In-Reply-To: <20180804134854.4075-7-mareklindner@neomailbox.ch>
References: <20180804134854.4075-1-mareklindner@neomailbox.ch>
 <20180804134854.4075-7-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3203288.MQNihGTI0Q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart3203288.MQNihGTI0Q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 4. August 2018 15:48:53 CEST Marek Lindner wrote:
> +               total_bytes = atomic64_read(&tp_vars->tot_sent);
> +
> +               /* The following calculation includes these steps:
> +                * - divide bytes by the test length (msecs)
> +                * - convert result from bits/ms to 0.1Mb/s (1Mb/s==1000000b/s)
> +                */
> +               total_bytes = atomic64_read(&tp_vars->tot_sent);

Reading it once is enough :)

Kind regards,
	Sven
--nextPart3203288.MQNihGTI0Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAltltvwACgkQXYcKB8Em
e0Zj4BAAg26Z+u5SV/1Gmd9lptC2juQSsbzWKUQjifpgkZH51Tf8xybgFQK88Kwh
Q1erX3HE9lSShdq7GuLK76PSKhpgHpz6WTYb5WmTQhqprPgUnXId/fn/J6f73dtm
t8azqup6wLBbTle9AFcPjUlQPkisbSxJEvNh2WrR05h9GUKcXdJIYooHLbpHzBhi
EDsnZzGvmddAvOsg77pf0MjQ3eneGGGqCP2BiYMaCuMJIoV8yFGt6a8PrGKAswIw
55JPbEvog7tfFNMqeKxnQS8/fGaB3fb0B2AMT2Og+uVwPkWZc7Yw1LAlHlsY/zYH
X2dH5TpThF9G+s0iJFCfraD5GQy5jVjMVz6hE8ZvV6a5/VElWKYIheaJ264cwhYB
7GFbupP3wFdLYf7kzzjJfeZkrB1HT6BwLTdCXrw6SvEkVmwBIAJJf+Y+q8xwJdrk
lcXvT/G29o5sP+EmmC3MwfL7IQsUZmxp8q88pNk24jmBqAxbVHo1vzJUGxG1jsc0
/ClxQ27+1ojz5BAmsVaGtDk4VEQ5rrG/cqZi21SQCO9GBOWZFjHad2/mjs1/k0dY
n9FZp0vDYOPZrkAyMrFnjHosqouPg28kooBtMyiNFj8tFN9/Q39YKK0oj8voIvIp
EabxKhh19Gw+PemWPH39I7VNwGvoYcN8fxXnFKmzQUr9YpvROzU=
=HELK
-----END PGP SIGNATURE-----

--nextPart3203288.MQNihGTI0Q--



