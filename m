Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Feb 2016 22:24:54 +0100
Message-ID: <1634608.JnebRjFf2I@sven-edge>
In-Reply-To: <1456492697-29708-1-git-send-email-apape@phoenixcontact.com>
References: <1456492697-29708-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2575096.JVd4Benq6q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/7] batman-adv: speed up dat by
	snooping received ip traffic
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

--nextPart2575096.JVd4Benq6q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 February 2016 14:18:17 Andreas Pape wrote:
> +                       if (vhdr->h_vlan_encapsulated_proto == ETH_P_IP) {

Either you htons the ETH_P_IP or you have to ntohs the
vhdr->h_vlan_encapsulated_proto. But one of them has to converted to the byte 
order of the other one.

Kind regards,
	Sven
--nextPart2575096.JVd4Benq6q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0MKmAAoJEF2HCgfBJntGcbAQAI1v8XKYJcoLffPutgvBMZRb
o2M4xTQQUanFjc85dK8Yw9wCjmh8i3uK2J8EHGKcCMoPWxXHsR7biH8etc8sOcPe
y3vB5Yj89oGgl2oEKmUncaRxpziHhpXB/LjG0pdXBu4kVSOALfl5JXYg4zl+NdoW
CJWsz1nT2Xm0KeCMezbz/y4XtfNLrkObFqUxfciogQ8W+R/MHrLVTPvVPjwcdtYX
CYpIdHdhlKrfUDo5w4DiT+K1k2XNqDQM8hu8fnJxE3rl/mW76ZmfiTwkJWtjMsRR
h0hXZVr7iKX9UZ8bG/5ogW/+vugC7g4HARHDsqHcBjCOE6E4TlJMGG9jF3TdgQEX
w44od0OaTOyQJXh1ncTdRQrac9UaOQEabsyHOWq7tjibzzTGIPQ9/7ajGKXc3xyW
MZDO7VbsyrGi0eCeohVrnT5WoLR4Zlb8UJsOj7MqJqcuqREt7mH8ZJpjZY4a1rVb
9DDq+tDWBiiiVckm09OmmRVEke7+lSdmhngXt9dRjF7ltMUA4GuwESsBJA6fMjUa
DXeaBaRVOBzL7zCbaRnTZ0dDd4TzMa5iGXxr/V6DMbA0huqj9UePkE9EqwVoGN1N
pKngptGl90leChsz/+iRuGjhW9JrxbS0NI7XaW3qdK7EBcuMU6XgoPnB9rlaSa+0
hGMmr3e/1fiVEC37bgjN
=q7mX
-----END PGP SIGNATURE-----

--nextPart2575096.JVd4Benq6q--

