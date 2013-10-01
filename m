Return-Path: <antonio@meshcoding.com>
Date: Tue, 1 Oct 2013 11:00:09 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131001090009.GD1448@neomailbox.net>
References: <1378312060-30922-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <1378312060-30922-6-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <1378312060-30922-6-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] [RFCv2 5/6] batman-adv: consider outgoing
 interface in OGM sending
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2013 at 06:27:39PM +0200, Simon Wunderlich wrote:
> @@ -574,6 +562,13 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_=
packet *new_bat_ogm_packet,
>  		if (!primary_if)
>  			goto out;
> =20
> +		/* packet is not leaving on the same interface.
> +		 * TODO: some other parts here could be reworked as the
> +		 * outgoing interface is specified now.
> +		 */

What does this TODO exactly mean? What could be reworked?

> +		if (forw_packet->if_outgoing !=3D if_outgoing)
> +			goto out;
> +
>  		/* packets without direct link flag and high TTL
>  		 * are flooded through the net
>  		 */
> @@ -620,6 +615,7 @@ static void batadv_iv_ogm_aggregate_new(const unsigne=
d char *packet_buff,
>  					int packet_len, unsigned long send_time,
>  					bool direct_link,
>  					struct batadv_hard_iface *if_incoming,
> +					struct batadv_hard_iface *if_outgoing,
>  					int own_packet)

ehm, kerneldoc?

[...]

> @@ -1449,6 +1489,10 @@ batadv_iv_ogm_process_per_outif(const struct ethhd=
r *ethhdr,
>  					  if_outgoing, tt_buff, dup_status);
>  	rcu_read_unlock();
> =20
> +	/* don't forward packet if no outgoing interface was specified */
> +	if (!if_outgoing)
> +		goto out_neigh;

can this really happen? or does it mean we have a BUG?

> +
>  	/* is single hop (direct) neighbor */
>  	if (is_single_hop_neigh) {
>  		if ((batadv_ogm_packet->header.ttl <=3D 2) &&
[...]

> @@ -539,9 +542,12 @@ void batadv_send_outstanding_bat_ogm_packet(struct w=
ork_struct *work)
> =20
>  	/* we have to have at least one packet in the queue
>  	 * to determine the queues wake up time unless we are
> -	 * shutting down
> +	 * shutting down.
> +	 *
> +	 * only re-schedule if this is the "original" copy.
>  	 */
> -	if (forw_packet->own)
> +	if (forw_packet->own &&
> +	    forw_packet->if_incoming =3D=3D forw_packet->if_outgoing)
>  		batadv_schedule_bat_ogm(forw_packet->if_incoming);

What do you mean with "original" copy? Can an "own" packet have if_incoming=
 !=3D
if_outgoing?


Cheers,

--=20
Antonio Quartulli

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSSo8ZAAoJEADl0hg6qKeO+acP/RHY2fFmBLRSN3Wd6jM2ogMD
i8Peb0ZWZhdrOvWtZW8n0RVKxSqctRajHmqQDIreTxJz6V0xu8c23hS9bzZphzdj
6eYI+dg/6xA2EUVr3bMIlAoHMnWPtfqAa2oDKUz+YBT7yPRWpsIQmhZ2rDBxoC68
YIcXCyon4mSiBkkyssw3eZyNg9CVESMbbs0aY0azeXwjSDGdJjLCarDaIX1dGAs+
5ClATiF6fR4wvTZCj0gtmlPL+nUB8WkZ+jF8SA43Kftq8bD+paEuBaDo2sRb0Yfv
ZpcHwgVq16/8/3Z4f8LVBMPHSs/75qeOSBUU6XEq6mJ9KI4gsF1JiK+3SzBAED+v
rtar0AEwtKk3DIBt2KTQfa6+eH4bY0sk1lOwjrW5CVwx21fc9htZ9UStUunV51Dh
oAVlg/hihUIXDQ5P8RQoIonGw8jEOF9ML2eJMvrzE4UOuyaDWejnnZWg/VSuY9sN
AXlRoMMiFkezg5l1YO9Tn0O1vHbg42ncxEK84yoCAehaBaIEqAL4d7ZILoyvUODX
RTnbqu1Fr2dkLxMku1tmsi/9laoZijGIBIX+VR9mQpuzFUwWroMG89VTutbDjOhu
Fzy3gJCQYp32ccZDkNTs0sZW0iRhtDm9phM9td2B+jg2IggNbT/d+F+Ikq+NXa2o
0cd4lehjfwxwj0JXoAjy
=G4NL
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
