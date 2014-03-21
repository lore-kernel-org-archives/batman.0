Return-Path: <antonio@meshcoding.com>
Message-ID: <532C10A0.4040102@meshcoding.com>
Date: Fri, 21 Mar 2014 11:12:48 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1629001.Cx5dbnsKCT@lappi>
In-Reply-To: <1629001.Cx5dbnsKCT@lappi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gMdr164nWR517E5u8W0i4DCMRdpG6soLF"
Subject: Re: [B.A.T.M.A.N.] Batman-adv  + lxc
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gMdr164nWR517E5u8W0i4DCMRdpG6soLF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Christof,

On 20/03/14 19:59, Christof Schulze wrote:
> How can batman-adv be used from an lxc-container?

I never used LXC, therefore I might say something terribly wrong:

what about bridging the real interface that you want to use for the mesh
in the container and then load batman-adv inside LXC ?

If I understood correctly after bridging you should have an interface
(inside LXC) that you can give to batman-adv (inside LXC).


Cheers,

--=20
Antonio Quartulli


--gMdr164nWR517E5u8W0i4DCMRdpG6soLF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTLBCoAAoJEEKTMo6mOh1VMzIP/jdi4H6Cio1gUxYn/aXURRAc
chFw0WQgZKCJ/0Alt3OnoWtEdOdp5qWrqTF6q0zIg4s/OF+JJqSudQDto+XbZ0y2
DVIyj17KFmjLg7N0hpD4pFq//S4E1Me8ef5eVYbGo4fChyXYUkAzP0A2ceSWg7Ip
bZrZxDYYT13KfG2mbxuktNS6368ZmrwwoPeOB01RCZNQPlO0u/pklK0e8OP16oP4
aqboUs/drF3sELZrYP/cNzHUIwHKhVuYLdNHI4BP87BNudWnDrCV/+JnYzQLeMA0
TZRNHcc8SAlYRoxr2XNPKQilQ5P9u9Xma4ORBcj4ILC141Ezy+/u96s1msvgRfMs
gYqA48a0YWCXL4j22wZbmbl6fwDPmZbxbx9sZa7rPvv1Hp1UsxqG8GB1Wnl/Ozv4
L2VW7t0+jdCN+jIl4yhknyBOTQeldsJrMHSoon7o8yeOJ6MNen6CKd9t1gBF30as
t9NKHtO2+I0ZfXMi0MeuZgA+EAAdA0lGpa1ythDYMqaoi/NpFiXEfHLhdowQ6rG1
+l1JZIJuuHcDx9WX0Rr4MgJkaV9LK3nZ56mxYFkt54KkPNHL+GSeo0sLJuHOAqn7
bRgz1Jfx7/N/urkpMlK1XG2AhjByEzlbzux9PD1QLfN/EIYNHAgkxJ+6H3lF4dDu
Nu0EHJwZ9Hkc05wZw7l/
=LJrQ
-----END PGP SIGNATURE-----

--gMdr164nWR517E5u8W0i4DCMRdpG6soLF--
