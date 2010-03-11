Return-Path: <linus.luessing@web.de>
Date: Thu, 11 Mar 2010 22:41:36 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100311214136.GA13625@Linus-Debian>
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
	<1268342346-13713-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <1268342346-13713-1-git-send-email-linus.luessing@web.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry, typo there, has to be ">=3D" and not "<=3D" of coures. My
fault.

On Thu, Mar 11, 2010 at 10:19:06PM +0100, Linus L=C3=BCssing wrote:
> When the seqno for a vis packet had a wrap around from i.e. 255 to 0,
> add_packet() would falsely claim the older packet with the seqno 255 as
> newer as the one with the seqno of 0 and would therefore ignore the new
> packet. This happens with all following vis packets until the old vis
> packet expires after 180 seconds timeout. This patch fixes this issue
> and gets rid of these highly undesired 3min. breaks for the vis-server.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  batman-adv-kernelland/vis.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/batman-adv-kernelland/vis.c b/batman-adv-kernelland/vis.c
> index fa8a487..5735a6a 100644
> --- a/batman-adv-kernelland/vis.c
> +++ b/batman-adv-kernelland/vis.c
> @@ -213,7 +213,8 @@ static struct vis_info *add_packet(struct vis_packet =
*vis_packet,
>  	old_info =3D hash_find(vis_hash, &search_elem);
> =20
>  	if (old_info !=3D NULL) {
> -		if (vis_packet->seqno - old_info->packet.seqno <=3D 0) {
> +		if (vis_packet->seqno - old_info->packet.seqno
> +		    <=3D 1 << 7 * sizeof(vis_packet->seqno)) {
>  			if (old_info->packet.seqno =3D=3D vis_packet->seqno) {
>  				recv_list_add(&old_info->recv_list,
>  					      vis_packet->sender_orig);
> --=20
> 1.7.0
>=20

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLmWOQAAoJEBKw7u43QNpffCYQAKQR+O+0/E3Gus3C7aYNt+jH
mrN3+/SUry3nSjZBvInxUAo3+uMaLSqeupaYBd86+o0FLEE6mmMkXdlOoHaYn1Dr
3iU4bh4gh5Fm4vPpjaYTl9dTvBjg4LnMKcCOuvUn906Rw3uRvC+qLQyHZI9uz3JA
iwyc0izwwImuACdsKaBM9iWcn7RVDJc12/oukvoaU0hDu15otAIorL/QfmTgVN/o
kn+I2/HDLmqGMU9DAwYHkmgeEUops7KTRqMJjJUiwevGzNb76cCgrPom9ZHYs+6c
pJasVArrgfvALfs2VsMvBhQGL4yypfayLE5OVGKKVgnv/03fJ9yZw+4ihs7B2tsW
0p/o7prtPCDsPak0AYEyOTqJ3SBND2YlrsNWYdbRuKdrfbg8cc/5efX+GGgHPDnT
yDtqUJF6jZ3qFwViVLL2JWQxIj+KP0vUK2GmwT9WLVT9Af+feA0UxuOHXzo6fEdh
VjxUASDWJv8+Ln/8nKb/OMSvRz5hnRykXXntsqdPbE9HsRPpJ1enc81qtlgpvcBf
I88PORYlXHh6hm6E2dG4Yqjt7EeS1VH8WveCKD8ZSqoYZwW9DWRWrZqK7lIHecq3
9YVsvnsHmNsDyYAZN0HwI4edLWW+k9IW6huBOWSBShzzxjEXRRjpc69idik38L+v
V0GrJxtjfTDEGvadQqAh
=ggw+
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
