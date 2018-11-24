Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 24 Nov 2018 10:44:18 +0100
Message-ID: <2704410.j1Xe82xyVQ@sven-edge>
In-Reply-To: <20181124092955.GA2511@nanopsycho.orion>
References: <20181123161359.13342-1-sven@narfation.org>
 <20181124092955.GA2511@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4720857.0jY8G4Husf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 00/19] batman-adv: netlink restructuring, part 2
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org

--nextPart4720857.0jY8G4Husf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 24. November 2018 10:29:55 CET Jiri Pirko wrote:
[...]
> This looks great. Nice job!
> 
> Do you have a userspace app to communicate with this? Would be nice to
> play with it or at least to see examples of usage.

I have only published the the mcast parsing portion [1] because the 
application would first need to get a more complex compatibility layer to 
support netlink and sysfs at the same time.

And I will definitely not spend the time in implementing this kind of stuff 
when the kernel part is potentially rejected again. But you can get some infos 
about functionality of the sysfs implementation in the manpage [2].

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/17659/
[2] https://manpages.debian.org/stretch/batctl/batctl.8.en.html
--nextPart4720857.0jY8G4Husf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlv5HXIACgkQXYcKB8Em
e0YEKA//XD5eq47UZdr/UCSuI3VtbD1QpnkvFuCmq/POfeLfOqjQRzHdSINIws6v
oSdixy59seSuxnJBabaXbPLSP3PxQ8BEBL2dU3GiDZmnFawbCCQ62DBhOgn83jzc
bqcZufLZOPsDVuIFuI18DIXIcRy0J/NxywaF8sWlf2lF6oimkKhRYB36Lrk3Li5O
qG+rkEQq4WUqm5HBhd+Zgc904JNDww88p/La9md5byhifLLjS1e39XBWEF2kXoUF
fS7Z5nvN18hGwuZopscEhjSl0Z0AeCcYIEBfYrDLm8DVaM7blxO5NNwH4RxlqW+J
eb2ni6IG98iAWBoii1Q/E14zYCfF1xWfCdn0atDZr97IPTcMwgrtcRJ9Fb47qR9P
9buXKBmajM5pW7mwCAd3YuX9gDwmFA6EJYjTov5qY/QMrOexvM05ddVRE0nuDdiT
hXbgVl0OIQNf6mgqHbS7895luwH9g6QiheX1GaxnXh3EZLUBQPtckTVbny6OcmLn
QoBJu/s1OXDIBUqexOCrWCh2MqleIafh3k3UQaele0CEVCqS3jSVJC4zaNS2GCeQ
eRt4Q70C9ZUI8NwZenHYcNmzPjbuJVd/6gyJRZzPN/5sBaYacbCVhbVcoWBJBGyB
1MnA2wY6gEl2cm3ptMnh7sw5QA2gBwHcMgoUEdAsV/2dCO3i3wY=
=LxfK
-----END PGP SIGNATURE-----

--nextPart4720857.0jY8G4Husf--



