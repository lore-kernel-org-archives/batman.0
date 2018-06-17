Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Jun 2018 12:57:02 +0200
Message-ID: <2054994.kXe2AJMHxt@sven-edge>
In-Reply-To: <1529230014-17897-1-git-send-email-omer.efrat@tandemg.com>
References: <1529230014-17897-1-git-send-email-omer.efrat@tandemg.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4792148.4axvnBOdMb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 3/5] batman-adv: use BIT_ULL for
 NL80211_STA_INFO_* attribute types
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
Cc: Omer Efrat <omer.efrat@tandemg.com>, linux-wireless@vger.kernel.org, netdev@vger.kernel.org

--nextPart4792148.4axvnBOdMb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 17. Juni 2018 12:06:54 CEST Omer Efrat wrote:
[...]
> --- a/net/batman-adv/bat_v_elp.c
> +++ b/net/batman-adv/bat_v_elp.c
> @@ -114,7 +114,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
>  		}
>  		if (ret)
>  			goto default_throughput;
> -		if (!(sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
> +		if (!(sinfo.filled & BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))
>  			goto default_throughput;
>  
>  		return sinfo.expected_throughput / 100;
> 

WARNING: line over 80 characters
#32: FILE: net/batman-adv/bat_v_elp.c:117:
+               if (!(sinfo.filled & BIT_ULL(NL80211_STA_INFO_EXPECTED_THROUGHPUT)))

total: 0 errors, 1 warnings, 0 checks, 8 lines checked


Kind regards,
	Sven

--nextPart4792148.4axvnBOdMb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsmPn4ACgkQXYcKB8Em
e0Yp3xAArwkMnHjoJe08hCYQJydAWHOvNR1MN3dbny/CcZ5GjYRmPXBKZNFDVpbe
BPn1NOU1p65iOvdCfNyoefZoi4VqDm45k8c4sTjLwre979hm0DNoDJ26x69vx9iQ
rhWvXvtgXKIMvjh0PFyB1EU0DDkL7r05AR3taKACRrhaiB/qhWVbZkHLwDtueQnq
hQlOd5W2shw8QMskb7PbuaHAmb8cXQ4RKG2GMpDG/5mYwoABazRIa+Xz8+9GHkAj
3borNFemZB5AVkX7JzGhmgS66Q/R49L2AAvLgr4k3iW8Fwp06xWAYP3tv1p6f30C
kTAigjRmj3Awk4zPEf9bpqxWK5wIcu6b2MppdnBZJcudCyxb9LePL3BY3JNDfJ+I
cIEcEQPPf1h9qncP6qy3LviuwG+je59InbAyKfrI3gjyQlTqGOqNaL4zOGI+vab6
qlH5qH0Apmd1k3uehnSFlR9A4N2S4mISi+PR8HHydDyBSHdKe40EnwMneWOZjlw8
Gi/4MLVmZ0ULII71RyAOTTYLS8SKCLZXlWrw3cXL0xzIVsjihARX48dnlIeOZARD
WttfhgBax7zf42OPlw2d2s07daVT1NcqW61b0ZOJeeNYl3EUfuQ5QdVdo0eiBDza
sVeQw0SJqSq5zmDTVsipMyEgLDkJmGn1+b5ofecvuBwNPHEGeTk=
=F3iS
-----END PGP SIGNATURE-----

--nextPart4792148.4axvnBOdMb--



