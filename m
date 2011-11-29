Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 29 Nov 2011 16:23:18 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111129152318.GA8417@pandem0nium>
References: <201111290028.01655.lindner_marek@yahoo.de>
	<1322497717-21268-1-git-send-email-lindner_marek@yahoo.de>
	<1322497717-21268-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <1322497717-21268-2-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: convert batman iv
 algorithm to use dynamic infrastructure
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

interesting approach, thanks for the patches! I don't really think that
we need modules at this point, but we can easily extend it later - for
example, net/mac80211/rate.c has a very similar API and works with modules.

A few comments to the API:

Generally, we should have a few lines per function in types.h to
describe what each function is doing - we don't need that for a RFC patch,
but that would be useful for the final version.

On Tue, Nov 29, 2011 at 12:28:36AM +0800, Marek Lindner wrote:
>  struct bat_algo {
>  	struct hlist_node list;
>  	char name[20];

you can also use a simple pointer here:=20
  char *name;

(the name will most probably static in the module anyways)

> +	void (*bat_ogm_init)(struct hard_iface *hard_iface);
> +	void (*bat_ogm_init_primary)(struct hard_iface *hard_iface);
> +	void (*bat_ogm_update_mac)(struct hard_iface *hard_iface);
> +	void (*bat_ogm_schedule)(struct hard_iface *hard_iface,
> +				 int tt_num_changes);

can't we put tt_num_changes somewhere bat_priv?

> +	void (*bat_ogm_emit)(struct forw_packet *forw_packet);
> +	void (*bat_ogm_receive)(const struct ethhdr *ethhdr,
> +				unsigned char *packet_buff, int packet_len,
> +				struct hard_iface *if_incoming);

you can just pass the SKB instead of ethhdr, packet_buff, and packet_len
-> they are derived from the skb anyway.

Then, you have can do the API with always a hard_iface as the first
parameter. ;)

I also agree with Andrew on defining (a subset of) mandatory functions
which every algo has to provide. The register function could then check
and decline algos which don't define mandatory functions, and we don't have
to check availability in the real code later ...

best regards,
	Simon

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7U+OYACgkQrzg/fFk7axZA9gCeNSUcR2jJGAZzdGVVcKTJMZHF
/OsAoOGvK6r0ZbYdBLqp+LJ5sNtKgxIS
=nKjy
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
