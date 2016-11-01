Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Nov 2016 15:27:31 +0100
Message-ID: <4199328.BEd88szPmx@bentobox>
In-Reply-To: <14097889-e13c-70ae-3408-67fcf0271a96@web.de>
References: <14097889-e13c-70ae-3408-67fcf0271a96@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart134365021.jmDPPpDx0J";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] PATCH alfred
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
Cc: Jean-Jacques Sarton <jj.sarton@web.de>

--nextPart134365021.jmDPPpDx0J
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 1. November 2016 15:17:58 CET Jean-Jacques Sarton wrote:
> I had problem with alfre which don't start. I'am using netfs.
> 
> Swen has proposed a patch which remove the batadv_interface_check()
> function.
> May way is an other regarding the transitional period where the
> old an new feature are to be supported.
> 
> Signed-off-by: jj.sarton@t-online.de

Patch is corrupt:

    Description: PATCH alfred
    Applying: PATCH alfred
    fatal: corrupt patch at line 6
    Patch failed at 0001 PATCH alfred
    The copy of the patch that failed is found in: .git/rebase-apply/patch
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".
    'git am' failed with exit status 128

Please check http://lxr.free-electrons.com/source/Documentation/email-clients.txt to
understand what your email client has done to the patch..

And you patch subject is bogus. Please use something more specific
than "alfred". Check following examples:

   https://patchwork.open-mesh.org/project/b.a.t.m.a.n./list/?submitter=&state=3&q=alfred%3A&archive=true&delegate=


[...]
> diff --git a/netlink.c b/netlink.c
> index 1b5695c..ca311e7 100644
> --- a/netlink.c
> +++ b/netlink.c
> @@ -365,3 +365,30 @@ int get_tq_netlink(const char *mesh_iface, const
> struct ether_addr *mac,
> 
>         return 0;
>  }
> +
> +int batadv_interface_check_netlink(const char *mesh_iface)
> +{
> +       struct get_tq_netlink_opts opts = {
> +               .tq = 0,
> +               .found = false,
> +               .query_opts = {
> +                       .err = 0,
> +               },
> +       };
> +       int ret = 0;
> +
> +       memset(&opts.mac, 0, ETH_ALEN);
> +
> +       ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
> +                                  get_tq_netlink_cb, &opts.query_opts);
> +       if (ret < 0)
> +               return ret;
> +
> +       memset(&opts.mac, 0, ETH_ALEN);
> +       ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
> +                                  get_tq_netlink_cb, &opts.query_opts);
> +
> +       if (ret < 0)
> +               return ret;

The formatting + spaces of this function seems to be quite wild.
Please clean that up.

It seems to be wrong to me that you try to query BATADV_CMD_GET_ORIGINATORS
twice but not the global translation table.

Kind regards,
	Sven
--nextPart134365021.jmDPPpDx0J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYGKZTAAoJEF2HCgfBJntGyLQQAL29v4qOfwt/StxIos2HsRAq
3TIivhXmfZjWyDqoWFZN/K9MpUym1p6hhC1CMp/MerxEETTgGOa7sOk5sz8EpjAk
vki1DxjpPR/xuQ3Xk3MtYZ5aU0Trd6dKmV4qaA8kT2akz5cJQ/toCjqBP5Ajgmul
e4LMGg7dLS0biF8Z/qgFcsGSVNaPS26JFLhQT253f6r15eDd7GqpuBSKVSJjxdWg
/OIr7cpwUm42U41RJDxeuy/K/II//lRTf7iJQi+u7ez5mQfqV2lTRtGsM4H0yc7Y
WU6zrLwHfQdbPxzOhGL3TFvtKfaT1hPxwdOyb/03KfViwwhN6ayyQvRQd43WkDsn
r/1BAVVlSRroJgg8xNQ7UmzpRofkpivJb5soR9BE7O+AK2NxoUIqWg2BWKglzmOY
4Ojnr8LmaMrIN3ZlFaFp+i7NlIR9ofy4d9gC7Qqm+FE0GCg7c8PCC9IbVaQFOHRk
Ivmr+6c6JfgnbSAW5XvfpvbIu+NKQWDMolg0//E1I0kXi4oMAzhIZ/txZ+SUHX85
aMIuFhadTzK+I1G1/BWN/NVJDZDdYjpdksGxrERFFQAPD4RQKIxo0XQj/6gTZHIE
ckYk/OmDTnEpx+E1AECgYrB0I7ylQjdLhDx9MsqB9Z3B0935GF684TemgipzTVWV
Y9u5DbfH+qZ8psolMtzW
=kfAJ
-----END PGP SIGNATURE-----

--nextPart134365021.jmDPPpDx0J--

