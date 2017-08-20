Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 20 Aug 2017 08:45:38 +0200
Message-ID: <2340031.huMGDjgIrt@sven-edge>
In-Reply-To: <CAA_JP8Wk17XHM+H2d5dWkoWgS7dabwDhvPnR0n6wtiP1BxCqiA@mail.gmail.com>
References: <CAA_JP8Wk17XHM+H2d5dWkoWgS7dabwDhvPnR0n6wtiP1BxCqiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1779067.2MaZLJASTT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] can batman-adv carry a vlan?
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

--nextPart1779067.2MaZLJASTT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 16. August 2017 09:47:08 CEST dan wrote:
> Can batman-adv carry a vlan?  For example, 2 mesh nodes are directly
> connected via eth0 on both devices.  bat0 contains eth0 on both
> devices.

batman-adv was able to transport 802.3Q tags (and similar mechanism) since the 
beginning. But there were some changes [1] in the past to make TT VLAN 
aware [2]. But this is only required when you have your clients connected to 
different batman-adv instances with different VLANs (for example AP1 has the 
client in VLAN 23 and the AP2 has the client in AP42).

The pre-2014.0.0 implementation has the benefit that the VLAN23 and VLAN42 
don't have to be configured on top of bat0 to let batman-adv transport 802.3Q 
tagged frames for VLAN23 and VLAN42 [3]. But the new implementation has the 
benefit that an client entry on two different VLANs and two different 
batman-adv instances is not seen as conflict and just works out of the box. 
This is possible because client X + VLAN23 and client X + VLAN42 are handled 
since 2014.0.0 as two separate entries in TT.

> Can a bat0.20 vlan be created on each side and will batman-adv pass
> traffic assuming 1532 MTU is set?

Don't forget that the 802.3Q VLAN header requires also 4 bytes [4].	

Kind regards,
	Sven

[1] https://www.open-mesh.org/news/56
[2] https://www.open-mesh.org/projects/batman-adv/wiki/Client-announcement
[3] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2017-February/016904.html
[4] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-November/016676.html
--nextPart1779067.2MaZLJASTT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlmZMBIACgkQXYcKB8Em
e0Z7sg/+IZlosuVmjoXvcOtophyfRMhCheA8Uwznwso/gqP+OkMntLiFtmFVkX4b
GwnMZSku5b8/RliJ0dtgyAkVrtE1dwTElp03uWzLuXy2sudx7br/uKd4P76oF1Ag
NOri20vT5fU3QSjTPVuBCteLZohev6PxIuy3WSzWXrjCRlMoiIhISVAky5fGE9eC
eFd47GsVTdG/tsxO5X80XJpzox4tAhBd8/HFw7sEwYcdWuLwvJ1p8S9xIWQBk/hS
SiNCqqiWMb7bnaU7PoB2oBd9TLwsRkf8R+3xGSvusqUP1JGjc9w5vjssqMi5epYP
3/0+a7dFwLL7jhl1G6u3VTilIDLa0h/KPeDWCGnZHow0Rp5v0cVMxfsNRQXXAril
mOIrxX3YllS0/xNA8TD2KFnVwJ8067z7mO8OVR86sF/l3IHxgWdiHFC40DTPSnPj
pIqO9HMD+6W6vdZhjD7FGhfeSSdNYead5O25OTRyEPjMIbgxIoG0mZ2HxTk09CwE
Cp/ej7aMOmblHm9Bi5il/NTK86FKzx0LgANBbEc3OawKH5L1NdR2krKDZkywfp0b
042UIRc0gaRo+lrUeYddmRPIPNvFZBMifBI4mbd2jb6QnJ5YdCZnXcuzE/Lub6Od
UCBNlsGSZBejZFcrw+NhcLNXcqfvC53g3xqKLyZTBJTFz3KbloM=
=kI6G
-----END PGP SIGNATURE-----

--nextPart1779067.2MaZLJASTT--

