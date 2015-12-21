Return-Path: <a@unstable.cc>
References: <ab66a344512e064000357c6d3c2a6f3d0e948ddb.1450451516.git.geliangtang@163.com>
 <b01d3ee936833e94fffa53f7a82fc46e20d877c1.1450451516.git.geliangtang@163.com>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <56780FDF.10204@unstable.cc>
Date: Mon, 21 Dec 2015 22:42:39 +0800
MIME-Version: 1.0
In-Reply-To: <b01d3ee936833e94fffa53f7a82fc46e20d877c1.1450451516.git.geliangtang@163.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6X948h2CMWjxusk3cplXFHpJDsWael4Ev"
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/14] batman-adv: use
	list_for_each_entry_safe
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Geliang Tang <geliangtang@163.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6X948h2CMWjxusk3cplXFHpJDsWael4Ev
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

>  static int batadv_socket_release(struct inode *inode, struct file *fil=
e)
>  {
> -	struct batadv_socket_client *socket_client =3D file->private_data;
> -	struct batadv_socket_packet *socket_packet;
> -	struct list_head *list_pos, *list_pos_tmp;
> +	struct batadv_socket_client *client =3D file->private_data;
> +	struct batadv_socket_packet *packet, *tmp;
> =20

[...]


> +	list_for_each_entry_safe(packet, tmp, &client->queue_list, list) {

I guess you renamed those variables to make sure that the statement
above would fit in 80 chars.. in that case the patch looks good.


Acked-by: Antonio Quartulli <a@unstable.cc>


--=20
Antonio Quartulli


--6X948h2CMWjxusk3cplXFHpJDsWael4Ev
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWeA/jAAoJENpFlCjNi1MRrgsP/2Y3mG/Hcl8TNBl4fyhVPGaB
JtgpLbjrHblGgb2NHfWnPl/a1N/yGLolFF/QCXf5IHN2p8QcZW44g33Bxfo84342
2tJ5OA6RwT1OKEm8/D3yxE9edt0TPwxGoGEKx2HxZlZGUvm5XdH3BYDjrGsvNBpK
xttL/RvS0QtjsofWJX4U5IaAIeeF9sVXE0758QDiStG6ZL6zVqYHLo1FqMQIfC7K
neIrBeUC3B75SgwuLRgkzZZ8LQNitFcPmVexL6LKJ+MfB9unIBHk5dVkVtZUdk9J
+3kQksWmUqjDpqK2kPgfUj5+wiIjbE/YRmmmp1UVVQYgDIUO9map1DpsnKgPiKWC
P72FxQ5Wu1cALNCeuuAOlxTwB78RoQonjbf43PgbES7m/qXXyhgWmbZ+ulH04IqQ
F1PygBJ8hgyhuSVcn6ECqJrVo4Q4Za2zC/0CZCmA+5jaj8EInXvEc6IX7Y8abkkQ
AiBer0r8eHQVJEo/oUxh91hD2Qt28B2QAlNLhW6heZ+REO/ufcpINQ3KdswHWH1f
YhggNdkiaqCwVfj96/OMwwu5hMXD4E7jZS2BGpi2aRzGqtGj3zVp7mWaUj0XqKX3
I5A8it6ycUHBTNBU+66u0DUHtWQimLH9a+aX9Ek4zP9qwPR9RUEZwolD8P2duglS
Xn8t9vzsBn82PoQ6pSN8
=Of5E
-----END PGP SIGNATURE-----

--6X948h2CMWjxusk3cplXFHpJDsWael4Ev--
