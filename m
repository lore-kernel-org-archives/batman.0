Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH 4/4] alfred: introduce 'server status' IPC call
Date: Wed, 12 Jan 2022 22:14:15 +0100
Message-ID: <4305571.4q7vW2cpkv@rousseau>
In-Reply-To: <3214693.Z0pQRKLR2l@sven-l14>
References: <3748133.vRqKQLy7FI@rousseau>
 <20220102113136.470299-4-mareklindner@neomailbox.ch>
 <3214693.Z0pQRKLR2l@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1666924.J7kI1vASPN";
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
To: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart1666924.J7kI1vASPN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH 4/4] alfred: introduce 'server status' IPC call
Date: Wed, 12 Jan 2022 22:14:15 +0100
Message-ID: <4305571.4q7vW2cpkv@rousseau>
In-Reply-To: <3214693.Z0pQRKLR2l@sven-l14>
References: <3748133.vRqKQLy7FI@rousseau> <20220102113136.470299-4-mareklindner@neomailbox.ch> <3214693.Z0pQRKLR2l@sven-l14>

On Sunday, 2 January 2022 15:43:37 CET Sven Eckelmann wrote:
> @Simon, would you prefer to have a global "status" message (which cannot be
> extended in the future) or separate "GET" queries for the existing commands:
> 
> * ALFRED_MODESWITCH -> ALFRED_GET_MODE
> * ALFRED_CHANGE_INTERFACE -> ALFRED_GET_INTERFACES
> * ALFRED_CHANGE_BAT_IFACE -> ALFRED_GET_BAT_IFACE

Another option would be to work with TLVs inside a single server status 
request. This would minimize the number of added packet definitions and retain 
future extensibility.

Cheers,
Marek

--nextPart1666924.J7kI1vASPN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAmHfRKgACgkQU1VOj+62
HMBbqwgAuPJgAEZZ/j7jRvBbOeDNK96krIhmiBBhMDL8nTMXsfJlD/+A6K96Kg05
Hh0SoWwjBXuw54CL3hBFWsKr29MRazND80/XRzLwY1jJaVnB/y3FIVJ4B3pzgA2b
bELwCQdUUfOBlsGBhXXPB6UyDMEzGbmFlY/g3aZRuO2PS87h91LgE4UEGvaE9GyM
fD1UmiTTAVtbtw1ZBY+merlQu9Fzb5tYdeDn+mz382hZ4Ul/Eyz77kn9WHtiOzw8
rqbSKogwtyuZjS4KetqjFuSrE3gW6zJWbBFqGbblVlmJHcYn+GQ0u+ve/D2znsbj
xQt3inNbHnKanGH78v+MLmLJ74KJ3Q==
=2Vye
-----END PGP SIGNATURE-----

--nextPart1666924.J7kI1vASPN--


