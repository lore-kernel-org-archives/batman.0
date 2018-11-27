Return-Path: <freifunk@r.z11.de>
From: Ruben <freifunk@r.z11.de>
Message-ID: <50dd4215-efd3-2b89-874f-bbf7330bf37a@r.z11.de>
Date: Tue, 27 Nov 2018 13:43:33 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NktFsUUMEcxzP3SNCjLarWDvS9HpvFAI1"
Subject: [B.A.T.M.A.N.] patch for manpage batctl.8: Missing description of
 gw_mode sel_class for B.A.T.M.A.N. V
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
--NktFsUUMEcxzP3SNCjLarWDvS9HpvFAI1
Content-Type: multipart/mixed; boundary="Z1cIK1IHh1U6X3Rlx85ph4l1Gz4pQ1ht4";
 protected-headers="v1"
From: Ruben <freifunk@r.z11.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <50dd4215-efd3-2b89-874f-bbf7330bf37a@r.z11.de>
Subject: patch for manpage batctl.8: Missing description of gw_mode sel_class
 for B.A.T.M.A.N. V

--Z1cIK1IHh1U6X3Rlx85ph4l1Gz4pQ1ht4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

This will resolve https://www.open-mesh.org/issues/366


--- /tmp/smartgit7095787147690981841tmp/compare__827356725346254060_batct=
l.8
+++
/tmp/smartgit7095787147690981841tmp/compare__6833548133995178090_batctl.8=

@@ -144,6 +144,9 @@
 If the node is a gateway client the parameter will decide which
criteria to consider when the batman-adv module has to choose
 between different internet connections announced by the aforementioned
servers.
 .RE
+.RS 9
+B.A.T.M.A.N. IV:
+.RE
 .RS 17
 default: 20 \-> late switch (TQ 20)
 .RE
@@ -166,6 +169,19 @@
 .RS 7
 chooses the gateway with the best link quality but switches to another
gateway as soon as a better one is found which is at
 least XX TQ better than the currently selected gateway (XX has to be a
number between 3 and 256).
+.RE
+.RE
+.RS 9
+B.A.T.M.A.N. V:
+.RE
+.RS 17
+default: 5000 \-> late switch (5000 kbit/s throughput)
+example: 1500 \-> fast switch connection
+.RS 16
+switches to another gateway as soon as a better one is found which is
at least
+1500 kbit/s faster throughput than the currently selected gateway.
Throughput is
+determined by evaluating which is lower: the advertised throughput by th=
e
+gateway or the maximum bandwidth across the entire path.
 .RE
 .RE
 .br


--Z1cIK1IHh1U6X3Rlx85ph4l1Gz4pQ1ht4--

--NktFsUUMEcxzP3SNCjLarWDvS9HpvFAI1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEc4/4iBsWuuBVYgULkXRByBJwXLAFAlv9O/UACgkQkXRByBJw
XLBwEw/+PYRwy2SxG6/jcy+NqokJz4s6clIZa864Ri187W4DjmxGbIz7A3iGdPJW
xwGs6o/ZpPdF4LnbqdKad0c8K69hSpTTvxG6+ziKRmgm5lrI5XXRv/CUxloQH8co
3P87Q8F3Wu2QI+dntgMugfQVN2p8zkEs2aEavkQtYaM1WKj8r0FhR39kreqOCcKA
YQvLXFNnOXMjNgr0hEGitZJXNOIXy1AJ5T+s+MnM3d0du8uRnCV/OHmh/tuJ4oq9
tNAMnmcGyQfPBv2S9ON0IHj7zpu2tYb5t26vZYtxELI9FFRyEHXUKMYbhOuev7QM
sArYcbA8cZbO5xPsxQT6eT91Vf4hib04cAohEmX+Km3Aj8hqGVox7MqwWRhkvSGU
aBxYFcK+RIkcG8mZrSBMo4thOac/iH1Hsl/tsjjdDgLX7zEnoWHOlD/LcLuGguNQ
+HqxWKdjz8ZjNr6TBbPdfYj6lIARZ3CqgSToD6RPx8fLujkUW3ZjjtmrfbI0i+2d
eSDGn5fI0UPVwmh1k0HPg83UzbzUMBnAqY1khPVxyifKpP42991+bqrSNNL3KcLM
KGADADkS82jygpbiLQsCDA/K1ILGntjzgxKLuT8xgr8E1soLTwmea5IxRrh5IVpg
JRMlgElStdj0/Ega0Mgnitb8tootxtw25Z34pNvfF3IDwHnbDkk=
=dKfR
-----END PGP SIGNATURE-----

--NktFsUUMEcxzP3SNCjLarWDvS9HpvFAI1--
