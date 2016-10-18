Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 13:32:11 +0200
Message-ID: <8393068.B0S6OCOJg8@bentobox>
In-Reply-To: <20160925004636.11334-1-a@unstable.cc>
References: <20160925004636.11334-1-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3731482.9m2Jay3BJ9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: remove unsed argument from
	batadv_dbg_arp() function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3731482.9m2Jay3BJ9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 25. September 2016 08:46:36 CEST Antonio Quartulli wrote:
> The argument "type" passed to the batadv_dbg_arp() function is
> never used. Remove it.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> Reviewed-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/distributed-arp-table.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Applied in 917539ed1ca1b7e6046b44adc35d8264f33e20fb [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/917539ed1ca1b7e6046b44adc35d8264f33e20fb
--nextPart3731482.9m2Jay3BJ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBgg7AAoJEF2HCgfBJntGdmcP/11Oe8ZO7+dH5kw/OO2UXNlc
hhwInpwF2vpuC9TIzQDC8wS8pxZeL+O1JvXnYKiT1eMs/aDgcdX28rSsOr/ojl+I
aHC5FildGuscgZj2VNaZ+xLObzG2v9n6vgt27a658wBfm4ivmVkzGVlWxGQknaNv
C+0QBGPa/g/XHja3IItX65i/wTiffo236l1yuzxoAlRQyyLvWtmUQnHi4NqVLiqU
nsqV1ReKAqYBt9qbUfErOdwfNeQBTA60AAMJlqWWWcIw6oLgcbVrRyZLvBREM1wL
dnTcdFLWKh5Cncun6b2kbnYbybvTrSEk5PfI4Gy2g8nS5F/6wMtY5/oKQ/KA8+Hw
VOQtkS48koo9QE8c1Sh9w6OxU4qoqgeCxtIlmjaetcrRkyAYumyrzmz5YHy3oJVO
mD+1CgM75/wDjcyve5sgwGMBeqTQqKqZ7YQZczANkBFtrcC9HTxflBcqqVL3DsUl
+Zpmgq2/wyq9IFqiXOz8/vCfPkuSV2vutqDzJcipOxVYyMeMrQIjMYwtGBppx1Dh
awFSFJVjKjNNKrYPfjq+ffirGZymAbDnFBmGIQlUJYETMblU0IAByLnIc0+nQLlW
/5h8BjhOGOxh4GjfgwqfkfUEnaOUUHB7+g9n30FJBnSj9Il36jmxTt2hNcZqPxTd
ZWcwKK4yTAR/aGdPO53n
=loP+
-----END PGP SIGNATURE-----

--nextPart3731482.9m2Jay3BJ9--

