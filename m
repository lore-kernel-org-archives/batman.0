Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Network stops passing traffic randomly
Date: Mon, 25 May 2020 10:43:07 +0200
Message-ID: <32459667.Id32LJz2i1@bentobox>
In-Reply-To: <20200525083512.832.13419@diktynna.open-mesh.org>
References: <20200525083512.832.13419@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8417396.2dMom07RQP"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: smartwires@gmail.com

 
--nextPart8417396.2dMom07RQP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 25 May 2020 10:35:12 CEST smartwires@gmail.com wrote:
> I have been battling a weird problem recently, I have this problem occurring on two (2) separate networks, one with 2 nodes and the other with 3 nodes. What happens is the network is fine and all of a sudden the clients can not reach the Internet, This what I have observed. on both Openwrt 19.07, 18.07. A reboot of the gateway corrects the problem. 
[...]
> root@Main-GW:~# batctl ping e8:5b:b7:00:10:6b
> PING e8:5b:b7:00:10:6b (e8:5b:b7:00:10:6b) 20(48) bytes of data
> Reply from host e8:5b:b7:00:10:6b timed out
> Reply from host e8:5b:b7:00:10:6b timed out
> Reply from host e8:5b:b7:00:10:6b timed out
> Reply from host e8:5b:b7:00:10:6b timed out

My first guess is that the underlying interfaces (mesh0) stopped to transport 
unicast frames. Did you check this by setting an IP on mesh0 and ping between 
these devices using the IPv4 ping?

Kind regards,
	Sven
--nextPart8417396.2dMom07RQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl7LhRsACgkQXYcKB8Em
e0ZZ9BAApJphhuF1Q6NwcyBzSd404f2r8UPhQivsvY7uDtJUr5prTBdX+/QFapJV
ELwck41pk8cuT5SXPATOY9nEXF1Z46YqOQVlrIgo0QlDiBSde+6ZJYOmNsgcklEY
CQTC7tB8FNCjX6upHS0Z3qn/2RTvbUV1jbaf5eCwLArC40f17cDWsMOpSlWK1zcS
YKUY5INcFy5FG5n6YTfvFkzVovlbvPTn8B+ciZzZb8PBeCJ9h48fw8lsosnkMfo2
9zsj18SslvsENfvRiQzsCzfuSynPoJil7GnsBqaLoSLTVYyymxEOy5iBOE9tOudi
riKzM4uHE6xo5GEHyBW1xxd1J7kh3v2tkVQs5StNUTXskt58whCY1XsmJmidrjA0
7hacaWiw0DvBcGA9OzgSPdQVT47YRrg9kxSLHKnZlRRC7CiLu2NCKq1TmVhiTts4
sE5slG2ix0iVpK/d/AQ0eYqlnXMUB+XyRbiqR3lSn4mApfp9FBQ48xwYB02sVjsC
viKX1BFq2G8rYs77uDBF76+SOveI+vTRXVj9nDxxJa+PjFHKnwtZsacnQIB8YaRW
MZl44+rb1YaC3UG9rOpJzpublpnen7rI5z8IEBctFO/9riWE8XdI6+CIxzsQww4k
AVT8kPCEksIWkqc3H431Ga0o129AoY2D8NGTZt9XFYdZoe0m7xI=
=Ri7A
-----END PGP SIGNATURE-----

--nextPart8417396.2dMom07RQP--


