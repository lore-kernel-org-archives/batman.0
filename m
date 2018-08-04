Return-Path: <a@unstable.cc>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
 <20180521144854.GO7162@otheros>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <7a8296d8-d9e2-bba3-f8cd-42cf5da4f506@unstable.cc>
Date: Sat, 4 Aug 2018 17:39:42 +0800
MIME-Version: 1.0
In-Reply-To: <20180521144854.GO7162@otheros>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Tduv9NIV1KBc7PuKGVLFv6w2cduFmHVKp"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tduv9NIV1KBc7PuKGVLFv6w2cduFmHVKp
Content-Type: multipart/mixed; boundary="imPvgsZsj8zqBygoB8bg3WXNPG0szoeTR";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?=
 <linus.luessing@c0d3.blue>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Message-ID: <7a8296d8-d9e2-bba3-f8cd-42cf5da4f506@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
 <20180521144854.GO7162@otheros>
In-Reply-To: <20180521144854.GO7162@otheros>

--imPvgsZsj8zqBygoB8bg3WXNPG0szoeTR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Lunus,

On 21/05/18 22:48, Linus L=C3=BCssing wrote:
> On Fri, May 18, 2018 at 09:47:53AM +0800, Marek Lindner wrote:
>> +/**
>> + * batadv_v_elp_tp_start() - start a tp meter session for a neighbor
>> + * @neigh: neighbor to run tp meter on
>> + */
>> +static void batadv_v_elp_tp_start(struct batadv_hardif_neigh_node *ne=
igh)
>> +{
>> +	struct batadv_hard_iface *hard_iface =3D neigh->if_incoming;
>> +	struct batadv_priv *bat_priv =3D netdev_priv(hard_iface->soft_iface)=
;
>> +
>> +	neigh->bat_v.tp_meter_running =3D true;
>> +	batadv_tp_start(bat_priv, neigh->addr, neigh, 10, NULL, BATADV_TP_EL=
P);
>> +}
>=20
> This seems racy here? We have no ordering constraints between
> the assigment and batadv_tp_start() which might lead to...
>=20
>> @@ -152,6 +192,25 @@ static u32 batadv_v_elp_get_throughput(struct bat=
adv_hardif_neigh_node *neigh)
>>  			return throughput * 10;
>>  	}
>> =20
>> +fallback_throughput:
>> +	last_tp_run_jiffies =3D jiffies - neigh->bat_v.last_tp_meter_run;
>> +	last_tp_run_msecs =3D jiffies_to_msecs(last_tp_run_jiffies);
>> +
>> +	/* check the tp_meter_running flag before checking the timestamp to
>> +	 * avoid a race condition where a new tp meter session is scheduled
>> +	 * right after the previous tp meter session has completed
>> +	 */
>> +	if (!neigh->bat_v.tp_meter_running &&
>> +	    last_tp_run_msecs > BATADV_ELP_TP_RUN_INTERVAL)
>> +		batadv_v_elp_tp_start(neigh);
>=20
> ...multiple instances potentially being started at the same time here?
>=20

- batadv_tp_start() is only invoked by batadv_v_elp_get_throughput();
- batadv_v_elp_get_throughput() is only invoked by
batadv_v_elp_throughput_metric_update();
- batadv_v_elp_throughput_metric_update() is a periodic function
executed by a timer and we can't have concurrent executions (unless we
use crazy interval values).

Maybe we should add a comment to make this more clear?



--=20
Antonio Quartulli


--imPvgsZsj8zqBygoB8bg3WXNPG0szoeTR--

--Tduv9NIV1KBc7PuKGVLFv6w2cduFmHVKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltldF4ACgkQB6U8WA7y
zXRklxAAwXTa5Rcx9Aic11WuApkkcy3LO2TRYJF6V4tcEZQCdMzljMh7WJX1b1Fl
tLMT6qAvRdh+Mp8PcdTZuwcvFOd600Dm2BYBSR0N7d5x51YRsGlQTHn+H6XTNC4G
/6mYRz8kWN/wUIu2yOQicF6+N8iBD9qYvldgG8qRJogiTPSwklo5akGF997Zyo2W
p9T8z7P837+VGWyVMj8Xe+ge3k9Plj8TZhE92WHVdaVb2RGJe92wd1dpQYA1AVHG
WITVgiYW5Ul/CxQJNY0eQpwaVxX25kLqmBES/nAQBgxUASSRUspCLa+n7SAr5Rs3
PgvS0nGlM+CFPh3VbByTdZnRC6y+yQ5ZEwxyg5IB+tUcDvHG+0A6v5ccYROLusJf
X6H42qI9iuyEMmH5ZR+WpSIBc2n7R+7YrH2SD/ugj2dIBUprB2omQSN067k9iq67
0IYLnCmjunBXa3QV7D89QLGzsPH7mlZTlADbgf0ORfK/fi7/dXIKnQBBivPPfQRW
P/tQSBJNnraCTHI5qotm8tQloVx0GPbec2wUJiZqjvMZBBZp1XlUcr7AXarCShV0
SvSs1QTRW40j1CAVbFpFrxPJlmWJSPM34RzQsOMGn3LFj4j7ikJGfPZQpul2IR9K
oVl04pT4WfHOepW+42SQBGKFDpm1JQaEmfiuz6vU5+GUJLyK0yI=
=VQLi
-----END PGP SIGNATURE-----

--Tduv9NIV1KBc7PuKGVLFv6w2cduFmHVKp--
