Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 4/4] alfred: introduce 'server status' IPC call
Date: Thu, 20 Jan 2022 09:25:32 +0100
Message-ID: <57523634.IhAzvE0y8L@ripper>
In-Reply-To: <4305571.4q7vW2cpkv@rousseau>
References: <3748133.vRqKQLy7FI@rousseau> <3214693.Z0pQRKLR2l@sven-l14>
 <4305571.4q7vW2cpkv@rousseau>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4008829.gq60Wp5BfP";
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

 
--nextPart4008829.gq60Wp5BfP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH 4/4] alfred: introduce 'server status' IPC call
Date: Thu, 20 Jan 2022 09:25:32 +0100
Message-ID: <57523634.IhAzvE0y8L@ripper>
In-Reply-To: <4305571.4q7vW2cpkv@rousseau>
References: <3748133.vRqKQLy7FI@rousseau> <3214693.Z0pQRKLR2l@sven-l14> <4305571.4q7vW2cpkv@rousseau>

On Wednesday, 12 January 2022 22:14:15 CET Marek Lindner wrote:
> On Sunday, 2 January 2022 15:43:37 CET Sven Eckelmann wrote:
> > @Simon, would you prefer to have a global "status" message (which cannot be
> > extended in the future) or separate "GET" queries for the existing commands:
> > 
> > * ALFRED_MODESWITCH -> ALFRED_GET_MODE
> > * ALFRED_CHANGE_INTERFACE -> ALFRED_GET_INTERFACES
> > * ALFRED_CHANGE_BAT_IFACE -> ALFRED_GET_BAT_IFACE
> 
> Another option would be to work with TLVs inside a single server status 
> request. This would minimize the number of added packet definitions and retain 
> future extensibility.

Just asked Simon directly and he seems to prefer the sub-TLV solution over the 
single requests.

Kind regards,
	Sven
--nextPart4008829.gq60Wp5BfP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmHpHHwACgkQXYcKB8Em
e0YlKxAAkY0BPvW21IkFU+DS4dGf2w7ls97KkXv1O1VPh6t6B9iipp6M9C88szKf
2yUsiSO2u0VgYT8i0AfeJDMu97YOnKYF4ZKopp90bvEX2SYo5wLwb6AKC5GSwZkH
jY/9ubW0TfLRRwSY0+ZMFKe3ZOcwmj4DHnd5ta9yzcMH7bbcwXjnm9qJUjNsHIOM
oxOPXSYrl6UZN6+gYysSlCTV5XMZd5GyGAq0Qr+V7qk4WxpD9CIdRWMS+TtKMAML
ERDkloMjDgrIT6ctnGqQWib25Si/d5HU3QHqNUxDkiODvceXzIZcjltUXMlAsRRW
izxtGiXmnqyd0VVWQdXJDGRzbvk8sOKaEUQawjY1gTUYyvF6/ElkoWRFuKdanyQS
iH1u+gDXhecIG4+KHRakj0Un4ODZwdAw+bqmGaNvZseJQWIpHWQuK4uK+oju/QN2
TiiYifNrYfNXI7SGkdq7wN8tnOERmG5TK2R97p5a5Wqh+Mm7V/7pTTGbOPWxGh9t
o4FkK4JAyQYMcWhNK0a1cAXoX6xgMX6+lxGnAuE5lFj2qxqz4heXp8MaGKGV+Yoh
lDUqYOO0gLqG+ayf4nVOjgZ+F4ga9xCph2SoxCd6TrXg2kx4IVamFSQDCx/5ZD2X
mVxn9OExRMShcfE5d8WyMAYUwhBBUFOkF90Czab0Y5X0qWLpwWw=
=BHbG
-----END PGP SIGNATURE-----

--nextPart4008829.gq60Wp5BfP--


