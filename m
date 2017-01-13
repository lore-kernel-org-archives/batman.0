Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 13 Jan 2017 08:31:09 +0100
Message-ID: <8483867.uzBTzBJoDH@bentobox>
In-Reply-To: <CAEhDGG==nXsChyg6iekEit-TeRKHEte8VrgW_hreaXoX6YN2qg@mail.gmail.com>
References: <CAPkwMUejbf31RfVY_nCJSVwe=_mGVO3y5PY9zzfkQk0eDc1HTA@mail.gmail.com>
 <2739485.ZOxij8zM53@bentobox>
 <CAEhDGG==nXsChyg6iekEit-TeRKHEte8VrgW_hreaXoX6YN2qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4079922.nFXbjXPOm7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Fail to create tunnels using br-lan
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrei Buciulea <andreibuciulea@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Francisco Javier =?ISO-8859-1?Q?Sim=F3?= Reigadas <javier.simo@urjc.es>

--nextPart4079922.nFXbjXPOm7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 12. Januar 2017 20:27:34 CET Andrei Buciulea wrote:
[...]
> *> The tunnels can be successfully created in OpenWRT*I have created the
> tunnel and assigning the mesh devices an IP(192.168.100.5):
> The other one mesh device IP is: 192.168.100.4
> 
>       tun0      Link encap:UNSPEC  HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
>                  inet addr:192.168.100.5  P-t-P:192.168.100.5
> Mask:255.255.255.0
>                  UP POINTOPOINT NOARP MULTICAST  MTU:1500  Metric:1
[...]
> If anyone has any idea why it does not work I would be very grateful.

Sorry, but I still don't get what are you doing with layer 3 tunnel stuff and 
what batman-adv has to do with it (it is a layer 2 based protocol which 
requires layer 2 interfaces).

Kind regards,
	Sven

--nextPart4079922.nFXbjXPOm7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlh4gj0ACgkQXYcKB8Em
e0YIhw/9EaIu34ziRHHx8jWnmFsYomESuUV+7ukHNohhplH43B43yNsQebHl+ado
gb33xa9dJvUWVIZ3Mmv3GhHCaexCYMeB2UDObq/Nrv0V1+aJWvq9ZvW9DtihzQvm
J+4gzXkHkuF2ziGblnB7uLyW7Jq/JWa+A9+I43FAjR042wnHcxwckkXphWqaEoUa
zu2UabhTD8OJq+fqYhddiYSzKfrgYROnhhiuQE1BFFacuBWJUMxpAWaKKaf0R5cY
19cD8QRLBBIHGhIs5U0NkLYnbAu3wFahsWLQ8VjAiMjHbjl4PwkbBMiyAmj2trhU
SKmGW944vKxgtO5tXUHKHS+sW4Uv+nqbKlR1ap5ov/NNqSFPgPyNIMuJcNOqnAPT
4JVLBxOZ1dGHFFWqTBECEGqm1O0EFNTI60q+DkGXt5dogkV8sZ6wuqTY7dY950Y5
XrIWeMGrpy+46REWE64RfuUF7jVLej27TSDQiYr5vdJ10FuYtGmHMkE9qKPfTkUN
X+OkDaAGnrjHHSRsBOvvQGUor4ol1yNp6x0WSU5u8fkWkiAUWXAhqaEPN5MaWCRx
1zs1IR20c0DIHCsm9+UdcAP9tXNznKkimCunYuNDp374GvPJArfvsYd/GJWGgBHy
UmRR/pHbG1TNdkj7remoN5oQU2JSpCY5L4hlgSvXsBbtiJprZKk=
=obb+
-----END PGP SIGNATURE-----

--nextPart4079922.nFXbjXPOm7--

