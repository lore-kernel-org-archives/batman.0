Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 1/2] batctl: Add generic JSON interface
Date: Fri, 07 May 2021 21:11:37 +0200
Message-ID: <2690156.YyWG0Q00rh@sven-l14>
In-Reply-To: <20210507171414.369399-1-asarmanow@gmail.com>
References: <20210507171414.369399-1-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2726288.2ZRZGpqrMM"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Alexander Sarmanow <asarmanow@gmail.com>

 
--nextPart2726288.2ZRZGpqrMM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>
Subject: Re: [PATCH v2 1/2] batctl: Add generic JSON interface
Date: Fri, 07 May 2021 21:11:37 +0200
Message-ID: <2690156.YyWG0Q00rh@sven-l14>
In-Reply-To: <20210507171414.369399-1-asarmanow@gmail.com>
References: <20210507171414.369399-1-asarmanow@gmail.com>

On Friday, 7 May 2021 19:14:14 CEST Alexander Sarmanow wrote:
> +void netlink_print_json_entries(struct nlattr *attrs[], int selected_attrs[],
> +                               int arr_len, struct print_opts *opts);
> +void netlink_print_json_entry(struct nlattr *attrs[], int idx);
> +void nljson_print_str(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
> +void nljson_print_ifname_by_ifindex(struct json_opts *json_opts, struct print_opts *opts,
> +                                   struct nlattr *attrs[], int idx);
> +void nljson_print_int(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
> +void nljson_print_unsigned(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[],
> +                          int idx);
> +void nljson_print_uint8_t(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[],
> +                         int idx);
> +void nljson_print_vid(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
> +void nljson_print_crc32(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
> +void nljson_print_mac(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
> +void nljson_print_bool(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[], int idx);
> +void nljson_print_ttflags(struct json_opts *json_opts, struct print_opts *opts, struct nlattr *attrs[],
> +                         int idx);
> +void create_json_print_string(const char *str, const char **str_ret);
> +void sanitize_string(const char *str, int str_len);

Why are you exporting all of these functions? Most should be static inside the 
c file. I would recommend a new genl_json.c file.

Kind regards,
	Sven

--nextPart2726288.2ZRZGpqrMM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCVkOkACgkQXYcKB8Em
e0Y5Gw//bm2aLlo1Mdp0pe8qTMXOTLR8yw4oieKgKXob23h4/4nQIXr2yPfodxx3
0y98i3YyOHLSFjiarzJ370BUSizk8Mqr/p/yNykNyHNHkkTsTfIVx2RRRjQmsbqj
brKTr6iHC9PNG7tfnfvz2iBewbPGekSlgNcsfIF2dWkS9CUkcLAqG6EzFBv8+kT0
8KL2Jas0G4bH+pjoSojvPvL+g31v9cNMG+bgh4+8CCoz6C3tTjYwPS8JXrWP6xWV
IOH9ZwjZw3VfZOFxOvvm1hg5UY8kTdEXr4I8Xc1iWejP5fP7wTEaISRez+rVdrhK
G00oIq2CbpMTyN7AFBp2mYEbd922P+baeY1Nh+aD7gkf6AZ2ceqkWNlYe+C3ghP7
UPIoKlNNXyFM3OUsJ58Gmg77VmCS1k+GCjUMYHJHYtcN55gK89G7mkxRw26CjdXk
Rvsa0M+QZzo5THEm15NFDaYp/m1Di7hAoi5QEZaEHoxNFEMqbQCOMx8gipWcbUbw
eYzaR5fgK5jjXpZ3xSzXOiASd6cusOe4xBaS4OoM747xYbcPFe61ztfV1Ba0/6R+
3tpLHnnlMfK/oFq4kIZ01ZmREO71utkF8y4IOtheczLOgE6/Ol53LcyWqlcr5QQo
OX8lFA1+0/bE/maash9D6NN1LKRjRrUEAOpBZUDJ3Ie239wURPI=
=Swoz
-----END PGP SIGNATURE-----

--nextPart2726288.2ZRZGpqrMM--


