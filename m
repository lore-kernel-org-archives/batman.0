Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 2/4] alfred: Allow operating without any interface
 specified
Date: Sun, 02 Jan 2022 15:20:20 +0100
Message-ID: <2887321.KE3FGX6OkO@sven-l14>
In-Reply-To: <20220102113136.470299-2-mareklindner@neomailbox.ch>
References: <3748133.vRqKQLy7FI@rousseau>
 <20220102113136.470299-1-mareklindner@neomailbox.ch>
 <20220102113136.470299-2-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3555316.B6yQ7zIYFZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

 
--nextPart3555316.B6yQ7zIYFZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH 2/4] alfred: Allow operating without any interface specified
Date: Sun, 02 Jan 2022 15:20:20 +0100
Message-ID: <2887321.KE3FGX6OkO@sven-l14>
In-Reply-To: <20220102113136.470299-2-mareklindner@neomailbox.ch>
References: <3748133.vRqKQLy7FI@rousseau> <20220102113136.470299-1-mareklindner@neomailbox.ch> <20220102113136.470299-2-mareklindner@neomailbox.ch>

On Sunday, 2 January 2022 12:31:34 CET Marek Lindner wrote:
[...]
> diff --git a/README.rst b/README.rst
[...]
>  	if (strcmp(globals->mesh_iface, "none") != 0 &&
>  	    batadv_interface_check(globals->mesh_iface) < 0 &&
>  	    !globals->force) {
> @@ -393,12 +387,6 @@ int alfred_server(struct globals *globals)
>  		return -1;
>  	}
>  
> -	num_socks = netsock_open_all(globals);
> -	if (num_socks <= 0 && !globals->force) {
> -		fprintf(stderr, "Failed to open interfaces\n");
> -		return -1;
> -	}
> -
>  	num_interfaces = netsocket_count_interfaces(globals);
>  	if (num_interfaces > 1 && globals->opmode == OPMODE_SECONDARY) {
>  		fprintf(stderr, "More than one interface specified in secondary mode\n");
> 

This now causes the "--force" option (+its storage in the globals data 
structure) to be completely useless. I would prefer to have this handling
still be there when !list_empty(&globals->interfaces).

And why is it necessary to not open the sockets on startup when interfaces are 
already given?

Kind regards,
	Sven
--nextPart3555316.B6yQ7zIYFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHRtKQACgkQXYcKB8Em
e0Y/wBAAr4/e+kitdyYNx0/IDpoylufZ/1vsPngknN2yG0PQoyPxt3FYqotA3ZZ9
H/oCi6YKHSN9VsKsQLgysTBMJAlVOa/nSrcke6XDMdfKqkWyVo7VpK6w34XtiFsr
PLO/WXjR8CJxlH/V3Wx6TLZejdsFqeHR4aIZRe1B5dlJZnuTi8dltLoVvw5uUhE8
lgggUWTed6S6oMbJyjl3K3Cgy+iWrHsHdbpD/Qr/jUs7wbgLnBWzjSsQddaRbANg
Thsgumsv8Zikapcq0p3L+zEpF9tZL9YFswqypiwXgYikN2ih73UImFOgdS9R2vA4
xSZMYg6D8IYKUEuS1HupXugBd3WyV/LlmswdCZVirC8EPYOmxXgR/28Luf1fJWoZ
fR8GmA2trrIB/e+N3wM0AudGChL8hx5Jx4Uwss9D1HSXTqOFvoPJPDpHqeAu3WZF
Bdl6FLgq6gnp9O/cyt1/3fpmMJwrxcZakb9wDZVnAwgKHsBVohiagAFCIiyOGqpn
ISa7jFBS6en3zyNL08zDgmOqATI4x01ipDsJGPZ77kX0g5wQkVDiEUZQN0k1cSq1
Xanr39iF3aGNh09sh/X5RH8MBvJd3ju8cXKgZl9EaaEhqBwy7NOoFfbgYvI8tjN4
agb4cCtEyOmwwkneaYLYAw/gFRc8PedDDkeqxSVZOduOaynWnmk=
=mnex
-----END PGP SIGNATURE-----

--nextPart3555316.B6yQ7zIYFZ--


