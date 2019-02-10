Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 10 Feb 2019 19:59:59 +0800
Message-ID: <3604216.NcQoz811mF@rousseau>
In-Reply-To: <20190111210208.29139-1-linus.luessing@c0d3.blue>
References: <20190111210208.29139-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14243350.uFGr5DfqaX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Increase purge timeout on
 DAT DHT candidates
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

--nextPart14243350.uFGr5DfqaX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday, 12 January 2019 05:02:08 HKT Linus L=FCssing wrote:
> Some old investigations and analysis seemed to indicate a potential
> reduction of 91.71% of unanswered ARP Requests (45min: 97.95%, 60min:
> 98.95%):

Does this reduction apply to this patch specifically or to the DHCPACK=20
snooping or both ? Has this patch been tested ?

>=20
> https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping
>=20
> This patch is rebased on top of:
>=20
> "batman-adv: DHCP snooping for DAT"

That patch is now called "batman-adv: Snoop DHCPACKs for DAT" and has been=
=20
merged ?


> @@ -152,7 +152,9 @@ static void batadv_dat_entry_put(struct batadv_dat_en=
try
> *dat_entry) static bool batadv_dat_to_purge(struct batadv_dat_entry
> *dat_entry) {
>  	return batadv_has_timed_out(dat_entry->last_update,
> -				    BATADV_DAT_ENTRY_TIMEOUT);
> +				    BATADV_DAT_ENTRY_TIMEOUT) &&
> +	       batadv_has_timed_out(dat_entry->last_dht_update,
> +				    BATADV_DAT_DHT_TIMEOUT);
>  }

This bit could be further simplified. Introducing 2 timeout fields is a bit=
=20
misleading since there only are 2 cases:

* last_update is updated (or not) while last_dht_update is/remains 0
* last_update and last_dht_update have the same value

Why not turn last_dht_update into a bool and apply the timeout length based=
 on=20
that bool. Something like:

if (is_global_entry)
   return batadv_has_timed_out(dat_entry->last_update,
BATADV_DAT_DHT_TIMEOUT);
else
   return batadv_has_timed_out(dat_entry->last_update,
BATADV_DAT_ENTRY_TIMEOUT));

=46urthermore, don't jiffies overflow at some point on some architectures ?=
=20
Initializing a jiffies field with 0 appears error-prone.

Cheers,
Marek

--nextPart14243350.uFGr5DfqaX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlxgEj8ACgkQU1VOj+62
HMAmJAf+JONs80DF9mGAlWHfScBC/RXplhix2zQYAR0tGeIDJV5wl5e0aXLgX4y6
+DoZnbaKDeb63OE5TENC+nFdbjsOpfOMq1fXjTLX8pDKWgC5b7o6dm6VzrYiRMKM
xuW1ewr05EcZVO30FlnSo2pS0oOP0055GC/G90aDRFp/RCpyYlEsT8HTKx5cISXh
xQiaesVfdtdzxLJA6QUKJXOxOs/bLkoz/zlUZdcvneOy485n2VA+F6o8hXkE9ibg
u1shZ4lLcLprwZhfaoomK2gIaPZ3cqX2aVzZDvHOT+VBJROvL+LloFHnQAyA+OTS
SZ6+ek6UaWv6c4aof9cgj2T+j/lFLg==
=/EUL
-----END PGP SIGNATURE-----

--nextPart14243350.uFGr5DfqaX--



