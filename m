Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:07:10 +0100
Message-ID: <2527763.cX7mnL5d4j@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1493157.xdLuNoaAub";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH 0/4] batctl: Minor cleanups related to tcpdump
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

--nextPart1493157.xdLuNoaAub
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

here are just some random cleanups/fixes for things I've noticed while having 
a look at https://www.open-mesh.org/issues/298.

      batctl: tcpdump: Reset socket state on initialization error
      batctl: tcpdump: Free resources on SIG(TERM|INT)
      batctl: ping: Use sig_atomic_t variable to stop ping
      batctl: Simplify standard error messages with perror

Kind regards,
	Sven
--nextPart1493157.xdLuNoaAub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliEoG4ACgkQXYcKB8Em
e0bHxA/9GF0eRsxNOFMr5GVxNMSoT4eMAPu0Ow7uxi/AKZdtCq1xsQloKDNJ17K9
UMKQCvc49HuabtCoEHmP36ZTmzDgxyO35FxsDcNDoejaN7DFFQFLOJuYtVm9JVbI
jfxPTU1H0jzH6nNQVeAYtRNKWRKaVz6tcvkamOLMjZxad/DVUqqTp3gbv58K4jS0
/Qf08JFdqeudZUR0ZGKVFPdBrQgDYN39HNoxnnQIfou9lOcUcPzyy6iQzyqUzz/e
SmFGKbRXlyosKnOThyhmvtDtoEcefbC2uU2fRtcgaVn05iCk4W84ggGzrGictqYl
drKqJ53eMiMNKlaAgyDLu+B2tqbBj2Ur+cG2tvc9N+yRSAg2h2KHI6nS7Ic8qz0Q
K2w5z+cHe/duXYMxtewJm7Q8EIWNtU+3jhTkf+Ve7066OT8NuHtnsvYN3HmaI8M+
V7/7cAUqvk1ztPAIubSUStNrtve/zhb1h2EkTYEyK0OcfAclmL7E/T8wUaVNlap+
n0gluZobJjgH4DnY17TXsKkJHg7tM2CxQNHhvJfJl3RGNyNWKWeA1+jvHPBnziXD
iaPxvx+HoGpMk5t95L5gdHNxxIUAoQyxq76bqtZeuvEgep+hWCLujQlTbclG/Z9M
Vv+sYZXyTRxfcXcuHXaF9FSlb+2dhakd8/W7/emsCa6f3IIf9WY=
=9dgb
-----END PGP SIGNATURE-----

--nextPart1493157.xdLuNoaAub--

