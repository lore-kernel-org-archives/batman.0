Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 2/2] batman-adv: BATMAN_V: aggregate OGMv2 packets
Date: Sun, 04 Aug 2019 20:25:09 +0200
Message-ID: <11857632.6pTS9hhL82@sven-edge>
In-Reply-To: <20190804180632.489-3-linus.luessing@c0d3.blue>
References: <20190804180632.489-1-linus.luessing@c0d3.blue>
 <20190804180632.489-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11342170.1yEyJuSppn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart11342170.1yEyJuSppn
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 4 August 2019 20:06:32 CEST Linus L=FCssing wrote:
>  static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
>  {
> -       struct sk_buff *skb;
> +       unsigned int aggr_len =3D hard_iface->bat_v.aggr_len;
> +       struct sk_buff *skb, *skb_aggr;


Please don't declare multiple variables per line.

Kind regards,
	Sven
--nextPart11342170.1yEyJuSppn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1HIwUACgkQXYcKB8Em
e0ZH5hAAufmvcKaPKnXgklG+awQXUJCYoIObyvDx3cxqdal7POCZkZM6akZ5Ev+3
KVyfYGLUYVfZBmU9BboI3278nWttMe+CWBSLzUicukJPhDmJ3vaZ/4Bk0StBgQjt
KLlNs48WWhIiq7XqH0h0Ezi67ubExBTOP1lQgpoDtdxHU7ckdszaE9xH010WrQQD
dJJajluRwCpPOoAMFaSqdai0YQ64xiE5/w7N3wR1BRKF5FL4Mk41yrSbSRGyEEvS
oVjZadkKdBFPf84i8Nfv51DYEBQXLgOsEgUGh5+v7aIB64YBQNuzfkBps44KVZZ9
bu7KXD1BKB3s/tsfdjbRgl/utkv95KEWwmolUSrQDN1gUTpCMa1K666Dwq9mrrBU
GU74fUVHwcMFgIA2sE5vs+b9N+5xymWkZOYaxy9UNlNeZecb/7DAh8e4n7AaywSE
mpYUIs83Y/fg1vEph+LbRWwweU4WqB4SK7ZKckvPupAXitu86qFsNde3zlxlyqeV
UEGwuZRFGzMgX072dVbkJqqZBDWyM1wY+RGMf/v6eKv8oUIAGw7fiQTQGZE/6p4m
kA0B6CejPfvxB2jycjKer8s2fRGKvtLrpGAe87+302UaSvRacrhYjsbWffjwG+eJ
/RosVDyi5LjkHLKua52sKb4PThBR2su1bYCStzG9eqKHIeAuRG8=
=m2na
-----END PGP SIGNATURE-----

--nextPart11342170.1yEyJuSppn--



