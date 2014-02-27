Return-Path: <antonio@meshcoding.com>
Message-ID: <530F2E61.5060203@meshcoding.com>
Date: Thu, 27 Feb 2014 13:24:01 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1393215104-28184-1-git-send-email-linus.luessing@web.de>
 <1393215104-28184-3-git-send-email-linus.luessing@web.de>
In-Reply-To: <1393215104-28184-3-git-send-email-linus.luessing@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HVJT2oqOrGpKlBCSpQhp5UIcSFHUpURaU"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batctl: add unicast/multicast
 address filter option for TT output
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@web.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HVJT2oqOrGpKlBCSpQhp5UIcSFHUpURaU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/02/14 05:11, Linus L=C3=BCssing wrote:
> @@ -138,6 +143,26 @@ int handle_debug_table(char *mesh_iface, int debug=
_table, int argc, char **argv)
>  		case 'H':
>  			read_opt |=3D SKIP_HEADER;
>  			break;
> +		case 'u':
> +			if (debug_table !=3D BATCTL_TABLE_TRANSLOCAL &&
> +			    debug_table !=3D BATCTL_TABLE_TRANSGLOBAL) {
> +				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
> +				debug_table_usage(debug_table);
> +				return EXIT_FAILURE;
> +			}
> +
> +			read_opt |=3D UNICAST_ONLY;
> +			break;
> +		case 'm':
> +			if (debug_table !=3D BATCTL_TABLE_TRANSLOCAL &&
> +			    debug_table !=3D BATCTL_TABLE_TRANSGLOBAL) {
> +				fprintf(stderr, "Error - unrecognised option '-%c'\n", optchar);
> +				debug_table_usage(debug_table);
> +				return EXIT_FAILURE;
> +			}
> +
> +			read_opt |=3D MULTICAST_ONLY;
> +			break;

do we really want to allow the user to specify both flags? Or should we
throw an error in that case? I think the second option would be better, n=
o?

>  		case '?':
>  			if (optopt =3D=3D 't')
>  				fprintf(stderr, "Error - option '-t' needs a number as argument\n"=
);
> diff --git a/functions.c b/functions.c
> index 36804bd..41eabb2 100644
> --- a/functions.c
> +++ b/functions.c
> @@ -224,6 +224,22 @@ read:
>  			    && (last_seen > orig_timeout))
>  				continue;
> =20
> +		/* translation table: skip multicast */
> +		if (line > header_lines &&
> +		    read_opt & UNICAST_ONLY &&
> +		    strlen(line_ptr) > strlen(" * xx:xx:xx:") &&
> +		    (!strncmp(line_ptr+3, "33:33:", strlen("33:33:")) ||
> +		     !strncmp(line_ptr+3, "01:00:5e:", strlen("01:00:5e:"))))
> +			continue;
> +
> +		/* translation table: skip unicast */
> +		if (line > header_lines &&
> +		    read_opt & MULTICAST_ONLY &&
> +		    strlen(line_ptr) > strlen(" * xx:xx:xx:") &&
> +		    strncmp(line_ptr+3, "33:33:", strlen("33:33:")) &&
> +		    strncmp(line_ptr+3, "01:00:5e:", strlen("01:00:5e:")))
> +			continue;
> +

why not just converting to an integer the first octect of the MAC
address and checking for the multicast bit being set or not? Wouldn't
that be more elegant and generic?



Cheers,

--=20
Antonio Quartulli


--HVJT2oqOrGpKlBCSpQhp5UIcSFHUpURaU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTDy5kAAoJEEKTMo6mOh1V7fIP/03mW3sjMZVCd7koe0GzB8nt
Iryw8an2ZmKj4iExdKu23U2p0MSpkghmASUn8WNcIy4CQgbQK1sxauKxcNoqNxlO
OzEzTaNtWJnsk4TLOi1x37+kbxRYyToEsBr10zkg5Fyupw0fpyQWHi6sQOvqPMXT
Qe3w1fseIe/FTz0kOR1S29cu9BXADcgXAr6XWOCbn+9A5pRdicSVLRwShns7gBKW
0McodcJEd+lIhyx21Bgeo+sbjI3fWzDxVsPp2Bfbf8jq3hb+lerd8S5DPfu9ev5C
kDGyT8DZb7zGBKkhJINpgXAdQdlIPJiFwRo3XZax91jFdsYQlvm49JmI1czG1ycH
Vpm58m0tVEIULHjrAFF60PSWwAOWjHu7AX89eW6MsVz8fmPRy06lF/3yn8+1gjdw
ebvPEZP2+rrlfhUbnojfeLBu1rwUCiHU+upp+LEfRpBazOOJjtYaqm1RBmK46Fo7
4O7G9qA6TdfvZhT1u3qyjV/9v3svXViok46IASQJP1Q2C0/O9Q0zuhULzFyfLWlZ
AFJYqyxiS/jKMLVTfjJzkzWYrV8olyJtU0BwEKmBhAegPxnknsAEVNzhPEFFFvSs
TaY5rp59dFzuG4/1NMwAeRww2jvrziRHq84ArSm9yrHhczzJfs12zHE9wJIYhq2W
mN9+L82RbaQroxOyq3Lz
=RZEu
-----END PGP SIGNATURE-----

--HVJT2oqOrGpKlBCSpQhp5UIcSFHUpURaU--
