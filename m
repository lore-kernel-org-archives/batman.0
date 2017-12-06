Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Wed, 06 Dec 2017 18:27:37 +0100
Message-ID: <7082766.sOGqpe4oL6@bentobox>
In-Reply-To: <CAF=yD-LR5WSQt5jwN-+T-1iWyrxovk0qZ1cb-QUO6_+Wy8Ci-A@mail.gmail.com>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <1932095.qaFFlVjcYD@bentobox>
 <CAF=yD-LR5WSQt5jwN-+T-1iWyrxovk0qZ1cb-QUO6_+Wy8Ci-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6239244.6zTq965KLP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 6/6] flow_dissector: Parse batman-adv
 unicast headers
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Tom Herbert <tom@herbertland.com>, Linux Kernel Network Developers <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@mellanox.com>, Eric Dumazet <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org

--nextPart6239244.6zTq965KLP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 6. Dezember 2017 11:54:13 CET Willem de Bruijn wrote:
> Perhaps it can even be behind a static key depending on whether any
> devices are active, adjusted in batadv_hardif_(en|dis)able_interface.

I don't like that because we don't need batman-adv loaded to simply forward 
(bridge) traffic between interfaces. And not being able to use RPS with 
multiple cores just because the batman-adv module (and interfaces) is not 
enabled seems to be counter-intuitive.


> Please implement FLOW_DISSECTOR_F_STOP_AT_ENCAP. It may
> be used in more flow dissector paths in the future.
> 
> The features are also used by GRE, which can encap Ethernet, for an example
> that is closer to this protocol.

Thanks for the feedback. I have it now implemented like in GRE.

The change can already be found in
 https://git.open-mesh.org/linux-merge.git/shortlog/refs/heads/ecsv/flowdissector

Kind regards,
	Sven
--nextPart6239244.6zTq965KLP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlooKIkACgkQXYcKB8Em
e0YOIw/+I6paHdeyQdB7Ip6fZoBJNM1UMjoOsNUUak9n2A+id4osWy/BODpWCkHd
fpZs3LUVliZUUhMHGvEvfSyBTbtlRAh6TLWq0KjOyqc9nQoMTFNVmbl3R473ttdT
0ePN2aS8u2kJIjGn2Ja4tn75wUImS09WJKgNdaUL97oXxdvmEM48N7+HfLfO7Dg/
LVbt5fULRdWIV4DCypEnEHvpUoVcTzu2seNvQch1wGxmG2zSGlUhVPLT9bWqMgcC
FcRbMXbYdGExJqjTtEXY6b7yQvfZi4xxFOghxHi8KhCtquMl1Vr7+89vxU4FArs5
vnhnsRSs3SwydA4qjpx7tTm9R8YuvyfMmebWZHPe4+8JbBE+7jV1Ek/hSnkl52ge
mrTvsYwZzf9MShY1JjVdPPc63wXpeMk81UeaUu+++TJSrb8EPrsSMo/fFbL43S/Y
igpO2tuSfTK5tZJdCLbKVPO/YHGAWjKGevc8HR+Lpwek6dm9D4v2J4vg0DgIAETT
wpLh/tjZZD9dVNnzaDUByQuulDm7VW37PwbxWiiGtGMzZEHla8JzNoCtAO5B5agh
AlcYtFK4KEillrfvvCy+l7vFautnTuOcudr0UT3o1ryHqGzVYiNKRbhoKbMi7WHj
xz3kQAzYpJlIEJ+6DI/h6FS68Eb/CdZzc1qi34iIt9DuXn7O978=
=xZBF
-----END PGP SIGNATURE-----

--nextPart6239244.6zTq965KLP--

