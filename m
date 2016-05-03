Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 03 May 2016 09:07:35 +0200
Message-ID: <3295917.zMxpBmcd5T@bentobox>
In-Reply-To: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
References: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1785783.ZWFYaig6Dc";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Use netlink to replace some of
	debugfs
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
Cc: a@unstable.cc, mareklindner@neomailbox.ch

--nextPart1785783.ZWFYaig6Dc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

[...]
> +ifeq ($(origin LIBNL_GENL_CFLAGS) $(origin LIBNL_GENL_LDLIBS), undefined undefined)
> +  LIBNL_GENL_NAME ?= libnl-genl-3.0
> +  ifeq ($(shell $(PKG_CONFIG) --modversion $(LIBNL_GENL_NAME) 2>/dev/null),)
> +    $(error No $(LIBNL_GENL_NAME) development libraries found!)
> +  endif
> +  LIBNL_GENL_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(LIBNL_GENL_NAME))
> +  LIBNL_GENL_LDLIBS += $(shell $(PKG_CONFIG) --libs $(LIBNL_GENL_NAME))
> +endif
> +CFLAGS += $(LIBNL_GENL_CFLAGS)
> +LDLIBS += $(LIBNL_GENL_LDLIBS)

@Simon, @Matthias, @Antonio, @Marek: Should the header file be included in
batctl like nl80211.h in iw. Or should we always require the current kernel
header files installed to build batctl?


[...]
> +struct mandatory_attr {
> +	int attr;
> +	int datalen;
> +};
> +
> +static int last_err;
> +
> +static int invalidate_mandatory_attrs(struct nlattr *attrs[],
> +				      const struct mandatory_attr *mandatory[],
> +				      int num)
> +{
> +	int i;
> +	int len;
> +
> +	for (i = 0; i < num; i++) {
> +		if (!attrs[mandatory[i]->attr])
> +			return EINVAL;
> +		len = nla_len(attrs[mandatory[i]->attr]);
> +		if (mandatory[i]->datalen && (len != mandatory[i]->datalen))
> +			return EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mandatory_attr mandatory_attr_version= {
> +	BATADV_ATTR_VERSION, 0 };
[...]
> +static const struct mandatory_attr *info_hard_mandatory[] = {
> +	&mandatory_attr_version,
> +	&mandatory_attr_algo_name,
> +	&mandatory_attr_hard_ifname,
> +	&mandatory_attr_hard_address,
> +};
> +
> +static int info_callback(struct nl_msg *msg, void *arg __unused)
> +{
[...]
> +	if (nla_parse(attrs, BATADV_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
> +		      genlmsg_len(ghdr), NULL)) {
> +		fputs("Received invalid data from kernel.", stderr);
> +		exit(1);
> +	}
> +
> +	if (invalidate_mandatory_attrs(attrs, info_mandatory,
> +				       ARRAY_SIZE(info_mandatory))) {
> +		fputs("Missing/invalid attributes from kernel\n", stderr);
> +		exit(1);
> +	}

Interesting idea to check the mandatory attributes with a common function. But
shouldn't be the length checked by the nl_parse(..., policy) [1]? This is
especially important because you don't check the type.

Kind regards,
	Sven

[1] http://www.infradead.org/~tgr/libnl/doc/core.html#core_attr_validation
--nextPart1785783.ZWFYaig6Dc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKE43AAoJEF2HCgfBJntGFi4P/3u9xr83F2wqzurNDM+N7X4C
S1ZLEsetvN5j52dMtWw4bFO6b2R4Bu89jN2KTTtFNfiyoCpaErPfb3U6pTgncs5M
kiOKJ2Rmi96e+Z9ppXRoROETcn8AvH9BexfocW9Lm+Rf2Mkfx38jhUfMrKe/BXBW
SrQos9czl4mEkXbVpSOMiQHgp2j1ODEBSMbphjrxJ5oX0IyFaqyDQHb8d6AX7dOb
DgOnzs1p2HkCTjODd7JYliSd6ZBO3PR1UilrMXYNngaSA2f9wISZQsfMRKeObQv3
3lzK4qY+XqVkdGQlG3X2xVhWEJeU/2+SiReFcClYG0quHVUqR74u4Quj+91iqg+t
8ags+Uj4ns8khiZkxKMSVRQo0vd7uvv6APyIs/JbTQowVZDKffd34gVHmjNE6zUy
iRw6VeLTdP2K1csiZ6gzCNkckQEn3A8muuue5oA58gCtelWrrpoJI/OqtPsmqwyb
Jljzv3vn0zcAZOX5FuA8lNwcgI6pYqXZqfeyR1xFnc95l9aQ8k8gqg818RDiIm7N
ab4SFfHyKsyCojWSG+FeDrlJVTfDUFEaqFa52KFWrSli8E6ebyjLOZO88MhtzMs2
oBZ6jYRZ0YVrXiAJeHHNYBj589gVrMYW/jVeQX24vwnd231KCGVhFk4e1K4xoC5G
za5aZgN899eqQ5BUZpqY
=631S
-----END PGP SIGNATURE-----

--nextPart1785783.ZWFYaig6Dc--

