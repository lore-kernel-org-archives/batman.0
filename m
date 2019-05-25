Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 2/3] batman-adv: allow broadcast packet type with unicast
 destination
Date: Sat, 25 May 2019 12:02:21 +0200
Message-ID: <1595745.ECTONxmloG@sven-edge>
In-Reply-To: <20190514073859.2053-3-linus.luessing@c0d3.blue>
References: <20190514073859.2053-1-linus.luessing@c0d3.blue>
 <20190514073859.2053-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5303869.HJmJbgv1N6";
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

--nextPart5303869.HJmJbgv1N6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 14 May 2019 09:38:58 CEST Linus L=FCssing wrote:
> diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/bata=
dv_packet.h
> index 4ebc2135..2ec59e4a 100644
> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
> @@ -164,6 +164,7 @@ enum batadv_bla_claimframe {
>   * @BATADV_TVLV_TT: translation table tvlv
>   * @BATADV_TVLV_ROAM: roaming advertisement tvlv
>   * @BATADV_TVLV_MCAST: multicast capability tvlv
> + * @BATADV_TVLV_BCAST: broadcast capability tvlv
>   */
>  enum batadv_tvlv_type {
>         BATADV_TVLV_GW          =3D 0x01,
> @@ -172,6 +173,7 @@ enum batadv_tvlv_type {
>         BATADV_TVLV_TT          =3D 0x04,
>         BATADV_TVLV_ROAM        =3D 0x05,
>         BATADV_TVLV_MCAST       =3D 0x06,
> +       BATADV_TVLV_BCAST       =3D 0x07,
>  };

Please submit the batctl td support for this tvlv. It also looks like the=20
mcast tvlv is also missing.

Kind regards,
	Sven
--nextPart5303869.HJmJbgv1N6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlzpEq0ACgkQXYcKB8Em
e0ZoIg//ZqFCdonzCWTv8LR93XqFrqk43ylqSjYSx+EO+9uFXdBHKbB2twNOJQrE
dsZTW+65SJ5p3eknBbhAh/sPACHZNIstb64OBy27ZXJ9Yw5SAjbHt0rGLIpNasi6
gdM9gAuJ4OqOPDO35ynZF3ryOODqVrmYh1GA3wOwIpEyXWbURdIXiipot/p5y2XT
t/+jnh3k1qga058pI1OrcVTvd+ncboGT279VEjs6nXrg1wDVkOBnaE+sMszSIQL0
9w6nt2keu2vgGG/pccNr+YUEhJA6zqV8h87PcRhOQomygH6IzEXFvIru5wg/SlEI
2zg2858u1qdDiLXGZ3cok42z9bBllXYpdG5fSHMo7b+Ns0I8vazROKVV39hpLNgI
siH2+Ge5DfXz4C6c+Wc18H785vkp2jLDRhBWAN30j8jYSnsIW+8xKGIEbAVB95g3
kmG5y7r77ChAHQ3LQcFHjckdNZepwYRJ7fUfdFEhO/VXZT9LnZuvHJVllZPJ7rPt
V3MY6u+5HpSew5JPgYPUMSuKn0HaJoTct4glSdzkxXLejiIcyWtQ19WLXTN8HfkI
vYYTjoG9zgs5Ia2XvOrD8Xz3NjtzaFaXYAIlTqKEzaevDIHWn6CddzZS9qgTjFaV
RdqHiL6rD05RDXVsvjRNisysp8qVlA8vmmKdOnCd4E9JY2Nja38=
=2wfO
-----END PGP SIGNATURE-----

--nextPart5303869.HJmJbgv1N6--



