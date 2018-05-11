Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 May 2018 15:12:01 +0200
Message-ID: <3502293.18K6qFWs9T@sven-edge>
In-Reply-To: <4477321.n6vKnkidQF@sven-edge>
References: <20180510174428.8646-1-linus.luessing@c0d3.blue>
 <4477321.n6vKnkidQF@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1662740.l4Y9KIIn2A";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 maint] batman-adv: Fix TT sync flags
 for intermediate TT responses
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

--nextPart1662740.l4Y9KIIn2A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 11. Mai 2018 08:13:09 CEST Sven Eckelmann wrote:
> On Donnerstag, 10. Mai 2018 19:44:28 CEST Linus L=FCssing wrote:
> [...]
> > + * @flags: a pointer to store TT flags for the given @orig_node and @e=
ntry to
> [...]
> > + * @flags: a pointer to store TT flags for this client to
> [...]
> > + * @flags: a pointer to store TT flags to
>=20
> Antonio wanted to have some changes here. From IRC:
>=20
> <ecsv> ordex: any objections to T_X's last patch version? https://patchwo=
rk.open-mesh.org/patch/17355/
> <ordex> hm is this correct: "@flags: a pointer to store TT flags for the =
given @orig_node and @entry to" ?
> <ordex> entry to ?
> <ordex> the rest looks ok
> <ecsv> maybe "@flags: a pointer to store TT flags of the given @orig_node=
 and @entry" is better ?
> <ordex> ecsv: maybe ""@flags: a pointer to store TT flags for the given @=
entry received from @orig_node"

Added as d65daee8617b [1] with the requested changes to the @flags=20
documentation from Antonio

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/d65daee8617b29c1ddcc949=
ce3a5ec24f7a1e1af
--nextPart1662740.l4Y9KIIn2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr1lqEACgkQXYcKB8Em
e0b/QA/+IGfU8djhznQTV9FqF73my4BvZ6VYeHvzYg+9iaWEeuqsdH4hpW2h9eZ+
LGCjVigsD0nkKtWD2BquDmk0jRAxSfm5xBc135ijM9TcDwehOukDi2wlhyWfiwQ8
O5zI4rB7VHRTw2wQzAa4H8YTEXXtEVEOn0kRceiMfYuE+35X4akZrndlYyE0Fdqd
2GGCl/g36v8Efcv//3eWdRgehnEeIP9oEmE0e/6M4VE4UoktFUEpxvk3DKi9Rjm+
ADV9xSphx1ydxbdNp8C5bZt6H8b72ggSHGwreuJQwce6peJHDvYLoH2L+93tIGcR
uUdKKRv8qf7k13VAlUlMR2BQY3la3V+gGixALUEWGvfsWEAlqiaWZqyFakPgdBcJ
KUC1c72f09o7c9KqH1ccVY+avm/67VrnH+FL1zDFKsIngSo4yDvpVvmIZ+wKVX7U
QBFr+fa2XKuZqC/Lu/iprAPAG5hCFFdgYG9MaU4D2LriamQ3CLLu7hlQnARLV5nm
JcNUnhwL9IFAVf6mFqK3mCI/boUDrvCMx+Pf+RNRDEhChmmkKsNooCUGVz4Xk/8j
nwvF6OVTfzfFBVPjaSCDLBz+bSzHyDq/BDf7YVLCwdBHQLQFriG5VWobScryQ5N5
Ut8MRQj4EcNajnaaiWr+VXHrkroVjc1bexE7uiN8eaJmwd4603U=
=k3Hx
-----END PGP SIGNATURE-----

--nextPart1662740.l4Y9KIIn2A--



