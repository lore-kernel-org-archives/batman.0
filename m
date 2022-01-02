Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 4/4] alfred: introduce 'server status' IPC call
Date: Sun, 02 Jan 2022 15:43:37 +0100
Message-ID: <3214693.Z0pQRKLR2l@sven-l14>
In-Reply-To: <20220102113136.470299-4-mareklindner@neomailbox.ch>
References: <3748133.vRqKQLy7FI@rousseau>
 <20220102113136.470299-1-mareklindner@neomailbox.ch>
 <20220102113136.470299-4-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1985126.cY4G8qPslE";
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

 
--nextPart1985126.cY4G8qPslE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH 4/4] alfred: introduce 'server status' IPC call
Date: Sun, 02 Jan 2022 15:43:37 +0100
Message-ID: <3214693.Z0pQRKLR2l@sven-l14>
In-Reply-To: <20220102113136.470299-4-mareklindner@neomailbox.ch>
References: <3748133.vRqKQLy7FI@rousseau> <20220102113136.470299-1-mareklindner@neomailbox.ch> <20220102113136.470299-4-mareklindner@neomailbox.ch>

On Sunday, 2 January 2022 12:31:36 CET Marek Lindner wrote:
> +       list_for_each_entry(interface, &globals->interfaces, list) {
> +               strncpy(status_rep->ifaces[iface_count].name,
> +                       interface->interface,
> +                       sizeof(status_rep->ifaces[iface_count].name));
> +
> +               iface_count++;
> +       }
> +
> +       strncpy(status_rep->bat_iface, globals->mesh_iface,
> +               sizeof(status_rep->bat_iface));

strncpy doesn't guarantee that the copied string ends with a \0. You have to 
take care of that yourself.

This might not be a big problem here because the name buffers in the 
interfaces list have currently the same size as the name buffers in 
status_rep. Still feels better to have the line to manually set \0 at
the end of the buffer.


Another thing I've just noticed: You don't take care of initialization all the 
bytes in the returned buffer. So you might leak data from the alfred process's 
stack to the client.


@Simon, would you prefer to have a global "status" message (which cannot be 
extended in the future) or separate "GET" queries for the existing commands:

* ALFRED_MODESWITCH -> ALFRED_GET_MODE
* ALFRED_CHANGE_INTERFACE -> ALFRED_GET_INTERFACES
* ALFRED_CHANGE_BAT_IFACE -> ALFRED_GET_BAT_IFACE

Kind regards,
	Sven
--nextPart1985126.cY4G8qPslE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHRuhkACgkQXYcKB8Em
e0Zmpg//Z2FE5UTd68Kv46gh5YhqhfIhPdbuq1T+jqOA8TuAJwKJYg3tMZVzRjkP
wNPe9Dtzih7+FtenTee6IG6GakZzvfEzlJVTRNyMUuwgExinVzHWcglQi9plp33N
Eo8ThW2wH9CUXW8GOeiukFXnKTOYQVK1BFGY25dpRbRvkH6AigJORj9W/XTgpN1u
5aAEwhmJmTDRhINAeLVpczGoFtFMEJwkuLcbhNgQgiMQUOT8i9l2pkcmgz71H/48
SlbVue9+qD4FC9ADqEwC/vqhGfGU6ci7hGA65lf3iSu8Gd0wHOxfp6EFcBV1coXj
Esh+TaUoc2RfqlyPPGN/FYSmCFZzNj+JZD+AJkXrkJ3bR/o5dKmFWLdH/KmKEsrX
aUIyA+bRIE1pA3nun3KNLawP4+0xV1YI+cPjGimCp/JXoEFOVc/rxybl5PZlbmpk
5z5G083bwk3jERiRlCf6kTxM0tMjN17mai/HuLmwJJtzD1WUGK8llDLejORCnJXQ
RIVuqmRF/vktr1Fv7gohsXSaG3hS8MHLLCUEEDeaVWmBqKoeBGuGdy9DVWPjKyou
RXebHqcJzlRIDYzA5fIV7QovU22J36tx6U0w9uwRbUOI9+GIT7pzghUjIs6VJyaF
FaewJmecjGSExN/n9YxlI6k5UCCUDAe+nxhcDjZ22FYpJrSV+F4=
=ftMA
-----END PGP SIGNATURE-----

--nextPart1985126.cY4G8qPslE--


