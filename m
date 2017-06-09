Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 09 Jun 2017 16:06:43 +0200
Message-ID: <1548734.CEMtPVhoG8@sven-edge>
In-Reply-To: <20170609130255.8577-2-sven@narfation.org>
References: <20170609130255.8577-1-sven@narfation.org>
 <20170609130255.8577-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3336343.7HyZiUiRgE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Accept only filled wifi
 station info
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

--nextPart3336343.7HyZiUiRgE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 9. Juni 2017 15:02:55 CEST Sven Eckelmann wrote:
[...]
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 8, 0)
> diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
> index 96e73337..16552568 100644
> --- a/net/batman-adv/bat_v_elp.c
> +++ b/net/batman-adv/bat_v_elp.c
> @@ -111,6 +111,8 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
>  		}
>  		if (ret)
>  			goto default_throughput;
> +		if (!(sinfo.filled & STATION_INFO_EXPECTED_THROUGHPUT))
> +			goto default_throughput;
>  
>  		return sinfo.expected_throughput / 100;
>  	}
> 

Looks like STATION_INFO_EXPECTED_THROUGHPUT was removed in 
319090bf6c75e3ad42a8c74973be5e78ae4f948f and 
BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT) must now be used. Of course, 
NL80211_STA_INFO_EXPECTED_THROUGHPUT doesn't have the value 28 :(

Kind regards,
	Sven

--nextPart3336343.7HyZiUiRgE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlk6q3MACgkQXYcKB8Em
e0ZypRAAub7KZjK+F4bqpbIN8UiCT0gb8cpNaC6tLyAD+BL1s6Slu8e85Ipj6Ojc
EMzVB66FgqzMJZfwT7RMkfVN/p4zrqu+IotQFWAk+QMD+jtLP/psdYw/kIkWZhAM
JDyVwzP0bD44QBqlG6gasrQBudEn6K0ts20BiG3tRjPMo0+wQh1qVfAo1RUWzUG+
TmIwqkx5ch/YmHRolc10mmDdrFRQAjELWnVEe5ggdrXtauVGnK1sCDpKj8KYZqeX
k05oGcY71vesecYTXuEgnI8J3DLp6yNeY48y+PaoJNjGR7//cLrB0awhiAB63Xpi
Pa/EnkG/T8nyWQWVW3O3V2rmci98dsOY/D2J/0/T3b1/EiyRVuah2rkszB4e6yF5
uWAIhjkMYTHCslHlt5cK/ihobyaD0bLMP1nJ8Rc+gWyOmAwNnQzG86JoDAqWnUJM
vF5xq4ckgxdgWRVQ3quPvW0luMcV01XQRZ7tb5Zy8Y8/+9bGWmcFbXPnIgOXC6p3
tHLV95uo73LyVFMpf0VhXMDlz8GDe8/HSZ8xAK93vfbajzS3zxlSDepwrLEuUkyX
OV5sWSrCc88M0VWBiC12WWBi4d2WNzpjzAIP+QY7T0Q7tccXJJQMtlp5muJA/w7U
ywXWpBvk7l/qcx7xs4HuWr6aSEEE8xIyg1O8nItY1t27fJPy334=
=7znL
-----END PGP SIGNATURE-----

--nextPart3336343.7HyZiUiRgE--

