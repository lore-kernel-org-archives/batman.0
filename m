Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 1/2] batman-adv: BATMAN_V: introduce per hard-iface OGMv2
 queues
Date: Sun, 04 Aug 2019 12:53:51 +0200
Message-ID: <2816600.2h39cV733O@sven-edge>
In-Reply-To: <20190804042855.29327-2-linus.luessing@c0d3.blue>
References: <20190804042855.29327-1-linus.luessing@c0d3.blue>
 <20190804042855.29327-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2266715.SzqnETc6SI";
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

--nextPart2266715.SzqnETc6SI
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 4 August 2019 06:28:54 CEST Linus L=FCssing wrote:
[...]
> +static bool batadv_v_ogm_queue_left(struct sk_buff *skb,
> +                                   struct batadv_hard_iface *hard_iface)
> +{
[...]
> +static void batadv_v_ogm_aggr_list_free(struct batadv_hard_iface *hard_i=
face)
> +{
[...]
> +static void batadv_v_ogm_aggr_send(struct batadv_hard_iface *hard_iface)
> +{

Please add to these function an lockdep_assert_held for aggr_list_lock.

Kind regards,
	Sven


--nextPart2266715.SzqnETc6SI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1GuT8ACgkQXYcKB8Em
e0Y3uA/+MySn6sZeJidvvGblHqBNGITEQZ5M8KHCqhzxQb8xzF9OdsmI8hSBhZV8
poqeRvOaK8+UQhQVPLJg8359187uk90rbMZtKsaxMTS6KOvgjT91LIsDrV5rPH+9
Pd3Tbbx4YDVRVmIOgB88L2/MEbdkzrtkPu7tvSfug5ZGi/e4H5e1/xQ6pvusS/h7
wOydArvbgdQmkYjyFHfQrCEDPDzu5/mo15eKiEOeoa9aC2xgmMPOwS+5YuTZR5aS
XYz4FI1aMnS+VSVv8WwFO/jST8fFIXjbb4ZaV1BE5954AbG2UwFQ8kV1iJLJCkjo
Nn1wtdy3TAYVHeaRQYjhhb171zzSEJk9AiBWs39IvES+g03hPSn2DVUFUocIn/2x
hjIXis+o+OKs0QX83sX6c/Ex5TkekW0AQvga4AatUn5KzgCknr9XwXWALf1+EPlR
rPxrjJcA9uttHHrCMbx+LdEMG7rk9sgC8xjOhPrxk7po5iDm1Zh13vfqV8/NfAWo
zECcOXBoByGbm3ETVhpg395e8Em/Rivpctz9UY53TSbjhoYcoTDBL3AQBAOVvhm9
+bxNPSCfxiLkQVioU7UAMLZP0FC3X4EjOMpZzIfaj5NGI2xTy4bBmV57w2gkDQr2
850/shC1LmGXId5S/yMW7dtSo4qaSJ8X0i4HKuWlGz/UPBck0Hk=
=89CC
-----END PGP SIGNATURE-----

--nextPart2266715.SzqnETc6SI--



