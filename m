Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 1/3] batman-adv: bcast: queue per interface, if needed
Date: Sat, 25 May 2019 12:21:32 +0200
Message-ID: <3044203.LVLg11BY96@sven-edge>
In-Reply-To: <20190514073859.2053-2-linus.luessing@c0d3.blue>
References: <20190514073859.2053-1-linus.luessing@c0d3.blue>
 <20190514073859.2053-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart53774336.mO2rgM72tr";
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

--nextPart53774336.mO2rgM72tr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 14 May 2019 09:38:57 CEST Linus L=FCssing wrote:
> which we only broadcast on once the queueing induces an unncessary

unnecessary

>  /**
>   * batadv_forw_packet_bcasts_left() - check if a retransmission is neces=
sary
>   * @forw_packet: the forwarding packet to check
> @@ -811,28 +1031,20 @@ int batadv_add_bcast_packet_to_list(struct batadv_=
priv *bat_priv,
>   * Return: True if (re)transmissions are left, false otherwise.
>   */
>  static bool
> -batadv_forw_packet_bcasts_left(struct batadv_forw_packet *forw_packet,
> -                              struct batadv_hard_iface *hard_iface)
> +batadv_forw_packet_bcasts_left(struct batadv_forw_packet *forw_packet)


/home/sven/tmp/qemu-batman/batman-adv/net/batman-adv/send.c:1191: warning: =
Excess function parameter 'hard_iface' description in 'batadv_forw_packet_b=
casts_left'

Kind regards,
	Sven
--nextPart53774336.mO2rgM72tr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzpFywACgkQXYcKB8Em
e0ahpQ//Y+oUcbv6Co+AxEoeoryFFUU+2H504TI9AEvhufR1MKGE+RhFsPeFuuRg
vQfQPVM3ZoHZOagC/VbdvjZ8Q+tXYhMpog3r9cUcXjDDvIJD7FEC3Loxnn6KxuIB
x+08Zps3gQ6guGNDWlua83ifXSwZKRrOybldKDG5YG9nHCiNhHE1orWJAlTEc0gj
nUyy1m0Duk3p/jPfSoYHoqpMvdrmhrOokc84ym5Shhdu9UCMJLRNx02e2HzGFn9V
C39lfXURBhMBpqk6tbfnPUNcRHDcUBbMgElN2RFa4GSOBmUX1vVKU+dcoTvnmHHL
dC+WgZANUyYH7UN3Ee8CTDquB6Ipc4Z3J476uvWNglNEe6IUMh/5S6DZhhGE5Fn7
XlldzyfARfECUE9yg8NNc0pPfxuMiEvUCofZ/mhvE/x/doaAzMolaBlWGTjKMy7y
dUs4zhq7SH7Pagl1L4vlv6YaqtBfY9gRbuIPvR81iCKlAG3H2go4qSctoqqF+/7U
lgH+Vl1tAoyQ8r24eGHXJpI71dbOx+CsmQgyT4eyVFYwt3o1+stPDNJuNTfk0t14
WzRqyLAsNO7fhlCPfWZnvY8IaZda8/qADY1sBOVSE6XN2hgks5+Z/0/ftQ5aKb5/
9meXPDlBfVL4Q925rSngf7TS2qQzRZVygvoHqsHIPEcXKxnvY5o=
=Zsy0
-----END PGP SIGNATURE-----

--nextPart53774336.mO2rgM72tr--



