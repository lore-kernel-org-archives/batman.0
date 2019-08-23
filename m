Return-Path: <a@unstable.cc>
Subject: Re: [PATCH v2 1/2] batman-adv: Only read OGM tvlv_len after buffer
 len check
References: <20190823123428.8076-1-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <9dfd127f-fff4-228f-2607-5fa23ac9654d@unstable.cc>
Date: Fri, 23 Aug 2019 18:16:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190823123428.8076-1-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IV7n8BnOgbCDlHxUjEqN2Gki97598xkh2"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: syzbot+355cab184197dbbfa384@syzkaller.appspotmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IV7n8BnOgbCDlHxUjEqN2Gki97598xkh2
Content-Type: multipart/mixed; boundary="8rJH72LJMMtQLFRLlEf4bNk0UEY8Pza8M";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: syzbot+355cab184197dbbfa384@syzkaller.appspotmail.com
Message-ID: <9dfd127f-fff4-228f-2607-5fa23ac9654d@unstable.cc>
Subject: Re: [PATCH v2 1/2] batman-adv: Only read OGM tvlv_len after buffer
 len check
References: <20190823123428.8076-1-sven@narfation.org>
In-Reply-To: <20190823123428.8076-1-sven@narfation.org>

--8rJH72LJMMtQLFRLlEf4bNk0UEY8Pza8M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/08/2019 14:34, Sven Eckelmann wrote:
> Multiple batadv_ogm_packet can be stored in an skbuff. The functions
> batadv_iv_ogm_send_to_if()/batadv_iv_ogm_receive() use
> batadv_iv_ogm_aggr_packet() to check if there is another additional
> batadv_ogm_packet in the skb or not before they continue processing the=

> packet.
>=20
> The length for such an OGM is BATADV_OGM_HLEN +
> batadv_ogm_packet->tvlv_len. The check must first check that at least
> BATADV_OGM_HLEN bytes are available before it accesses tvlv_len (which =
is
> part of the header. Otherwise it might try read outside of the currentl=
y
> available skbuff to get the content of tvlv_len.
>=20
> Fixes: 0b6aa0d43767 ("batman-adv: tvlv - basic infrastructure")
> Reported-by: syzbot+355cab184197dbbfa384@syzkaller.appspotmail.com
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <a@unstable.cc>

--=20
Antonio Quartulli


--8rJH72LJMMtQLFRLlEf4bNk0UEY8Pza8M--

--IV7n8BnOgbCDlHxUjEqN2Gki97598xkh2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAl1gEXMACgkQ9FVsWUWD
Dm3Rsw/+Miu9BLOSfl8YIm/UsbqhxSbLq1hylH7/q70LDOc8o8e0iRr86hFeOsY7
uKA/4tTSpDX/5LzWOvJ3QtSpUHbgvnd50q3kvsDoK5oy4B+Bk1zEhVwCSuFkPS7G
nREBYkvHoU8p6keVZASB/6F6zX+iK3Kih5ZNSz08HI6jBgfIGQ4jipWOufe56bxP
0AwCEVeMKMlQ3sZNoF5V9P2L8qfKEV9ZHxlrss9aLuHElgptQjMdqk/BFGSLXwaX
kWoq1KK8AZziLbMDrQcuVfblmvT0xK/TSbo39Q+/WGUb828/9XxyTOlbrXObKXex
9MEL8EUQ4iIg/T4CRCWyx8fX8a1iVa8eTytEuJx9fYFzKfmoM/AAydJ3zMbGDCIQ
13ErpoLvw291At/V7tR52Yo5eTIJAKlm+Ukmj/xDbY5Rq6FNnH4rRo4mFAaN3g7y
en+bvLI1pK2Vk0Mq883VXVLD3lUaNJYWRVaYh2Hfa1OEDLgcW42W52td6JObpAoz
KcY71ms/3it6kF2WRekar28m0DQ+wRVUGuv9LDJms50cERiWC6MWUGGZ4E835SiI
G04dE7VniJfQaciexrG7HsZd4oRKiWZUq7cPFbacNxxujFxQCGUg1nPGgys8RrjE
ddnFtYgfkZWhDTDD65+QJlTrA0Ego9bpjqc7z+R9qsJ227xfZdA=
=IUwu
-----END PGP SIGNATURE-----

--IV7n8BnOgbCDlHxUjEqN2Gki97598xkh2--
