Return-Path: <a@unstable.cc>
Date: Thu, 3 Mar 2016 05:36:01 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160302213601.GI7704@prodigo.lan>
References: <1456492666-29672-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline
In-Reply-To: <1456492666-29672-1-git-send-email-apape@phoenixcontact.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/7] batman-adv: prevent multiple ARP
 replies sent by gateways if dat enabled
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


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andreas and thanks for your work on this topic :)

please find some comments inline

On Fri, Feb 26, 2016 at 02:17:46PM +0100, Andreas Pape wrote:

=2E..

> +bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv,
> +				   u8 *addr, unsigned short vid)
> +{
> +	struct batadv_bla_claim search_claim;
> +	struct batadv_bla_claim *claim =3D NULL;
> +	struct batadv_hard_iface *primary_if =3D NULL;
> +	bool ret =3D true;
> +
> +	if (!atomic_read(&bat_priv->bridge_loop_avoidance))
> +		return ret;
> +
> +	primary_if =3D batadv_primary_if_get_selected(bat_priv);
> +	if (!primary_if)
> +		goto out;

do you really need this goto here ? I think you can just return ret.

This way you can avoid the blind initialization of claim and primary_if and=
 you
can also remove the 'out' label at all.

> +
> +	/* First look if the mac address is claimed */
> +	ether_addr_copy(search_claim.addr, addr);
> +	search_claim.vid =3D vid;
> +
> +	claim =3D batadv_claim_hash_find(bat_priv, &search_claim);
> +
> +	/* If there is a claim and we are not owner of the claim,
> +	 * return false;

no need for the ';' here :)

> +	 */
> +	if (claim) {
> +		if (!batadv_compare_eth(claim->backbone_gw->orig,
> +					primary_if->net_dev->dev_addr))
> +			ret =3D false;
> +	} else {
> +		/* If there is no claim, claim the device */
> +		batadv_dbg(BATADV_DBG_BLA, bat_priv,
> +			   "Handle claim locally for currently not claimed mac %pM.\n",
> +			   search_claim.addr);
> +
> +		batadv_handle_claim(bat_priv, primary_if,
> +				    primary_if->net_dev->dev_addr, addr, vid);
> +	}
> +

=2E..

> @@ -1000,6 +1001,20 @@ bool batadv_dat_snoop_outgoing_arp_request(struct =
batadv_priv *bat_priv,
>  			goto out;
>  		}
>=20
> +		/* If BLA is enabled, only send ARP replies if we have claimed
> +		 * the destination for the ARP request or if no one else of
> +		 * the backbone gws belonging to our backbone has claimed the
> +		 * destination.
> +		 */
> +		if (!batadv_bla_handle_local_claim(bat_priv,
> +						   dat_entry->mac_addr, vid)) {

I like the approach you take to fix this issue, however I don't understand =
why
you want to "manually" claim a client.

If I recall correctly, a backbone node
will try to claim a client only if the latter tries to use such node to ent=
er
the LAN.
In this situation the client may never use this backbone to enter the LAN (=
i.e. bad
metric towards this node) and therefore we are forcing a claim that is not
correct.

Simon, what do you think ?

Imho it is ok to *not* reply to the ARP request is the client is not claime=
d,
but I don't understand why claiming it now.


> Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmo=
nt
> USt-Id-Nr.: DE811742156
> Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
> Gesch=E4ftsf=FChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
> ___________________________________________________________________
> Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte Infor=
mationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrt=
=FCmlich erhalten haben, informieren Sie bitte sofort den Absender und vern=
ichten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige Verwe=
ndung sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
> -------------------------------------------------------------------------=
---------------------------
> This e-mail may contain confidential and/or privileged information. If yo=
u are not the intended recipient (or have received this e-mail in error) pl=
ease notify the sender immediately and destroy this e-mail. Any unauthorize=
d copying, disclosure, distribution or other use of the material or parts t=
hereof is strictly forbidden.

Are you sure this footer does not conflict with the GPL ? Not sure how impo=
rtant
this is, but I'd rather not send it along with patches.
However, if you use git-send-email this footer should not appear at all.


Cheers,


--=20
Antonio Quartulli

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW11zBAAoJENpFlCjNi1MRLwgP/jAlB5jZGkBETmEt2xH/2kRC
SR6Ia1h6vjaMhFe7/X1DT/xf3OskQk3heV9fnppcDnkhSuVUOL/gI6EBwkwjJuZ8
Wu4B+F4Tg4b4kTRDIbxYKjXUb1Hs3TYapA+9b8g3KUxrOAPf2v8rqmicyccWT89f
9/UjSTSirDYSXMbRJHBPM9hAeiWmjoBjMi8tjzRO0GL5EGS/oZWfHQIHzGetRPvg
XImIIYhscSpAETh46b1IGtFysgtXFeBz2wWxy4mYQkZ17b3gHD+NLEeQ2cB1sfcs
exB/reJanj8tDGGudDfR2s+XtOvEetoVJL06CIZYHAzRGSQsFM7QeyVzLatwjJ7N
ZtSZ/z+x3O5GxNi6WngdryDwDo7Lpfr/C36GOK2M4/UoVzD87PqMOY8m0zNrzWoV
E0RYbEWHoKL3JHOvNixYd+CbikahR8akl/Sz1A/JrKe6Gvtf+Be66u0mzCVgv4HY
Za87boXW3wUU/dRBdBnPBPZFNB8flgliEjjwMT8EFNqnBrNmFs0aQyQi9IWhpsnx
sdQA/pAiCAiLNIXOqkIRhJw9KqeRMRjrlSMTmnETTHZmK563kEJMgcLDKUgOaUwd
/p2IIcJdCB/pd0XAP92UKIoeUsyCiCZvT6G7/HYMgXzgl0lWkYv/3KPxK2eW+Z+M
4Towza32LTw2ldnc9+bo
=c5dr
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--
