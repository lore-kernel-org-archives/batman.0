Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3 2/2] batctl: genl_json: Add generic JSON interface
Date: Fri, 14 May 2021 12:58:07 +0200
Message-ID: <5452292.bbYOnUf4Je@sven-desktop>
In-Reply-To: <20210513140234.1624460-3-asarmanow@gmail.com>
References: <20210513140234.1624460-1-asarmanow@gmail.com> <20210513140234.1624460-3-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4297162.PT8EF5Ib0W"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Alexander Sarmanow <asarmanow@gmail.com>

 
--nextPart4297162.PT8EF5Ib0W
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Alexander Sarmanow <asarmanow@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>
Subject: Re: [PATCH v3 2/2] batctl: genl_json: Add generic JSON interface
Date: Fri, 14 May 2021 12:58:07 +0200
Message-ID: <5452292.bbYOnUf4Je@sven-desktop>
In-Reply-To: <20210513140234.1624460-3-asarmanow@gmail.com>
References: <20210513140234.1624460-1-asarmanow@gmail.com> <20210513140234.1624460-3-asarmanow@gmail.com>

On Thursday, 13 May 2021 16:02:34 CEST Alexander Sarmanow wrote:
> To print JSON strings in a generic way a second nla_policy is used, with

This is not a nla_policy but a private json translation "policy".

[...]
> new file mode 100644
> index 0000000..cff54d8
> --- /dev/null
> +++ b/genl_json.c
> @@ -0,0 +1,359 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) B.A.T.M.A.N. contributors:
> + *
> + * Alexander Sarmanow <asarmanow@gmail.com>
> + *
> + * License-Filename: LICENSES/preferred/GPL-2.0
> + */
> +
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <ctype.h>
> +#include <netlink/netlink.h>
> +#include <netlink/attr.h>
> +
> +#include "genl_json.h"
> +#include "batman_adv.h"
> +#include "netlink.h"
> +#include "main.h"

#include "genl_json.h"
#include "main.h"

#include <ctype.h>
#include <inttypes.h>
#include <netlink/netlink.h>
#include <netlink/attr.h>
#include <stdbool.h>
#include <stdio.h>

#include "batman_adv.h"
#include "netlink.h"

> +static void nljson_print_uint8_t(struct nlattr *attrs[], int idx)
> +{
> +	uint8_t value = nla_get_u8(attrs[idx]);
> +
> +	printf("%u", value);
> +}

"%"PRIu8

> +
> +static void nljson_print_uint16_t(struct nlattr *attrs[], int idx)
> +{
> +	uint16_t value = nla_get_u16(attrs[idx]);
> +
> +	printf("%u", value);
> +}

"%"PRIu16

> +
> +static void nljson_print_uint32_t(struct nlattr *attrs[], int idx)
> +{
> +	uint32_t value = nla_get_u32(attrs[idx]);
> +
> +	printf("%u", value);
> +}

"%"PRIu32

> +
> +static void nljson_print_uint64_t(struct nlattr *attrs[], int idx)
> +{
> +	uint64_t value = nla_get_u64(attrs[idx]);
> +
> +	printf("%llu", value);
> +}

"%"PRIu64

> +
> +static void nljson_print_mac(struct nlattr *attrs[], int idx)
> +{
> +	uint8_t *value = nla_data(attrs[idx]);
> +
> +	printf("\"%02x:%02x:%02x:%02x:%02x:%02x\"",
> +		value[0], value[1], value[2], value[3], value[4], value[5]);
> +}

Alignment

> +static void nljson_print_flag(struct nlattr *attrs[], int idx)
> +{
> +	if (nla_get_flag(attrs[idx]))
> +		printf("true");
> +}

The check is not necessary because it check only if attrs[idx] is != NULL - 
which you've already checked. If this would not be the case, then this 
function would create broken json like '{"foobar":}', right?

> +
> +void sanitize_string(const char *str)
> +{
> +	while (*str) {
> +		if (*str == '"' || *str == '\\') {
> +			putchar('\\');
> +			putchar(*str);
> +		} else if (*str == '\\') {
> +			printf("\\\\");
> +		} else if (!isprint(*str)) {
> +			printf("\\x%02x", *str);
> +		} else {
> +			printf("%c", *str);
> +		}

		if (*str == '"' || *str == '\\') {
			putchar('\\');
			putchar(*str);
		} else if (!isprint(*str)) {
			printf("\\x%02x", *str);
		} else {
			putchar(*str);
		}

> +		str++;
> +	}
> +}

This function should have been static and at the beginning of this file.

