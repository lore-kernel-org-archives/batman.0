Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH 2/4] alfred: Allow operating without any interface
 specified
Date: Sun, 02 Jan 2022 20:01:47 +0100
Message-ID: <2907656.mQGJSZOrAB@rousseau>
In-Reply-To: <2887321.KE3FGX6OkO@sven-l14>
References: <3748133.vRqKQLy7FI@rousseau>
 <20220102113136.470299-2-mareklindner@neomailbox.ch>
 <2887321.KE3FGX6OkO@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3773800.9PjQFFAlAC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>

 
--nextPart3773800.9PjQFFAlAC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 2/4] alfred: Allow operating without any interface specified
Date: Sun, 02 Jan 2022 20:01:47 +0100
Message-ID: <2907656.mQGJSZOrAB@rousseau>
In-Reply-To: <2887321.KE3FGX6OkO@sven-l14>
References: <3748133.vRqKQLy7FI@rousseau> <20220102113136.470299-2-mareklindner@neomailbox.ch> <2887321.KE3FGX6OkO@sven-l14>

On Sunday, 2 January 2022 15:20:20 CET Sven Eckelmann wrote:
> This now causes the "--force" option (+its storage in the globals data
> structure) to be completely useless. 

Why would global->force be useless ? The alfred_server() function still uses 
the global->force state to determine if globals->mesh_iface is configured 
correctly.


> I would prefer to have this handling still be there when
> !list_empty(&globals->interfaces).

To be honest, I hadn't fully understood what use case global->force is trying 
to address. What do you have in mind ? Checking for list_empty() will require 
alfred to be always started with an interface configured while alfred could be 
used without any interface at all and operate as local data storage between 2 
processes on the same system or the interface could be configured at a later 
time (via unix socket).


> And why is it necessary to not open the sockets on startup when interfaces
> are already given?

The main while loop calls netsock_reopen() in each round which will open all 
necessary sockets (unless I am mistaken). My guess is that this was added when 
the ALFRED_CHANGE_INTERFACE call was added. Therefore, the netsock_open() call 
is somewhat redundant unless alfred is meant to always require an interface at 
startup time and alfred is meant to bail out whenever that configured interface 
isn't available at startup time.

Cheers,
Marek

--nextPart3773800.9PjQFFAlAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAmHR9psACgkQU1VOj+62
HMAOIAf+O9I2ZvZVvhTnc39IlRDyNBR19PK5t0p/4JxYT5ScjD3ORUu1EmEh6lS4
ByzhAi03m/CoWdexfYGrJwQ0RGf1B8ZTyQnoljXlAOzfN5GnwkR0wTY+LZRhM7Jh
ILFusl2tKilS4qZwHcUqIoICFTJEmMJZOa4T+EO5WSrYEf4B3OxzfcRmJwDDHV1X
nYDerm23AS1q8WshwciJjJNSwrpEif6tD0iLZiKOdb2ND0CEnHeKJFbu+2ntIWAI
+aDCd8uvxKdJlCJF2Oo8nBvKwmUdFdwMhx94vVDsEiIf3QuXo7B4KscvVjMhAmq2
1EhfUsbh8wfoXZ1LpVo1MNjbV/lgTQ==
=bhm0
-----END PGP SIGNATURE-----

--nextPart3773800.9PjQFFAlAC--



