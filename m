Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batctl: Add per interface hop penalty command
Date: Tue, 02 Jun 2020 09:11:04 +0200
Message-ID: <1986436.iMA26uce0h@bentobox>
In-Reply-To: <20200601203538.5318-1-linus.luessing@c0d3.blue>
References: <20200601203538.5318-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart72324447.64dR16D2lC"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Maximilian Wilhelm <max@rfc2324.org>

 
--nextPart72324447.64dR16D2lC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 1 June 2020 22:35:38 CEST Linus L=FCssing wrote:
> This patch extends the hop penalty setting to be configurable not only
> on a node scope but also on a per hard interface basis.

I would prefer not to have "this patch" in all your patches :)

Maybe something more like:

* why is it needed
* what was changed

>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  Makefile         |   1 +
>  README.rst       |   7 ++-
>  if_hop_penalty.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++

Wouldn't it be more consistent to have this in the main hop_penalty file an=
d=20
just add a new COMMAND_NAMED?

>  man/batctl.8     |   4 ++
>  4 files changed, 124 insertions(+), 1 deletion(-)
>  create mode 100644 if_hop_penalty.c

This is missing the change to parse the per hardif in the `batctl event`=20
monitor command.

Kind regards,
	Sven

--nextPart72324447.64dR16D2lC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl7V+4gACgkQXYcKB8Em
e0ZLrQ/+KiYNq9MdSbKxLrjzVjGDzi4nMlCSV2znQvmiy55fCPiNxicAqjM0GKHk
+dmb46KagFYFC0i8BWmR8otiPaJuPq9wDhD8lKgsqlWqywn3I7bvZEnY/8WyTVJr
NtviaKbHXmRg0WpPM19wl7c636uEzk1DytK5kLeLlYqVPULheZVaPe38wLr+rdgE
OEKRRIZg/p65R6jyhIF04Cko7GYBRUe27kXoEx7XW1jpMFbQT3bjesbfo2QTV7tX
B2Nd4yyFE11yEVTXIlkIEX264cmLmt0/+r4Ga5OU5rmfppzk67mSZjXbWvKnWRlm
tVo7arvWSIrfDluvCKf+9ddtQgWiezoP/FMVBIi1g9ERben9tQItlyMSt5EiqtfX
BkyjE8KlXpTg6cD7LADaLHddHQze6TzIisDUEdM9qEgo0HsghOW3NPX7u4s8XjgO
7EK7FCN5ynt1RkjMsAGhCtCWv4OGjQAhg5VLGrdyfKLksfu2XxNVbsrpj+WrUoZj
0/rZAm9eOwgGcp6EgDJy1ROrljlJ9b/tneQN4oKF6a0aRs81lsbJ1ZSS01t+7vM3
djGWfFBIg0hJrK5ydO3xzaVVsgn14R3L1RWy4HnRwyRCsW8p/iICPQO02d4cQG2g
wgMhyU0jOOzEaD8Lqc31XpFDwSxcvo/rddhPVF2iHBMtREGX/3c=
=yqC9
-----END PGP SIGNATURE-----

--nextPart72324447.64dR16D2lC--


