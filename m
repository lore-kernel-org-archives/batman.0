Return-Path: <ben@decadent.org.uk>
Message-ID: <1341111646.4852.70.camel@deadeye.wl.decadent.org.uk>
From: Ben Hutchings <ben@decadent.org.uk>
Date: Sun, 01 Jul 2012 04:00:46 +0100
In-Reply-To: <1341003484-8457-1-git-send-email-ordex@autistici.org>
References: <1341003484-8457-1-git-send-email-ordex@autistici.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-sHYs0ZuTuAP+Kf419u3S"
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2 stable 3.1-3.2] batman-adv: fix
	skb->data assignment
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org


--=-sHYs0ZuTuAP+Kf419u3S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-06-29 at 22:58 +0200, Antonio Quartulli wrote:
> commit 2c995ff892313009e336ecc8ec3411022f5b1c39 upstream.
>=20
> skb_linearize(skb) possibly rearranges the skb internal data and then cha=
nges
> the skb->data pointer value. For this reason any other pointer in the cod=
e that
> was assigned skb->data before invoking skb_linearise(skb) must be re-assi=
gned.
>=20
> In the current tt_query message handling code this is not done and theref=
ore, in
> case of skb linearization, the pointer used to handle the packet header e=
nds up
> in pointing to poisoned memory. The packet is then dropped but the
> translation-table mechanism is corrupted.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Hello,
>=20
> the patch committed upstream already contains Cc: stable@vger.kernel.org =
but
> that patch does apply only on 3.5, 3.4 and 3.3.
>=20
> This patch is a backport for kernel versions 3.1 and 3.2
[...]
> --- a/net/batman-adv/routing.c
> +++ b/net/batman-adv/routing.c
> @@ -1246,6 +1246,8 @@ int recv_tt_query(struct sk_buff *skb, struct hard_=
iface *recv_if)
>  		/* packet needs to be linearised to access the TT changes */

Interesting context; the spelling of 'linearized' doesn't match and the
line numbers are way off. :-)

But OK, I've added this to the queue.

Ben.

>  		if (skb_linearize(skb) < 0)
>  			goto out;
> +		/* skb_linearize() possibly changed skb->data */
> +		tt_query =3D (struct tt_query_packet *)skb->data;
> =20
>  		if (is_my_mac(tt_query->dst))
>  			handle_tt_response(bat_priv, tt_query);

--=20
Ben Hutchings
If you seem to know what you are doing, you'll be given more to do.

--=-sHYs0ZuTuAP+Kf419u3S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAT++9Xue/yOyVhhEJAQr/IBAAjjL2AsS3LyWjyqR+4IuDIUlZBXRIY317
xRFDwubjlBe27Irm4ezgQvHTgmFd3sXW2qAUdhsibyoAINykgrHx8TDmW0y1MBxB
CVN8DXLed+MNJCNRPIlMGDQ1f4JR7c0zrZRcEAnLSu19RKvCpqCNUXIU3UICrV1Z
QAlupLLMS2tm6zp+JTESA4TRAFGSddiFuAtyg0ybaWSyt/G61EeX+N+Oe/7nh/Rw
B5x8f+rFoywsrc/DoJVSMDF53BcQX1YzwusntyW+bgXsiEVKcBrvqTZ+b8GUisQL
mOLlgQwjMkIArkrvwrTjTMdnpuhVJUqRvuGGjgOWAFwwU4WEMIhki7PKRkzCD4ht
08v60d76DvXVTfOK1piR6z6JMHbYIZO9ggCpYTV+QAUobfrk+vcwERODHKRHzJ6x
FXBv0nwSYRPvnJLzsFvV2MVB1OEfOEtzzMicvDV2y1troqeKoP70t7JP+aFCa6Ba
VlZxLdJjrCgKGG454atq3B5gQrCwUtiECo8/Rdk+re+K6zaCpAXGoF5Vml4nDvmX
QC8qKYKZeKzGg2UvNF/RZ8YLEUopWjP33Hg2cXGGQDSKXaSsXvpCS0AupuH7ACaE
7UAvRFGYHZXqLbMUS2mrnYfDm1p5scXwGH/ACdeZmf66zsA57kZtOFZ5jDRgPKqy
QvJA6JC6Ybk=
=OiR5
-----END PGP SIGNATURE-----

--=-sHYs0ZuTuAP+Kf419u3S--
