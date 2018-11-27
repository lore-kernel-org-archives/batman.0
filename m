Return-Path: <github@r.z11.de>
From: Ruben Barkow <github@r.z11.de>
References: <50dd4215-efd3-2b89-874f-bbf7330bf37a@r.z11.de>
Message-ID: <bd7bec9a-c380-aa64-3cdd-e3cb63d0394a@r.z11.de>
Date: Tue, 27 Nov 2018 15:00:39 +0100
MIME-Version: 1.0
In-Reply-To: <50dd4215-efd3-2b89-874f-bbf7330bf37a@r.z11.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="60b9ITu4gtbOEWaQruqSk8WEVzUdHBPsq"
Subject: [B.A.T.M.A.N.] batctl: Add section to explain gateway selection
 class for BATMAN_V
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
--60b9ITu4gtbOEWaQruqSk8WEVzUdHBPsq
Content-Type: multipart/mixed; boundary="kVMdeHD47SGP6qcn18V5vfE305tobGCGr";
 protected-headers="v1"
From: Ruben Barkow <github@r.z11.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <bd7bec9a-c380-aa64-3cdd-e3cb63d0394a@r.z11.de>
Subject: batctl: Add section to explain gateway selection class for BATMAN_V
References: <50dd4215-efd3-2b89-874f-bbf7330bf37a@r.z11.de>
In-Reply-To: <50dd4215-efd3-2b89-874f-bbf7330bf37a@r.z11.de>

--kVMdeHD47SGP6qcn18V5vfE305tobGCGr
Content-Type: multipart/mixed;
 boundary="------------F72DBDDE036FE557B3E12326"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F72DBDDE036FE557B3E12326
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As mentioned here: https://www.open-mesh.org/issues/366#note-8

I added a fix to the formatting, so this is the final patch:

Signed-off-by: Ruben Barkow <github@r.z11.de>



--------------F72DBDDE036FE557B3E12326
Content-Type: text/x-patch;
 name="0001-batctl-Add-section-to-explain-gateway-selection-clas.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-batctl-Add-section-to-explain-gateway-selection-clas.pa";
 filename*1="tch"

=46rom c3561b556c57546b2a089b830bd78ada7cd46218 Mon Sep 17 00:00:00 2001
From: rubo77 <github@r.z11.de>
Date: Tue, 27 Nov 2018 13:40:29 +0100
Subject: [PATCH] batctl: Add section to explain gateway selection class f=
or
 BATMAN_V

Signed-off-by: Ruben Barkow <github@r.z11.de>
---
 man/batctl.8 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/man/batctl.8 b/man/batctl.8
index 2e3232f..ed8e71f 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -144,6 +144,9 @@ examples:  5000 \->  5.0/1.0 MBit
 If the node is a gateway client the parameter will decide which criteria=
 to consider when the batman-adv module has to choose
 between different internet connections announced by the aforementioned s=
ervers.
 .RE
+.RS 7
+B.A.T.M.A.N. IV:
+.RE
 .RS 17
 default: 20 \-> late switch (TQ 20)
 .RE
@@ -168,6 +171,20 @@ chooses the gateway with the best link quality but s=
witches to another gateway a
 least XX TQ better than the currently selected gateway (XX has to be a n=
umber between 3 and 256).
 .RE
 .RE
+.RS 7
+B.A.T.M.A.N. V:
+.RE
+.RS 17
+default: 5000 \-> late switch (5000 kbit/s throughput)
+.br
+example: 1500 \-> fast switch connection
+.RS 17
+switches to another gateway as soon as a better one is found which is at=
 least=20
+1500 kbit/s faster throughput than the currently selected gateway. Throu=
ghput is
+determined by evaluating which is lower: the advertised throughput by th=
e
+gateway or the maximum bandwidth across the entire path.
+.RE
+.RE
 .br
 .IP "\fBrouting_algo\fP|\fBra\fP [\fBalgorithm\fP]\fP"
 If no parameter is given the current routing algorithm configuration as =
well as
--=20
2.17.1


--------------F72DBDDE036FE557B3E12326--

--kVMdeHD47SGP6qcn18V5vfE305tobGCGr--

--60b9ITu4gtbOEWaQruqSk8WEVzUdHBPsq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEc4/4iBsWuuBVYgULkXRByBJwXLAFAlv9TgcACgkQkXRByBJw
XLDvrA//V31Ne8v9CPfpFuX6n+GEHJwbDJu25BUY8rBcGro3FZ58ULlXhskl0TM9
NYWMTSWvW7Gj6k8yX06RHzd4ESXW4qaj+pm+nkKhZrWxEjY5aA1+ISASdkzFuK0r
GiJIcUqd73l4sLzpDm0+vy3mcuB2T83RQna5gfwZx1ofW5q+v/ExakZTNs1VRlIy
WBNu0wO//w+uWj7FnI4OL4JiYrGzM8+zNQBem5l1vOQS2zZGpITtTz5u1fRZPEMJ
3rA+Xc8agZl6ibIlsc1+fvcUJ+sqTf9CxGXRIbCfGZIxfaLEubICmykm3YO/CQo7
hVMJvEtNjxO8dxErjI2VBcRi16xRKkilsPPOFY3qf44oRWDNLiLmAnvG4lZDqJxf
6uu7nWqz/QmwuhfUWtq8J3wO0HRPJ46mYItCCw2Cz1/PFOIRVyqh1N5ItJesxRBE
4LYAJvgT6OAHqfNybyyfUJNaBXTCZDFEN7SImUi4wencvODI/7oBVX0356R5xRRc
O/b59tkmOQlqRnsmkHZdKZvKhsQ8xw1Vc2jIWfh/6J6mXnOrRilt1SjDLyIBj4n+
v/nP4z/ELvI0uC+P/mJwQ7jfe/3pZXXgKouF//PxTBQIsD/9dHGPhS+GN9/5bP9S
4MpplD4kyhlsk6qMZi8v5TVK2ByyuFk6SFDzvPdtE7FoeyolVJQ=
=VoEs
-----END PGP SIGNATURE-----

--60b9ITu4gtbOEWaQruqSk8WEVzUdHBPsq--
