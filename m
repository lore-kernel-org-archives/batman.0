Return-Path: <a@unstable.cc>
Date: Wed, 18 May 2016 10:16:11 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160518021611.GG12056@prodigo.lan>
References: <3413869.lrcFurLlMu@bentobox>
 <1463506353-11676-2-git-send-email-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Content-Disposition: inline
In-Reply-To: <1463506353-11676-2-git-send-email-sven.eckelmann@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH v9 2/2] batman-adv: throughput meter
 implementation
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


--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2016 at 07:32:32PM +0200, Sven Eckelmann wrote:

[...]

> @@ -58,6 +59,7 @@ static void batadv_socket_add_packet(struct batadv_sock=
et_client *socket_client,
>  void batadv_socket_init(void)
>  {
>  	memset(batadv_socket_client_hash, 0, sizeof(batadv_socket_client_hash));
> +	batadv_tp_meter_init();

Sven,
one very last question (sorry for not spotting this earlier): if we don't h=
andle
the TP meter with the icmp_socket anymore, why do we tight the TP initializ=
ation
to the socket initialization ?

Is there any reason to have it here ? Or we should move the
batadv_tp_meter_init() call to somewhere else ?

[...]

> +/**
> + * batadv_netlink_tpmeter_notify - send tp_meter result via netlink to c=
lient
> + * @bat_priv: the bat priv with all the soft interface information
> + * @dst: destination of tp_meter session
> + * @result: reason for tp meter session stop
> + * @test_time: total time ot the tp_meter session
> + * @total_bytes: bytes acked to the receiver
> + * @cookie: cookie of tp_meter session
> + *
> + * Return: 0 on success, <0 on error

you forgot the space between < and 0 ;P but if the rest is ok, I am sure Ma=
rek
could add it :)


The rest looks good. Thanks !

--=20
Antonio Quartulli

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXO9BrAAoJEJ4aZjxxc6bKi2gP/A16eRw+qgv9/spTioznJLfT
RTYcBI6TooSpqJ9YnAgsA6C+HhlwkACb7EYHGTi6QQYUl1wjZv+u7sILbOsglO7g
NXL4JQCAqV4Eu16Dp5N+WL8jVOZ+5hiPXd2hzRei80Cf9tb99l8JgyCAzIFnrspG
6XAMbCoZVW4xBeRDmvjGRQ6sfPgowkP9QJUb4Ou0LjAD7K2ItnjCosrifV0G/doS
m7qQ3hWxHRVuIYhZCjybo7WAH+mMmIiNd9hcjz+brUciH8+sswQTkmDEcq+O3nh/
ANPamNTvmiLx39Ne/hkm0PiXYBzKpLqo4Q3t7FzuvVDrVDn2vsVd2lmwyoL810T5
miTxBqyXxkbQ562rA9VrFXwlhHIwSTU/0Zdu+4fYETx3SjZ3uHrV/AVTFPWj9Ezm
tGwezJPK2l0CwBk6rjY27FRtZBX248W8hcRxo+MXQQJ4ieovMxngZs0tUGMiB4Uu
hMfJn7Q+MygF+pwozLiO94f0UUbV2EOZgvfgyIhnd0aYF4fEKgFNLpjkY9aR3scr
QideWubHp4CF6LC5sTAtrI2qcBTai64auKNEAuFSYkRCoMFNfuoUR/4K/1/zFjRh
gMokysRqxfa6ww/4waFWtWEo09fvmNKK2wIwU9bqBVQ9R7Kq786+SAfK67fg5ahf
nBf/7iH7xfkYfg5d4HMw
=HD1F
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--
