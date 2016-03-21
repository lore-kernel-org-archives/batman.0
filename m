Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 21 Mar 2016 10:13:22 +0100
Message-ID: <2352013.EmfB5eiPMC@bentobox>
In-Reply-To: <1458551033-8734-2-git-send-email-hwhilse@gmail.com>
References: <1458551033-8734-1-git-send-email-hwhilse@gmail.com>
 <1458551033-8734-2-git-send-email-hwhilse@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9413309.HYjPiJ1mj4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC] alfred: implement TCP support for
	server-to-server communication
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
Cc: Hans-Werner Hilse <hwhilse@gmail.com>

--nextPart9413309.HYjPiJ1mj4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> +int connect_tcp(struct interface *interface, const struct in6_addr *dest)
> +{
> +	struct sockaddr_in6 dest_addr;
> +	int sock;
> +
> +	memset(&dest_addr, 0, sizeof(dest_addr));
> +	dest_addr.sin6_family = AF_INET6;
> +	dest_addr.sin6_port = htons(ALFRED_PORT);
> +	dest_addr.sin6_scope_id = interface->scope_id;
> +	memcpy(&dest_addr.sin6_addr, dest, sizeof(*dest));
> +
> +	sock = socket(PF_INET6, SOCK_STREAM, IPPROTO_TCP);
> +	if (sock < 0)
> +		return -1;
> +
> +	if (connect(sock, (struct sockaddr *)&dest_addr,
> +		    sizeof(struct sockaddr_in6)) < 0) {
> +		close(sock);
> +		return -1;
> +	}
> +
> +	return sock;
> +}
> +

Wouldn't this hang for a while and make the alfred server "unresponsive"
when the remote is not reachable at this moment?.

Kind regards,
	Sven
--nextPart9413309.HYjPiJ1mj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW77syAAoJEF2HCgfBJntG/p0QAMJLZmUCcv943E/L70sA2RKR
Jh14pS5GUKwm0ZivK9dlCfGpXnI8RsjgqoOBcisHfuG2ckhqcdIcwKxe8YdLekjy
hGpHDhFzQhINXA7oIJExyat+XFwAf/0OPAWy3sfXStBw3JiXXaEHtFm9tackMEl3
lp5aFse81zYKVKqSX1uqpibGRiMyhHqZ1ERLWBt3OH1kCCqm0Av2jyDg3CBtw+AJ
+hbNs+uWft21O9L0URQ1oim2GQ6q3dUgLLEfRUZS969RmfA+szElAhLTytxTbqbx
Sq+LMsYl15ovHXwOq/EjQw0H1RCTdSxHgkVuvS/rGLlK+CDOi2MSM7RNz4PEGkxp
FiW/umrMXuqP7TAT+R22IbHsjvSyf/auUPNzZ8989TisAi3+W8ON1dw7UsMKwJqb
CX7RiSTy5JtFAs31iuyUZnQKcofTtbt/lJrV6fQAgWKYP+xoYBq3SbaHFG2YnGcz
OEj2d7IBuTjQoVsOSF2BLnTWgv+RcwrdV68LLasjpmidIDOP/kxT310sVhEcbJdM
Ktga5zDOh84xXSdq7kieXsNxjNV4RyQpA+M4avENzaH0PokZDP61NPj0Hf4cgaIB
wFZ6aqPAfa4seJCQmFAfulMj9hZ81SYJatb805lTTXzE/5tJdQ4Jl3voMG9TwpX+
DOuLeRqZMQV6zlxYtjr+
=y/ym
-----END PGP SIGNATURE-----

--nextPart9413309.HYjPiJ1mj4--

