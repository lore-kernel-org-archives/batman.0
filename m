Return-Path: <jj.sarton@t-online.de>
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
Message-ID: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
Date: Fri, 4 Nov 2016 22:37:24 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mterVCg5SMJJ5mhKuI5LVkWbGEQJ2csJS"
Subject: [B.A.T.M.A.N.] Batman an more than one Gateway
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: B.A.T.M.A.N@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mterVCg5SMJJ5mhKuI5LVkWbGEQJ2csJS
Content-Type: multipart/mixed; boundary="MBNJX2SWB3L3nQ3O4pIk8tExEiIJDEmfn";
 protected-headers="v1"
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
To: B.A.T.M.A.N@lists.open-mesh.org
Message-ID: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
Subject: Batman an more than one Gateway

--MBNJX2SWB3L3nQ3O4pIk8tExEiIJDEmfn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I have take a look to the configuration of our gateways.
Inho there are some points which are not OK,
Broadcasts are rebroadecasted on a wired connection,
this seem for me to be an issue.

Our network has two gw which are interconnected.
I have listed the interfaces and the output from
batctl on the GW and also what batxtl said on a node

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 Interfaces for gateway Q0:
 br0:	         12:e8:ef:7f:0d:c7
  bat0:          12:e8:ef:7f:0d:c9
   ftun-q1:      12:e8:ef:7f:0d:c8
   mesh-vpn:     aa:ff:ca:ca:fe:03

-------------------
# batctl gwl
      Gateway      (#/255)           Nexthop [outgoingIF]: advertised upl=
ink bandwidth ... [B.A.T.M.A.N. adv 2014.3.0, MainIF/MAC: ftun-q1/12:e8:e=
f:7f:0d:c8 (bat0)]
   ca:b1:f2:63:f3:cf (251) ca:b1:f2:63:f3:cf [   ftun-q1]: 50.0/50.0 MBit=


--------------------------------------
On node (connected with Q0):

# batctl n
[B.A.T.M.A.N. adv 2016.4, MainIF/MAC: mesh0/92:fb:53:11:44:f1 (bat0/90:f6=
:52:11:44:f1 BATMAN_IV)]
IF             Neighbor              last-seen
     mesh-vpn	  aa:ff:ca:ca:fe:03    3.342s

---------------------
# batctl gwl
[B.A.T.M.A.N. adv 2016.4, MainIF/MAC: mesh0/92:fb:53:11:44:f1 (bat0/90:f6=
:52:11:44:f1 BATMAN_IV)]
  Router            ( TQ) Next Hop          [outgoingIf]  Bandwidth
* ca:b1:f2:63:f3:cf (240) aa:ff:ca:ca:fe:03 [  mesh-vpn]: 50.0/50.0 MBit
  12:e8:ef:7f:0d:c8 (255) aa:ff:ca:ca:fe:03 [  mesh-vpn]: 50.0/50.0 MBit

Translated Interface/Location
   ftun-q1/Q0       (255) mesh-vpn/Q0
*  ftun-q0/Q1       (240) mesh-vpn/Q0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Interfaces for gateway Q1:
 br0:	         ca:b1:f2:63:f3:cd
  bat0:          ca:b1:f2:63:f3:cd
   ftun-q0:      ca:b1:f2:63:f3:cf
   mesh-vpn:     aa:ff:ca:ca:fe:01

---------------------
# batctl gwl
      Gateway      (#/255)           Nexthop [outgoingIF]: advertised upl=
ink bandwidth ... [B.A.T.M.A.N. adv 2014.3.0, MainIF/MAC: ftun-q0/ca:b1:f=
2:63:f3:cf (bat0)]
   12:e8:ef:7f:0d:c8 (255) 12:e8:ef:7f:0d:c8 [   ftun-q0]: 50.0/50.0 MBit=


--------------------------------------
On node (connected with Q1):

# batctl n
[B.A.T.M.A.N. adv 2016.4, MainIF/MAC: mesh0/92:fb:53:11:44:f1 (bat0/90:f6=
:52:11:44:f1 BATMAN_IV)]
IF             Neighbor              last-seen
     mesh-vpn	  aa:ff:ca:ca:fe:01    4.413s

---------------------
# batctl gwl
[B.A.T.M.A.N. adv 2016.4, MainIF/MAC: mesh0/92:fb:53:11:44:f1 (bat0/90:f6=
:52:11:44:f1 BATMAN_IV)]
  Router            ( TQ) Next Hop          [outgoingIf]  Bandwidth
  ca:b1:f2:63:f3:cf (255) aa:ff:ca:ca:fe:01 [  mesh-vpn]: 50.0/50.0 MBit
* 12:e8:ef:7f:0d:c8 (240) aa:ff:ca:ca:fe:01 [  mesh-vpn]: 50.0/50.0 MBit

Translated Interface/Location
   ftun-q0/Q1       (255) mesh-vpn/Q1
*  ftun-q1/Q0       (240) mesh-vpn/Q1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Regards,

Jean-Jacques


--MBNJX2SWB3L3nQ3O4pIk8tExEiIJDEmfn--

--mterVCg5SMJJ5mhKuI5LVkWbGEQJ2csJS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF0EARECAB0FAlgc/5QWHGpqLnNhcnRvbkB0LW9ubGluZS5kZQAKCRAz0luJHcLB
C5cpAJ0WRckUdK5FJTK5cdoGic8iOjwI1ACePikRiPiQIl9VwDOBYK/Pjbtsspo=
=xVZB
-----END PGP SIGNATURE-----

--mterVCg5SMJJ5mhKuI5LVkWbGEQJ2csJS--
