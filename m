Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 02 Aug 2017 21:40:01 +0200
Message-ID: <6131794.gKgmBHkUSh@sven-edge>
In-Reply-To: <CAAAG0x8tVYAFisRAE6iLdvoPuKFcpyMQ0vS_DD72+AjcUWcQ6w@mail.gmail.com>
References: <CAAAG0x8tVYAFisRAE6iLdvoPuKFcpyMQ0vS_DD72+AjcUWcQ6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1513162.4EvpaD4hIg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] help regarding interfacing b.a.t.m.a.n with
 mininet-wifi
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
Cc: Abhinanda Dutta <duttaabhinanda@gmail.com>

--nextPart1513162.4EvpaD4hIg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 2. August 2017 12:54:13 CEST Abhinanda Dutta wrote:
> Is there any way to make batman-adv interact with the real
> mininet-wifi environment.

You've provided nearly no information. So I can only provide some general 
advices: Make sure that you use a net-namespace aware version of batctl and 
batman-adv (>= 2016.5). Make sure that you start batctl in the correct 
namespace. Check the debug tables and the interface configuration in your 
namespaces. Check with wireshark which paths the packets take between the 
hwsim interfaces.

Just to make it clear: I've never used mininet-wifi. I've only used mininet (+ 
some special openvswitch based configurations) + kvm instances per namespace 
to simulate some networks with older versions of batman-adv.

Kind regards,
	Sven
--nextPart1513162.4EvpaD4hIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlmCKpEACgkQXYcKB8Em
e0ZkHA/+J3E4FZJ3rFKNJO49tW46jufs7rYLpp4CokwmMWrBzab5z3Zq43i5rz+Q
mwbiXeQ6okQN9geR7V6rTRvQ3fn6HY1UFCe9Z2UKapv9/pu6EUYlvl1IUfW6tpnM
ojr0ygVnRrYatzxAcp3AeoXOnRGtPZk8qMOPS5StJsUoId0f0Q47x9O56bfbkl2V
Lrz2sh6ZIWwbX3simyLknl4B8O1MkacEUpkdOUDP2akKd+ZXL112Pv61SpLaaGQC
WBqq9UqN+BgaDAnza+J7U1qj0maFfXA1Ti5PFt3AS8VZ6UmLtN0qTrhpA1sMVTJ4
UuFAChgOeF+cKEFBKC4OBDc4gWg7AGNA8Nbpmi4QcAS9GtpwQ0nQLG3vapRZGvdD
CRAHjCse+WZoF3Mgs6sI6b4jQn218ZIuUuLeKP+bsWMDjkdhFvJ0QoSRdv9J9pEy
L5AawdLoD1XAUOk7/cyNeSz0KzlU8gqrNRm9ouX3NegZkwDKCiEPHl+oJqvhnOJy
NNf6b/ITditxlw3ITwkRTquHNFggxv1Z/vBjJ2V6gN0L2FRMjNmR1i0Hi8XWKN9v
uyrOR4jWQPTuxwBePB7JYotSuiNBxbdzCqtiY4tS4XjQShuYI3vg1K3OiofGABaD
1LPPgEqvzCM8tTtjgfEWoRJXTA4rgVYC4OunD33agTRhXokmo9Y=
=lQfA
-----END PGP SIGNATURE-----

--nextPart1513162.4EvpaD4hIg--

