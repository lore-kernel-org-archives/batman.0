Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 05 Jan 2014 22:04:04 +0800
Message-ID: <2648905.iCJy0vMviH@diderot>
In-Reply-To: <1388912394-824-1-git-send-email-antonio@meshcoding.com>
References: <1388912394-824-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7435789.VyUAp8KMce";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next 1/3] batctl: introduce rtnl_open()
	helper function
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart7435789.VyUAp8KMce
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 05 January 2014 09:59:52 Antonio Quartulli wrote:
> @@ -528,7 +526,7 @@ static int resolve_mac_from_cache_open(int ai_family)
>         if (ret < 0)
>                 goto outclose;
>  
> -       ret = send(socknl, &nlreq, nlreq.hdr.nlmsg_len, 0);
> +       ret = send(socknl, req, len, 0);
>         if (ret < 0)
>                 goto outclose;
>  out:
> @@ -538,6 +536,22 @@ outclose:
>         return ret;
>  }
>  
> +static int resolve_mac_from_cache_open(int ai_family)
> +{
> +       struct {
> +               struct nlmsghdr hdr;
> +               struct ndmsg msg;
> +       } nlreq;
> +
> +       memset(&nlreq, 0, sizeof(nlreq));
> +       nlreq.hdr.nlmsg_len = NLMSG_LENGTH(sizeof(nlreq.msg));
> +       nlreq.hdr.nlmsg_type = RTM_GETNEIGH;
> +       nlreq.hdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
> +       nlreq.msg.ndm_family = ai_family;
> +
> +       return rtnl_open(&nlreq, sizeof(nlreq), NETLINK_ROUTE);
> +}

Is 'sizeof(nlreq)' equal to 'nlreq.hdr.nlmsg_len' ? It seems not ...

Cheers,
Marek

--nextPart7435789.VyUAp8KMce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSyWZZAAoJEFNVTo/uthzAr8kH/ieyE6IRY/hIa5U1WVq2GE4+
kMwGQGDNTkx5zzlFLi1FkuB0KSi/FhgEOb/aluSI3guAd99I2Zx5kEEtYJ31gC/e
GJZxItHqTSGuZm0o8UUG0omlwQj/8+aHcXLVnS2FWCF325AErqvr7XlJN9pynpOY
Xx8V8wnQAz1MUINhbLk1hdpkXyPbMGmmt3rtGWAd3+GGd+vi04cfDwiEkXaUhBkn
ttgYswW5f2cs8XNuF6UIStf35kWvSoj89LNvK38VR/M4qtnC+j3lwXkvFeSXNRML
w83uobWzDg94L6u5vQVdXf/YWqm+u0T53HfKKWeSA3aC2DUxiBwpPhiYNHUSg1A=
=/B8d
-----END PGP SIGNATURE-----

--nextPart7435789.VyUAp8KMce--