> +
> +void netlink_print_json_entries(struct nlattr *attrs[], struct json_opts *json_opts)
> +{
> +	bool first_valid_attr = true;
> +	int i;
> +
> +	if (!json_opts->is_first)
> +		printf(",");

Code to handle the json_opts->is_first = false was again not added to this 
function.

> +
> +	printf("{");
> +	for (i = 0; i < BATADV_ATTR_MAX + 1; i++) {
> +		if (!attrs[i])
> +			continue;
> +
> +		if (!batadv_netlink_policy_json[i].cb)
> +			continue;
> +
> +		if (!first_valid_attr)
> +			printf(",");
> +
> +		putc('"', stdout);
> +		sanitize_string(batadv_netlink_policy_json[i].name);
> +		printf("\":");
> +		batadv_netlink_policy_json[i].cb(attrs, i);
> +
> +		first_valid_attr = false;
> +	}
> +	printf("}");
> +}
> +
> +
> +struct nla_policy_json batadv_netlink_policy_json[NUM_BATADV_ATTR] = {

this should have been static const

> +	[BATADV_ATTR_PAD] = {
> +		.name = "pad",
> +	},

I would guess we can ignore this one.

> +	[BATADV_ATTR_TT_FLAGS] = {
> +		.name = "tt_flags",
> +		.cb = nljson_print_uint32_t,
> +	},

Why was the actually decoding removed?

> +	[BATADV_ATTR_DAT_CACHE_IP4ADDRESS] = {
> +		.name = "dat_cache_ip4_address",
> +	},

IPv4 print code missing

[...]
> +	[BATADV_ATTR_VLANID] = {
> +		.name = "vlan_id",
> +		.cb = nljson_print_uint16_t,
> +	},

wasn't this originally printed in a special way?

> +	[BATADV_ATTR_AGGREGATED_OGMS_ENABLED] = {
> +		.name = "aggregated_ogms_enabled",
> +		.cb = nljson_print_uint8_t,
> +	},

This and other _ENABLED are booleans.

[...]

There were also different other weird names used. Like fragmented_enabled for 
the fragmentation feature.

> diff --git a/genl_json.h b/genl_json.h
> new file mode 100644
> index 0000000..0336b40
> --- /dev/null
> +++ b/genl_json.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) B.A.T.M.A.N. contributors:
> + *
> + * Alexander Sarmanow <asarmanow@gmail.com>
> + *
> + * License-Filename: LICENSES/preferred/GPL-2.0
> + */
> +
> +#ifndef _BATCTL_GENLJSON_H
> +#define _BATCTL_GENLJSON_H
> +
> +#include <stdint.h>
> +
> +#include "netlink.h"
> +
> +struct json_opts {
> +	uint8_t is_first;

is_first:1

> +	struct nlquery_opts query_opts;
> +};
> +
> +void netlink_print_json_entries(struct nlattr *attrs[], struct json_opts *json_opts);
> +void sanitize_string(const char *str);
> +
> +#endif /* _BATCTL_GENLJSON_H */
> diff --git a/netlink.h b/netlink.h
> index c93f500..d96935a 100644
> --- a/netlink.h
> +++ b/netlink.h
> @@ -29,6 +29,11 @@ struct nlquery_opts {
>  	int err;
>  };
>  
> +struct nla_policy_json {
> +	const char *name;
> +	void (*cb)(struct nlattr *attrs[], int idx);
> +};
> +

This doesn't belong to netlink.h. If it would really be needed outside of 
genl_json.c then you should have added it to genl_json.h

>  struct ether_addr;
>  
>  int netlink_create(struct state *state);
> @@ -44,6 +49,7 @@ int get_algoname_netlink(struct state *state, unsigned int mesh_ifindex,
>  			 char *algoname, size_t algoname_len);
>  
>  extern struct nla_policy batadv_netlink_policy[];
> +extern struct nla_policy_json batadv_netlink_policy_json[];

This doesn't belong to netlink.h. If it would really be needed outside of 
genl_json.c then you should have added it to genl_json.h

Kind regards,
	Sven


--nextPart4297162.PT8EF5Ib0W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmCeV78ACgkQXYcKB8Em
e0Z6+BAAoQvK2/RTeN1pvnI4k8DwkeiOkxoWZ8YHeF/P1VS0mOKrmiCK/rAi6jTL
uWvngTt/XjtmftptbiG1P727Aa8QwhnZWMgViOvHCtSGn/67iWM8e3Lmt6dVp9Jj
lCOz3chRKauowUfEZ9Scw7vwKB4cuMn0T2yc4psysqa7eTieblaplb9kmIXf/S9F
JiHQ7Wz539d96c9PNYsAdOuKqYqBxPaB5Nima6TkFA2nONNmVEDGpKCF1UwoV5t7
h1+td566WWtNA6rc12ZsNL8ZHgl/NRtsBBoVmscaB0OBMUhu/GbnJ+xh8bxCszDY
KdXOmUp+fkwAGnxJfax+HcBXKSI9g8/dWPtdQuaoVngOaDBM4Ow5hXDASKSvqTSC
npvt4USn+1Eqk93EjL2PbnqwDAhzuKwvGxYwJQFhBz2BvNQW+RrSpdOUNKr3xbO2
lTGdvZbCWUSA96TH1oz/CuTnshHx4/cvXCt+EWNVdCaFqEtjROUoSZOl7pQfUtHf
ey1JF5U0ptQT4BYUsWs+ahvOuk2CiA9Y3g3rt2yFJnCmx8nGVGfA0ZofNRVlV17g
jyrjBuqgT4yeIQPnkfWPJ8+n5e4WZiI3Ive/v+Jfin6f58zGv8+V5bN0QnGtjAOn
I1lkTDVixfQmWteIkyA9VzkxL52ZokTN5+pqAIEhIvhO1Ok5Oeo=
=8J1Y
-----END PGP SIGNATURE-----

--nextPart4297162.PT8EF5Ib0W--


